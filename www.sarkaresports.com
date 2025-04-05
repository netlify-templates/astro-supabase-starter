<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>Sarkar E-Sports Registration</title>
  <style>
    * {
      box-sizing: border-box;
    }

    body {
      font-family: 'Segoe UI', sans-serif;
      background-color: #f3f3f3;
      color: #333;
      margin: 0;
      padding: 1rem;
      display: flex;
      flex-direction: column;
      align-items: center;
    }

    header {
      text-align: center;
      padding: 2rem 1rem 1rem;
    }

    header img {
      width: 180px;
      max-width: 100%;
      margin-bottom: 1rem;
    }

    header h1 {
      font-size: 2.5rem;
      color: #6a0dad;
      margin: 0;
    }

    .intro {
      max-width: 600px;
      text-align: center;
      margin-bottom: 2rem;
      font-size: 1.1rem;
      line-height: 1.6;
    }

    form {
      background: #ffffff;
      padding: 2rem;
      border-radius: 10px;
      max-width: 400px;
      width: 100%;
      display: flex;
      flex-direction: column;
      box-shadow: 0 0 10px #cccccc;
    }

    form label {
      margin-top: 1rem;
      font-weight: bold;
      color: #6a0dad;
    }

    form input {
      padding: 0.8rem;
      margin-top: 0.3rem;
      border: 1px solid #ccc;
      border-radius: 5px;
      font-size: 1rem;
    }

    form button {
      background: #6a0dad;
      color: #fff;
      padding: 1rem;
      border: none;
      border-radius: 5px;
      font-size: 1rem;
      cursor: pointer;
      margin-top: 1.5rem;
      transition: background 0.3s ease;
    }

    form button:hover {
      background: #5b0099;
    }

    .whatsapp {
      margin-top: 2rem;
    }

    .whatsapp a {
      background: #6a0dad;
      color: white;
      padding: 1rem 2rem;
      text-decoration: none;
      border-radius: 10px;
      font-size: 1.2rem;
      display: inline-block;
      transition: background 0.3s ease;
    }

    .whatsapp a:hover {
      background: #5b0099;
    }

    @media (max-width: 480px) {
      form, .intro {
        padding: 1rem;
      }

      header h1 {
        font-size: 2rem;
      }

      .whatsapp a {
        font-size: 1rem;
        padding: 0.8rem 1.5rem;
      }
    }
  </style>
</head>
<body>

  <header>
    <img src="logo.jpg" alt="Sarkar E-Sports Logo">
    <h1>Welcome to Sarkar E-Sports</h1>
  </header>

  <div class="intro">
    <p>Get ready to compete in thrilling online tournaments and show off your skills. Register now and join our WhatsApp channel for the latest updates, match schedules, and team interactions!</p>
  </div>

  <form id="registrationForm">
    <label for="name">Name</label>
    <input type="text" id="name" name="name" placeholder="Your Name" required>

    <label for="phone">Phone Number</label>
    <input type="tel" id="phone" name="phone" placeholder="Your Phone Number" required>

    <label for="email">Gmail</label>
    <input type="email" id="email" name="email" placeholder="Your Gmail" required>

    <label for="team">Team Name</label>
    <input type="text" id="team" name="team" placeholder="Your Team Name" required>

    <button type="submit">Register Now</button>
  </form>

  <div class="whatsapp">
    <a href="https://chat.whatsapp.com/H04HdpDpLez2gblNSTV7F6" target="_blank">
      Join WhatsApp Channel
    </a>
  </div>

  <script>
    document.getElementById('registrationForm').addEventListener('submit', function(e) {
      e.preventDefault();
      alert('Thanks for registering! We will contact you soon.');
      this.reset();
    });
  </script>

</body>
</html>
