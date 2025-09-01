# Set up Supabase with Netlify Astro template

In this guide we’re going to install and configure the Supabase Netlify extension, create Supabase project and fill the database with data.

## Set up Supabase database

1. Create Supabase account at [Supabase.com](https://supabase.com).
2. After signing up to your Supabase account, click New project from your dashboard. Select your organization, give the project a name, generate a new password for the database, and select the us-east-1 region.

## Create the frameworks table

Once the database is provisioned, we can create the **frameworks** table. From your project dashboard, open the SQL editor.

![Create the frameworks table](/public/images/guides/supabase-netlify-sql-editor.png)

Run the following commands in the SQL editor to create the **frameworks** table.

```sql
CREATE TABLE frameworks (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  name TEXT NOT NULL,
  url TEXT NOT NULL,
  description TEXT NOT NULL,
  logo TEXT NOT NULL,
  likes INTEGER NOT NULL DEFAULT 0,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);
```

## Add data

Next, let’s add some starter data to the **frameworks** table. From the Table Editor in Supabase (1), choose the **frameworks** table from the list (2) and then select **Insert > Import** data from CSV (3).

![Create the frameworks table](/public/images/guides/supabase-netlify-import-csv.png)

Paste the following data:

```sql
name,url,logo,likes,description
Astro,https://astro.build/,astro.svg,0,"Astro is a fresh but familiar approach to building websites. Astro combines decades of proven performance best practices with the DX improvements of the component-oriented era."
Eleventy,https://svelte.dev/,eleventy.svg,0,"Eleventy (11ty) is a flexible, minimalist static site generator that builds fast, content-driven websites using multiple templating languages and a zero-client-JavaScript philosophy."
Gatsby,https://www.gatsbyjs.com/,gatsby.svg,0,"Gatsby.js is a React-based framework for building fast, SEO-friendly websites and applications with powerful data integration and static site generation capabilities."
Next,https://nextjs.org/,next.svg,0,"Next.js enables you to create high-quality web applications with the power of React components."
Nuxt,https://nuxt.com/,nuxt.svg,0,"Nuxt is an open source framework that makes web development intuitive and powerful. Create performant and production-grade full-stack web apps and websites with confidence."
Remix,https://remix.run/,remix.svg,0,"Remix is a React framework designed for server-side rendering (SSR). Is a full-stack web framework, allowing developers to build both backend and frontend within a single app."
Svelte,https://svelte.dev/,svelte.svg,0,"Svelte is a UI framework that uses a compiler to let you write breathtakingly concise components that do minimal work in the browser, using languages you already know — HTML, CSS and JavaScript."
```

This will give you a preview of the data that will be inserted into the database. Click **Import data** to add the data to the database.

## Install the Supabase Netlify extension

Now we can install the [Supabase extension](https://app.netlify.com/extensions/supabase). In the Netlify UI, go to your team’s dashboard, navigate to **Extensions** and click on the Supabase extension. Click the install button to install the extension.

### Configure the Supabase extension

After the extension is installed, navigate to the Supabase template site that you deployed, and go to **Site configuration**. In the **General** settings, you will see a new **Supabase** section. Click **Connect** to connect your Netlify site to your Supabase account using OAuth.

![Configure the Supabase extension](/public/images/guides/supabase-netlify-connect-oauth.png)

Once you’ve completed this process, return to the Supabase section of your site configuration, and choose the project you just created in Supabase. And make sure to choose Astro for the framework since the template is built with Astro.

![Supabase Netlify extension configuration](/public/images/guides/supabase-netlify-extension-configuration.png)

## Deploy the site again

Now that the extension is configured, we can deploy the site again. Got to **Deploys** (1) and click the **Deploy site** (2) button to deploy the site. 

![Supabase Netlify extension configuration](/public/images/guides/deploy-button.png)

Once the build is complete, navigate to your production URL and you should see the **frameworks** that we just added to the database.

![Template with data](/public/images/guides/web-frameworks.png)

import React, { useEffect, useMemo, useState } from "react";
import { Info, ChevronLeft, ChevronRight, Smartphone, Save, RefreshCcw, HelpCircle } from "lucide-react";

// Single-file wireframe for a mortgage calculator flow
// Focus: clarity, guidance, mobile-first, a11y, and resilience (autosave)
// Notes: This is a wireframe (no real finance maths). Replace placeholders with real logic later.

const steps = [
  { key: "profile", label: "Your Details" },
  { key: "property", label: "Property" },
  { key: "loan", label: "Loan" },
  { key: "results", label: "Results" },
];

const initialData = {
  income: "",
  deposit: "",
  price: "",
  rate: 5,
  term: 25,
  type: "repayment",
  taxes: true,
  insurance: false,
};

export default function MortgageCalculatorWireframe() {
  const [stepIndex, setStepIndex] = useState(0);
  const [data, setData] = useState(initialData);
  const [errors, setErrors] = useState({});
  const [glossaryOpen, setGlossaryOpen] = useState(false);
  const [saving, setSaving] = useState(false);

  // --- Autosave to localStorage (addresses: inputs lost on refresh) ---
  useEffect(() => {
    const raw = localStorage.getItem("mortgage-wireframe");
    if (raw) {
      try { setData({ ...initialData, ...JSON.parse(raw) }); } catch {}
    }
  }, []);

  useEffect(() => {
    setSaving(true);
    const t = setTimeout(() => {
      localStorage.setItem("mortgage-wireframe", JSON.stringify(data));
      setSaving(false);
    }, 300);
    return () => clearTimeout(t);
  }, [data]);

  const canNext = useMemo(() => {
    if (stepIndex === 0) return data.income && Number(data.income) > 0;
    if (stepIndex === 1) return data.price && Number(data.price) > 0 && data.deposit !== "";
    if (stepIndex === 2) return data.rate >= 0 && data.term > 0;
    return true;
  }, [stepIndex, data]);

  const goNext = () => setStepIndex((i) => Math.min(i + 1, steps.length - 1));
  const goPrev = () => setStepIndex((i) => Math.max(i - 1, 0));

  // --- Very rough placeholder maths for the wireframe UI ---
  const monthly = useMemo(() => {
    const price = Number(data.price) || 0;
    const deposit = Number(data.deposit) || 0;
    const principal = Math.max(price - deposit, 0);
    const termMonths = (Number(data.term) || 0) * 12;
    const r = (Number(data.rate) || 0) / 100 / 12;
    if (!principal || !termMonths) return 0;
    if (r === 0) return principal / termMonths;
    return (principal * r) / (1 - Math.pow(1 + r, -termMonths));
  }, [data]);

  const affordabilityFlag = useMemo(() => {
    const inc = Number(data.income) || 0;
    if (!inc || !monthly) return null;
    const ratio = monthly / (inc / 12);
    if (ratio > 0.45) return "high";
    if (ratio > 0.30) return "medium";
    return "ok";
  }, [monthly, data.income]);

  // --- Accessible Field component ---
  function Field({ id, label, hint, error, children }) {
    return (
      <div className="mb-5">
        <label htmlFor={id} className="block text-sm font-medium mb-1">
          {label}
        </label>
        {children}
        {(hint || error) && (
          <div className="mt-1 text-xs" aria-live="polite">
            {error ? (
              <span className="text-red-600">{error}</span>
            ) : (
              <span className="text-gray-500">{hint}</span>
            )}
          </div>
        )}
      </div>
    );
  }

  // --- Stepper ---
  function Stepper() {
    return (
      <nav aria-label="Progress" className="mb-6">
        <ol className="grid grid-cols-4 gap-2">
          {steps.map((s, i) => (
            <li key={s.key}>
              <button
                className={`w-full rounded-2xl border px-3 py-2 text-left text-sm transition focus:outline-none focus:ring ${
                  i === stepIndex
                    ? "bg-black text-white border-black"
                    : i < stepIndex
                    ? "bg-gray-900 text-white border-gray-900"
                    : "bg-white text-gray-700 border-gray-300"
                }`}
                onClick={() => setStepIndex(i)}
                aria-current={i === stepIndex ? "step" : undefined}
              >
                <div className="flex items-center justify-between">
                  <span>{i + 1}. {s.label}</span>
                  {i < stepIndex ? <RefreshCcw className="h-4 w-4" aria-hidden="true"/> : null}
                </div>
              </button>
            </li>
          ))}
        </ol>
      </nav>
    );
  }

  // --- Glossary Drawer ---
  function Glossary() {
    if (!glossaryOpen) return null;
    return (
      <div role="dialog" aria-modal="true" aria-label="Mortgage glossary" className="fixed inset-0 z-50 flex">
        <div className="flex-1 bg-black/40" onClick={() => setGlossaryOpen(false)} />
        <div className="w-full max-w-md bg-white h-full shadow-2xl p-6 overflow-y-auto">
          <div className="flex items-center justify-between mb-4">
            <h2 className="text-lg font-semibold">Glossary</h2>
            <button className="rounded-full p-2 border" onClick={() => setGlossaryOpen(false)} aria-label="Close glossary">✕</button>
          </div>
          <dl className="space-y-4">
            <div>
              <dt className="font-medium">APR</dt>
              <dd className="text-sm text-gray-600">Annual Percentage Rate: yearly cost of your mortgage including fees, shown as a percentage.</dd>
            </div>
            <div>
              <dt className="font-medium">Deposit</dt>
              <dd className="text-sm text-gray-600">Upfront amount you pay towards the property price.</dd>
            </div>
            <div>
              <dt className="font-medium">Term</dt>
              <dd className="text-sm text-gray-600">How long you’ll take to repay the mortgage (in years).</dd>
            </div>
            <div>
              <dt className="font-medium">Repayment vs. Interest-only</dt>
              <dd className="text-sm text-gray-600">Repayment pays interest and principal each month; interest-only pays interest now and principal later.</dd>
            </div>
          </dl>
        </div>
      </div>
    );
  }

  // --- Panels ---
  function StepProfile() {
    return (
      <section aria-labelledby="step-profile">
        <h2 id="step-profile" className="sr-only">Your Details</h2>
        <Field id="income" label="Household annual income" hint="Before tax" error={errors.income}>
          <input
            id="income"
            inputMode="decimal"
            className="w-full rounded-xl border px-3 py-2"
            placeholder="e.g. 65,000"
            value={data.income}
            onChange={(e) => setData({ ...data, income: e.target.value.replace(/[^\d.]/g, "") })}
          />
        </Field>
        <Field id="type" label="Mortgage type" hint="Choose repayment for predictable balance reduction">
          <div className="flex gap-3">
            {(["repayment", "interest-only"]).map((t) => (
              <label key={t} className={`inline-flex items-center gap-2 rounded-xl border px-3 py-2 cursor-pointer ${data.type === t ? "border-black" : "border-gray-300"}`}>
                <input
                  type="radio"
                  name="type"
                  className="accent-black"
                  checked={data.type === t}
                  onChange={() => setData({ ...data, type: t })}
                />
                <span className="text-sm capitalize">{t}</span>
              </label>
            ))}
          </div>
        </Field>
      </section>
    );
  }

  function StepProperty() {
    return (
      <section aria-labelledby="step-property">
        <h2 id="step-property" className="sr-only">Property</h2>
        <Field id="price" label="Property price" error={errors.price}>
          <input
            id="price"
            inputMode="decimal"
            className="w-full rounded-xl border px-3 py-2"
            placeholder="e.g. 350,000"
            value={data.price}
            onChange={(e) => setData({ ...data, price: e.target.value.replace(/[^\d.]/g, "") })}
          />
        </Field>
        <Field id="deposit" label="Deposit" hint="Amount you’ll pay upfront" error={errors.deposit}>
          <input
            id="deposit"
            inputMode="decimal"
            className="w-full rounded-xl border px-3 py-2"
            placeholder="e.g. 70,000"
            value={data.deposit}
            onChange={(e) => setData({ ...data, deposit: e.target.value.replace(/[^\d.]/g, "") })}
          />
        </Field>
        <div className="flex items-center gap-3">
          <label className="inline-flex items-center gap-2">
            <input type="checkbox" className="accent-black" checked={data.taxes} onChange={(e) => setData({ ...data, taxes: e.target.checked })} />
            <span className="text-sm">Include property taxes</span>
          </label>
          <label className="inline-flex items-center gap-2">
            <input type="checkbox" className="accent-black" checked={data.insurance} onChange={(e) => setData({ ...data, insurance: e.target.checked })} />
            <span className="text-sm">Include insurance</span>
          </label>
        </div>
      </section>
    );
  }

  function StepLoan() {
    return (
      <section aria-labelledby="step-loan">
        <h2 id="step-loan" className="sr-only">Loan</h2>
        <Field id="rate" label={`Interest rate: ${data.rate}%`} hint="Adjust to compare scenarios">
          <input
            id="rate"
            type="range"
            min={0}
            max={15}
            step={0.05}
            value={data.rate}
            onChange={(e) => setData({ ...data, rate: Number(e.target.value) })}
            className="w-full"
            aria-valuemin={0}
            aria-valuemax={15}
            aria-valuenow={data.rate}
          />
        </Field>
        <Field id="term" label={`Term: ${data.term} years`} hint="Most common terms are 20–30 years">
          <input
            id="term"
            type="range"
            min={5}
            max={40}
            step={1}
            value={data.term}
            onChange={(e) => setData({ ...data, term: Number(e.target.value) })}
            className="w-full"
            aria-valuemin={5}
            aria-valuemax={40}
            aria-valuenow={data.term}
          />
        </Field>
      </section>
    );
  }

  function StepResults() {
    return (
      <section aria-labelledby="step-results">
        <h2 id="step-results" className="sr-only">Results</h2>
        <div className="rounded-2xl border p-4">
          <div className="flex items-center justify-between">
            <div>
              <p className="text-sm text-gray-600">Estimated monthly payment</p>
              <p className="text-3xl font-semibold mt-1">£{monthly ? monthly.toLocaleString(undefined, { maximumFractionDigits: 0 }) : "—"}</p>
            </div>
            <div className="text-right">
              <p className="text-sm text-gray-600">Interest rate</p>
              <p className="text-lg font-medium">{data.rate}%</p>
              <p className="text-sm text-gray-600 mt-1">Term</p>
              <p className="text-lg font-medium">{data.term} years</p>
            </div>
          </div>

          <div className="mt-4 grid grid-cols-1 md:grid-cols-3 gap-3">
            <div className="rounded-xl border p-3">
              <p className="text-sm">If rate −1%</p>
              <p className="text-lg font-medium">£{scenarioDelta(-1, data, monthly)}</p>
            </div>
            <div className="rounded-xl border p-3">
              <p className="text-sm">If rate +1%</p>
              <p className="text-lg font-medium">£{scenarioDelta(1, data, monthly)}</p>
            </div>
            <div className="rounded-xl border p-3">
              <p className="text-sm">If term +5y</p>
              <p className="text-lg font-medium">£{termDelta(5, data, monthly)}</p>
            </div>
          </div>

          <div className="mt-4 rounded-xl bg-gray-50 p-3 text-sm">
            <p className="flex items-start gap-2"><Info className="mt-0.5 h-4 w-4" aria-hidden="true"/> Your results are estimates. Fees, taxes and your credit profile can change the final offer.</p>
          </div>
        </div>

        <div className="mt-4" role="status" aria-live="polite">
          {affordabilityFlag === "high" && <p className="text-red-700 text-sm">Warning: the payment may be high relative to your income.</p>}
          {affordabilityFlag === "medium" && <p className="text-amber-700 text-sm">Note: consider a longer term or larger deposit to reduce monthly cost.</p>}
          {affordabilityFlag === "ok" && <p className="text-green-700 text-sm">This payment looks reasonable versus your income.</p>}
        </div>
      </section>
    );
  }

  return (
    <div className="min-h-screen bg-white text-gray-900">
      <header className="sticky top-0 z-40 border-b bg-white/70 backdrop-blur">
        <div className="mx-auto max-w-5xl px-4 py-3 flex items-center justify-between">
          <div className="flex items-center gap-2">
            <Smartphone className="h-5 w-5" aria-hidden="true"/>
            <h1 className="text-lg font-semibold">Mortgage Calculator (Wireframe)</h1>
          </div>
          <div className="flex items-center gap-2">
            <button className="rounded-xl border px-3 py-1.5 text-sm" onClick={() => setGlossaryOpen(true)}>
              <span className="inline-flex items-center gap-1"><HelpCircle className="h-4 w-4"/> Glossary</span>
            </button>
            <div className="text-xs text-gray-600 flex items-center gap-1" aria-live="polite">
              <Save className="h-4 w-4" aria-hidden="true"/>{saving ? "Saving…" : "Saved"}
            </div>
          </div>
        </div>
      </header>

      <main className="mx-auto max-w-5xl px-4 py-6 grid grid-cols-1 lg:grid-cols-3 gap-6">
        <div className="lg:col-span-2">
          <Stepper />

          <div className="rounded-2xl border p-5">
            {stepIndex === 0 && <StepProfile />}
            {stepIndex === 1 && <StepProperty />}
            {stepIndex === 2 && <StepLoan />}
            {stepIndex === 3 && <StepResults />}

            <div className="mt-6 flex items-center justify-between">
              <button
                className="inline-flex items-center gap-2 rounded-2xl border px-4 py-2 text-sm disabled:opacity-50"
                onClick={goPrev}
                disabled={stepIndex === 0}
              >
                <ChevronLeft className="h-4 w-4"/> Back
              </button>
              <div className="flex items-center gap-3">
                {stepIndex < steps.length - 1 && (
                  <button
                    className="inline-flex items-center gap-2 rounded-2xl bg-black text-white px-4 py-2 text-sm disabled:opacity-50"
                    onClick={goNext}
                    disabled={!canNext}
                  >
                    Next <ChevronRight className="h-4 w-4"/>
                  </button>
                )}
              </div>
            </div>
          </div>
        </div>

        <aside className="lg:col-span-1">
          <div className="rounded-2xl border p-5 sticky top-[76px]">
            <h3 className="text-base font-semibold mb-3">Summary</h3>
            <ul className="space-y-2 text-sm">
              <li className="flex justify-between"><span>Income</span><span>£{fmtNum(data.income)}</span></li>
              <li className="flex justify-between"><span>Price</span><span>£{fmtNum(data.price)}</span></li>
              <li className="flex justify-between"><span>Deposit</span><span>£{fmtNum(data.deposit)}</span></li>
              <li className="flex justify-between"><span>Rate</span><span>{data.rate}%</span></li>
              <li className="flex justify-between"><span>Term</span><span>{data.term}y</span></li>
              <li className="flex justify-between"><span>Type</span><span className="capitalize">{data.type}</span></li>
            </ul>
            <div className="mt-4 rounded-xl bg-gray-50 p-3 text-xs text-gray-600">
              <p>Tip: You can jump between steps using the progress bar above.</p>
            </div>
          </div>
        </aside>
      </main>

      <Glossary />

      <footer className="mx-auto max-w-5xl px-4 pb-8 text-xs text-gray-500">
        <p>Wireframe build for usability review • Keyboard friendly • Accessible labels • Mobile-first</p>
      </footer>
    </div>
  );
}

// --- Helper fns ---
function fmtNum(n) {
  const x = Number(String(n).replace(/[^\d.]/g, ""));
  return x ? x.toLocaleString() : "—";
}

function pmt(principal, ratePct, termYears) {
  const r = (Number(ratePct) || 0) / 100 / 12;
  const n = (Number(termYears) || 0) * 12;
  if (!principal || !n) return 0;
  if (r === 0) return principal / n;
  return (principal * r) / (1 - Math.pow(1 + r, -n));
}

function scenarioDelta(deltaPct, data, base) {
  const price = Number(data.price) || 0;
  const dep = Number(data.deposit) || 0;
  const principal = Math.max(price - dep, 0);
  const v = pmt(principal, (Number(data.rate) || 0) + deltaPct, data.term);
  return v ? Math.round(v).toLocaleString() : "—";
}

function termDelta(deltaYears, data, base) {
  const price = Number(data.price) || 0;
  const dep = Number(data.deposit) || 0;
  const principal = Math.max(price - dep, 0);
  const v = pmt(principal, data.rate, (Number(data.term) || 0) + deltaYears);
  return v ? Math.round(v).toLocaleString() : "—";
}
