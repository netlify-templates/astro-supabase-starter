power-reliable-logistics/
├── index.html
├── style.css
├── script.js
├── images/ (hero-bg.jpg, trucks, logos, etc.)
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Power Reliable Logistics | Fast & Trusted Shipping</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="style.css">
</head>
<body>
    <!-- Navbar -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        <div class="container">
            <a class="navbar-brand" href="#">Power Reliable Logistics</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item"><a class="nav-link" href="#home">Home</a></li>
                    <li class="nav-item"><a class="nav-link" href="#services">Services</a></li>
                    <li class="nav-item"><a class="nav-link" href="#track">Track</a></li>
                    <li class="nav-item"><a class="nav-link" href="#contact">Contact</a></li>
                </ul>
            </div>
        </div>
    </nav>

    <!-- Hero Section -->
    <section id="home" class="hero">
        <div class="container text-center">
            <h1>Powering Your Supply Chain with Precision</h1>
            <p>Fast | Reliable | Global</p>
            <button class="btn btn-primary btn-lg" onclick="openQuoteModal()">Get Instant Quote</button>
        </div>
    </section>

    <!-- Services Section -->
    <section id="services" class="services py-5">
        <div class="container">
            <h2 class="text-center mb-5">Our Services</h2>
            <div class="row" id="servicesContainer"></div>
        </div>
    </section>

    <!-- Tracking Section -->
    <section id="track" class="tracking bg-light py-5">
        <div class="container text-center">
            <h2 class="mb-4">Track Your Shipment</h2>
            <div class="track-form">
                <input type="text" id="trackingNumber" placeholder="Enter Tracking ID">
                <button class="btn btn-secondary" onclick="trackShipment()">Track</button>
            </div>
            <div id="trackResult" class="mt-3"></div>
        </div>
    </section>

    <!-- Quote Modal -->
    <div class="modal fade" id="quoteModal">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Instant Quote Calculator</h5>
                    <button class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <form id="quoteForm">
                        <div class="mb-3">
                            <label>Shipment Weight (kg):</label>
                            <input type="number" id="weight" class="form-control" required>
                        </div>
                        <div class="mb-3">
                            <label>Distance (km):</label>
                            <input type="number" id="distance" class="form-control" required>
                        </div>
                        <button type="submit" class="btn btn-primary">Calculate</button>
                    </form>
                    <div id="quoteResult" class="mt-3"></div>
                </div>
            </div>
        </div>
    </div>

    <!-- Footer -->
    <footer class="bg-dark text-white py-4">
        <div class="container text-center">
            <p>&copy; 2024 Power Reliable Logistics</p>
        </div>
    </footer>

    <!-- Scripts -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="script.js"></script>
</body>
</html> /* Custom Styles */
.hero {
    background: linear-gradient(rgba(0,0,0,0.7), rgba(0,0,0,0.7)), url('images/hero-bg.jpg');
    background-size: cover;
    color: white;
    padding: 150px 0;
}

.services .card {
    transition: transform 0.3s;
    margin: 10px;
}

.services .card:hover {
    transform: translateY(-10px);
}

.tracking input {
    padding: 10px;
    width: 300px;
    margin-right: 10px;
}

#trackResult {
    min-height: 50px;
}

.modal-content {
    background: #f8f9fa;
} // Services Data (Dynamic Loading)
const services = [
    { title: "Freight Shipping", icon: "fa-truck", desc: "Global cargo by air, sea, or land." },
    { title: "Warehousing", icon: "fa-warehouse", desc: "Secure storage solutions." },
    { title: "Last-Mile Delivery", icon: "fa-box", desc: "Fast final-leg delivery." }
];

function loadServices() {
    const container = document.getElementById('servicesContainer');
    let html = '';
    services.forEach(service => {
        html += `
            <div class="col-md-4">
                <div class="card">
                    <div class="card-body text-center">
                        <i class="fas ${service.icon} fa-3x mb-3"></i>
                        <h5>${service.title}</h5>
                        <p>${service.desc}</p>
                    </div>
                </div>
            </div>
        `;
    });
    container.innerHTML = html;
}

// Quote Calculator
document.getElementById('quoteForm').addEventListener('submit', function(e) {
    e.preventDefault();
    const weight = parseFloat(document.getElementById('weight').value);
    const distance = parseFloat(document.getElementById('distance').value);
    const rate = 2.5; // $2.5 per kg/km
    const cost = weight * distance * rate;
    
    document.getElementById('quoteResult').innerHTML = `
        <div class="alert alert-success">
            Estimated Cost: $${cost.toFixed(2)}
        </div>
    `;
});

// Tracking Simulation
function trackShipment() {
    const trackingId = document.getElementById('trackingNumber').value;
    const statuses = ["In Transit", "Out for Delivery", "Delivered"];
    const randomStatus = statuses[Math.floor(Math.random() * statuses.length)];
    
    document.getElementById('trackResult').innerHTML = `
        <div class="alert alert-info">
            Tracking ID: ${trackingId}<br>
            Status: ${randomStatus}
        </div>
    `;
}

// Modal Control
function openQuoteModal() {
    new bootstrap.Modal(document.getElementById('quoteModal')).show();
}

// Initialize Services on Load
window.onload = loadServices; power-reliable-logistics/
├── index.html
├── style.css
├── script.js
├── contact.php (or serverless function)
├── images/ <!-- Tracking Section -->
<section id="track" class="tracking bg-light py-5">
    <div class="container text-center">
        <h2 class="mb-4">Live Shipment Tracking</h2>
        <div id="map" style="height: 400px; width: 100%; margin: 20px 0;"></div>
        <div class="track-form">
            <input type="text" id="trackingNumber" placeholder="Enter Tracking ID">
            <button class="btn btn-secondary" onclick="initMap()">Track</button>
        </div>
    </div>
</section>

<!-- Add Google Maps Script -->
<script src="https://maps.googleapis.com/maps/api/js?key=YOUR_API_KEY&callback=initMap" async defer></script>// Real-Time Map Configuration
let map;
let marker;
let watchId;

function initMap() {
    const trackingId = document.getElementById('trackingNumber').value;
    
    // Initialize Map
    map = new google.maps.Map(document.getElementById('map'), {
        zoom: 10,
        center: { lat: 40.7128, lng: -74.0060 } // Default to New York
    });

    // Simulate Real-Time Movement (Replace with API Data)
    if (marker) marker.setMap(null);
    marker = new google.maps.Marker({ map, position: map.getCenter() });
    
    // Update position every 5 seconds (Demo)
    watchId = setInterval(() => {
        const newPos = {
            lat: marker.getPosition().lat() + Math.random() * 0.01 - 0.005,
            lng: marker.getPosition().lng() + Math.random() * 0.01 - 0.005
        };
        marker.setPosition(newPos);
    }, 5000);
}

// Stop Tracking
function stopTracking() {
    clearInterval(watchId);
}<!-- Contact Section -->
<section id="contact" class="contact py-5">
    <div class="container">
        <h2 class="text-center mb-4">Contact Us</h2>
        <form id="crmForm">
            <div class="mb-3">
                <input type="text" id="name" class="form-control" placeholder="Name" required>
            </div>
            <div class="mb-3">
                <input type="email" id="email" class="form-control" placeholder="Email" required>
            </div>
            <div class="mb-3">
                <input type="tel" id="phone" class="form-control" placeholder="Phone">
            </div>
            <div class="mb-3">
                <textarea id="message" class="form-control" placeholder="Message" rows="4"></textarea>
            </div>
            <button type="submit" class="btn btn-primary">Submit</button>
        </form>
        <div id="crmResponse" class="mt-3"></div>
    </div>
</section>// HubSpot CRM Integration
document.getElementById('crmForm').addEventListener('submit', async (e) => {
    e.preventDefault();
    
    const data = {
        fields: [
            { name: "firstname", value: document.getElementById('name').value },
            { name: "email", value: document.getElementById('email').value },
            { name: "phone", value: document.getElementById('phone').value },
            { name: "message", value: document.getElementById('message').value }
        ],
        context: { pageUri: window.location.href }
    };

    try {
        const response = await fetch('https://api.hubapi.com/crm/v3/objects/contacts', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
                'Authorization': 'Bearer YOUR_HUBSPOT_ACCESS_TOKEN'
            },
            body: JSON.stringify(data)
        });

        if (response.ok) {
            document.getElementById('crmResponse').innerHTML = `
                <div class="alert alert-success">Thank you! We'll contact you shortly.</div>
            `;
        } else {
            throw new Error('CRM submission failed');
        }
    } catch (error) {
        document.getElementById('crmResponse').innerHTML = `
            <div class="alert alert-danger">Error: ${error.message}</div>
        `;
    }
});/* Map Styling */
#map {
    border-radius: 10px;
    box-shadow: 0 0 15px rgba(0,0,0,0.2);
}

/* Contact Form */
#crmForm {
    max-width: 600px;
    margin: 0 auto;
}

#crmForm input, #crmForm textarea {
    margin-bottom: 15px;
}// Connect to WebSocket for actual GPS data
const socket = new WebSocket('wss://your-tracking-server.com');

socket.onmessage = (event) => {
    const data = JSON.parse(event.data);
    marker.setPosition({ lat: data.latitude, lng: data.longitude });
};// Airtable Integration
const AIRTABLE_API_KEY = 'YOUR_KEY';
const BASE_ID = 'YOUR_BASE_ID';

fetch(`https://api.airtable.com/v0/${BASE_ID}/Contacts`, {
    method: 'POST',
    headers: {
        'Authorization': `Bearer ${AIRTABLE_API_KEY}`,
        'Content-Type': 'application/json'
    },
    body: JSON.stringify({ fields: { Name: name, Email: Prlogistics@gmail.com} })
});Frontend (Website) → Google Maps API (Live Tracking)
                   → HubSpot CRM (Lead Management)
                   → Custom Backend (Optional for Advanced Features)Frontend (HTML/JS)
  ↓
Firebase (Auth + Realtime DB)
  ↓
Stripe API (Payments)
  ↓
Cloud Function (Secure Backend)<!-- Auth Buttons -->
<li class="nav-item" id="authLinks">
    <a class="nav-link" href="#" onclick="openAuthModal('login')">Login</a>
    <a class="nav-link" href="#" onclick="openAuthModal('signup')">Sign Up</a>
</li>

<!-- Auth Modal -->
<div class="modal fade" id="authModal">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="authModalTitle">Login</h5>
                <button class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                <form id="authForm">
                    <div class="mb-3">
                        <input type="email" id="authEmail" class="form-control" placeholder="Email" required>
                    </div>
                    <div class="mb-3">
                        <input type="password" id="authPassword" class="form-control" placeholder="Password" required>
                    </div>
                    <button type="submit" class="btn btn-primary w-100">Submit</button>
                </form>
                <div id="authStatus" class="mt-3"></div>
            </div>
        </div>
    </div>
</div>// Firebase Configuration
const firebaseConfig = {
    apiKey: "YOUR_FIREBASE_API_KEY",
    authDomain: "your-project.firebaseapp.com",
    projectId: "your-project",
    storageBucket: "your-project.appspot.com",
    messagingSenderId: "YOUR_SENDER_ID",
    appId: "YOUR_APP_ID"
};

// Initialize Firebase
firebase.initializeApp(firebaseConfig);
const auth = firebase.auth();

// Auth Modal Control
function openAuthModal(type) {
    document.getElementById('authModalTitle').textContent = type === 'login' ? 'Login' : 'Sign Up';
    new bootstrap.Modal(document.getElementById('authModal')).show();
}

// Auth Form Handler
document.getElementById('authForm').addEventListener('submit', (e) => {
    e.preventDefault();
    const email = document.getElementById('authEmail').value;
    const password = document.getElementById('authPassword').value;
    
    if (document.getElementById('authModalTitle').textContent === 'Login') {
        auth.signInWithEmailAndPassword(email, password)
            .then(() => location.reload())
            .catch(error => showAuthError(error));
    } else {
        auth.createUserWithEmailAndPassword(email, password)
            .then(() => location.reload())
            .catch(error => showAuthError(error));
    }
});

// Auth State Listener
auth.onAuthStateChanged(user => {
    const authLinks = document.getElementById('authLinks');
    if (user) {
        authLinks.innerHTML = `
            <div class="dropdown">
                <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown">
                    ${user.email}
                </a>
                <ul class="dropdown-menu">
                    <li><a class="dropdown-item" href="#" onclick="auth.signOut()">Logout</a></li>
                </ul>
            </div>
        `;
    }
});

function showAuthError(error) {
    document.getElementById('authStatus').innerHTML = `
        <div class="alert alert-danger">${error.message}</div>
    `;
}// Firebase Configuration
const firebaseConfig = {
    apiKey: "YOUR_FIREBASE_API_KEY",
    authDomain: "your-project.firebaseapp.com",
    projectId: "your-project",
    storageBucket: "your-project.appspot.com",
    messagingSenderId: "YOUR_SENDER_ID",
    appId: "YOUR_APP_ID"
};

// Initialize Firebase
firebase.initializeApp(firebaseConfig);
const auth = firebase.auth();

// Auth Modal Control
function openAuthModal(type) {
    document.getElementById('authModalTitle').textContent = type === 'login' ? 'Login' : 'Sign Up';
    new bootstrap.Modal(document.getElementById('authModal')).show();
}

// Auth Form Handler
document.getElementById('authForm').addEventListener('submit', (e) => {
    e.preventDefault();
    const email = document.getElementById('authEmail').value;
    const password = document.getElementById('authPassword').value;
    
    if (document.getElementById('authModalTitle').textContent === 'Login') {
        auth.signInWithEmailAndPassword(email, password)
            .then(() => location.reload())
            .catch(error => showAuthError(error));
    } else {
        auth.createUserWithEmailAndPassword(email, password)
            .then(() => location.reload())
            .catch(error => showAuthError(error));
    }
});

// Auth State Listener
auth.onAuthStateChanged(user => {
    const authLinks = document.getElementById('authLinks');
    if (user) {
        authLinks.innerHTML = `
            <div class="dropdown">
                <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown">
                    ${user.email}
                </a>
                <ul class="dropdown-menu">
                    <li><a class="dropdown-item" href="#" onclick="auth.signOut()">Logout</a></li>
                </ul>
            </div>
        `;
    }
});

function showAuthError(error) {
    document.getElementById('authStatus').innerHTML = `
        <div class="alert alert-danger">${error.message}</div>
    `;
}<!-- Payment Section (Protected Content) -->
<section id="payment" class="py-5" style="display: none;">
    <div class="container text-center">
        <h2>Pay Invoice</h2>
        <div id="paymentForm">
            <div id="cardElement" class="my-3"></div>
            <button id="payButton" class="btn btn-success">Pay $100.00</button>
        </div>
        <div id="paymentStatus" class="mt-3"></div>
    </div>
</section>

<!-- Add Stripe.js -->
<script src="https://js.stripe.com/v3/"></script>// Stripe Configuration
const stripe = Stripe('YOUR_STRIPE_PUBLIC_KEY');
let cardElement;

// Initialize Stripe Elements
function initStripe() {
    const elements = stripe.elements();
    cardElement = elements.create('card');
    cardElement.mount('#cardElement');
}

// Handle Payment
document.getElementById('payButton').addEventListener('click', async () => {
    const { paymentMethod, error } = await stripe.createPaymentMethod({
        type: 'card',
        card: cardElement
    });

    if (error) {
        document.getElementById('paymentStatus').innerHTML = `
            <div class="alert alert-danger">${error.message}</div>
        `;
    } else {
        // Call Cloud Function to process payment
        const response = await fetch('YOUR_CLOUD_FUNCTION_URL', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({
                paymentMethodId: paymentMethod.id,
                amount: 10000 // $100 in cents
            })
        });

        const result = await response.json();
        if (result.success) {
            document.getElementById('paymentStatus').innerHTML = `
                <div class="alert alert-success">Payment successful!</div>
            `;
        }
    }
});

// Show Payment Section to Logged-In Users
auth.onAuthStateChanged(user => {
    if (user) {
        document.getElementById('payment').style.display = 'block';
        initStripe();
    }
});const functions = require('firebase-functions');
const Stripe = require('stripe')(process.env.STRIPE_SECRET_KEY);

exports.processPayment = functions.https.onRequest(async (req, res) => {
    try {
        const { paymentMethodId, amount } = req.body;
        
        const paymentIntent = await Stripe.paymentIntents.create({
            amount: amount,
            currency: 'usd',
            payment_method: paymentMethodId,
            confirm: true
        });

        res.json({ success: true, id: paymentIntent.id });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
}); rules_version = '2';
   service cloud.firestore {
     match /databases/{database}/documents {
       match /users/{userId} {
         allow read, write: if request.auth != null && request.auth.uid == userId;
       }
     }
   } power-reliable-logistics/
├── lang/
│   ├── en.json (English)
│   ├── ig.json (Igbo)
│   ├── ha.json (Hausa)
│   └── yo.json (Yoruba) {
  "homeTitle": "Power Reliable Logistics",
  "homeSubtitle": "Fast | Reliable | Global",
  "getQuote": "Get Instant Quote",
  "trackShipment": "Track Your Shipment",
  "servicesTitle": "Our Services"
} {
  "homeTitle": "Ụlọ Ọrụ Mbupu Dị Iche",
  "homeSubtitle": "Ọsọ | A pụrụ ịdabere na ya | Global",
  "getQuote": "Nweta ọnụahịa ozugbo",
  "trackShipment": "Soro mbupu gị",
  "servicesTitle": "Ọrụ Anyị"
} {
  "homeTitle": "Kamfanin Jigilar Kaya Mai Aminci",
  "homeSubtitle": "Sauri | Amincewa | Duniya",
  "getQuote": "Samu Farashin Nan take",
  "trackShipment": "Bi diddigin Kaya",
  "servicesTitle": "Ayyukanmu"
} {
  "homeTitle": "Ile-iṣẹ Gbigbe Erọlọrun",
  "homeSubtitle": "Yara | Ni igbẹkẹle | Agbaye",
  "getQuote": "Gba iye owo lẹsẹkẹsẹ",
  "trackShipment": "Ṣe ayẹwo ẹru rẹ",
  "servicesTitle": "Awọn iṣẹ wa"
} <!-- Language Selector -->
<li class="nav-item dropdown">
  <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown">
    🌐 Language
  </a>
  <ul class="dropdown-menu">
    <li><a class="dropdown-item" href="#" data-lang="en">English</a></li>
    <li><a class="dropdown-item" href="#" data-lang="ig">Igbo</a></li>
    <li><a class="dropdown-item" href="#" data-lang="ha">Hausa</a></li>
    <li><a class="dropdown-item" href="#" data-lang="yo">Yoruba</a></li>
  </ul>
</li> // Language Configuration
let currentLang = 'en';

// Load Language File
async function loadLanguage(lang) {
  try {
    const response = await fetch(`lang/${lang}.json`);
    const translations = await response.json();
    applyTranslations(translations);
    currentLang = lang;
    localStorage.setItem('selectedLang', lang);
  } catch (error) {
    console.error('Error loading language:', error);
  }
}

// Apply Translations to DOM
function applyTranslations(translations) {
  document.querySelectorAll('[data-i18n]').forEach(element => {
    const key = element.getAttribute('data-i18n');
    element.textContent = translations[key];
  });
}

// Language Switcher Event Listeners
document.querySelectorAll('.dropdown-item[data-lang]').forEach(btn => {
  btn.addEventListener('click', (e) => {
    e.preventDefault();
    const lang = e.target.getAttribute('data-lang');
    loadLanguage(lang);
  });
});

// Initialize Language
const savedLang = localStorage.getItem('selectedLang') || navigator.language.slice(0,2);
loadLanguage(['en','ig','ha','yo'].includes(savedLang) ? savedLang : 'en'); // Language Configuration
let currentLang = 'en';

// Load Language File
async function loadLanguage(lang) {
  try {
    const response = await fetch(`lang/${lang}.json`);
    const translations = await response.json();
    applyTranslations(translations);
    currentLang = lang;
    localStorage.setItem('selectedLang', lang);
  } catch (error) {
    console.error('Error loading language:', error);
  }
}

// Apply Translations to DOM
function applyTranslations(translations) {
  document.querySelectorAll('[data-i18n]').forEach(element => {
    const key = element.getAttribute('data-i18n');
    element.textContent = translations[key];
  });
}

// Language Switcher Event Listeners
document.querySelectorAll('.dropdown-item[data-lang]').forEach(btn => {
  btn.addEventListener('click', (e) => {
    e.preventDefault();
    const lang = e.target.getAttribute('data-lang');
    loadLanguage(lang);
  });
});

// Initialize Language
const savedLang = localStorage.getItem('selectedLang') || navigator.language.slice(0,2);
loadLanguage(['en','ig','ha','yo'].includes(savedLang) ? savedLang : 'en'); <!-- Example: Hero Section -->
<section id="home" class="hero">
  <div class="container text-center">
    <h1 data-i18n="homeTitle">Power Reliable Logistics</h1>
    <p data-i18n="homeSubtitle">Fast | Reliable | Global</p>
    <button class="btn btn-primary btn-lg" data-i18n="getQuote">Get Instant Quote</button>
  </div>
</section> /* Right-to-Left Support (Optional for Hausa/Yoruba) */
[lang="ha"], [lang="yo"] {
  direction: rtl;
  text-align: right;
}

.dropdown-menu {
  min-width: 120px;
} // Example: Service descriptions
async function loadTranslatedServices() {
  const response = await fetch(`services_${currentLang}.json`);
  const services = await response.json();
  // Update services dynamically
} <link rel="alternate" hreflang="en" href="https://yourdomain.com/en">
   <link rel="alternate" hreflang="ig" href="https://yourdomain.com/ig">  // Add translated error messages
   const errorMessages = {
     en: "Please fill this field",
     ig: "Biko dejupụta oghere a",
     ha: "Da fatan za a cika wannan filin",
     yo: "Jọwọ ṣe alaye ni aaye yii"
   }; // Detect Nigerian users
   if (navigator.languages.some(lang => lang.includes('HA') || lang.includes('YO'))) {
     loadLanguage('ha'); // Default to Hausa
   } // Cache translations
   const translationCache = {};
   async function loadLanguage(lang) {
     if (translationCache[lang]) {
       applyTranslations(translationCache[lang]);
       return;
     }
     // ... rest of function
   } <!-- Simple CMS for translations -->
   <div class="translation-tool">
     <input type="text" id="enPhrase" placeholder="English phrase">
     <input type="text" id="igPhrase" placeholder="Igbo translation">
     <button onclick="saveTranslation()">Save</button>
   </div>
