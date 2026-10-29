<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>GiveHope | Donation Platform</title>
<style>
*{box-sizing:border-box}body{margin:0;font-family:Arial,sans-serif;background:#f5f7fb;color:#172033}
header{background:#14213d;color:#fff;padding:18px max(5%,calc((100% - 1100px)/2));display:flex;justify-content:space-between;align-items:center;gap:18px;flex-wrap:wrap}
.brand{font-size:24px;font-weight:800;color:#fff;text-decoration:none}nav{display:flex;gap:20px;align-items:center;flex-wrap:wrap}nav a{color:#fff;text-decoration:none}
.hero{max-width:1100px;margin:auto;padding:64px 22px;display:grid;grid-template-columns:1.2fr .8fr;gap:36px;align-items:center}
h1{font-size:clamp(34px,5vw,54px);line-height:1.08;margin:0 0 18px}.muted{color:#5c667a;line-height:1.65}.pill{display:inline-block;background:#dff7eb;color:#126b4a;border-radius:99px;padding:8px 13px;font-size:13px;font-weight:bold}
.card{background:#fff;border-radius:18px;padding:26px;box-shadow:0 12px 36px #15234412}.form-grid{display:grid;gap:14px}.form-grid label{font-weight:700;font-size:14px}.form-grid input,.form-grid textarea{width:100%;padding:12px;border:1px solid #d6dce7;border-radius:9px;font:inherit;margin-top:7px}.form-grid textarea{resize:vertical;min-height:82px}
.btn{display:inline-block;background:#16845b;color:#fff;border:0;border-radius:10px;padding:13px 18px;font-size:15px;font-weight:700;text-decoration:none;cursor:pointer}.btn:hover{background:#116b49}.btn.dark{background:#14213d}.amounts{display:flex;gap:8px;flex-wrap:wrap;margin-top:8px}.amounts button{background:#f2f5f9;color:#14213d;border:1px solid #d6dce7;border-radius:8px;padding:8px 12px;cursor:pointer}
section.info{max-width:1100px;margin:0 auto;padding:0 22px 54px}.features{display:grid;grid-template-columns:repeat(3,1fr);gap:18px}.feature{background:#fff;padding:22px;border-radius:14px}.feature h3{margin-top:0}
footer{text-align:center;background:#14213d;color:#dbe4f3;padding:22px}
@media(max-width:760px){.hero{grid-template-columns:1fr;padding-top:38px}.features{grid-template-columns:1fr}}
</style>
<script>
function setAmount(value){document.getElementById('amount').value=value}
</script>
</head>
<body>
<header>
  <a class="brand" href="<%= request.getContextPath() %>/">♥ GiveHope</a>
  <nav><a href="#about">About</a><a href="#donate">Donate</a><a href="<%= request.getContextPath() %>/admin-login.jsp">Admin</a></nav>
</header>
<main>
<section class="hero">
  <div>
    <span class="pill">SMALL ACTS. BIG IMPACT.</span>
    <h1>Your kindness can change someone's world.</h1>
    <p class="muted">GiveHope helps bring people together to support meaningful causes. Every contribution can help someone take a step toward a better future.</p>
    <a class="btn" href="#donate">Make a donation ↓</a>
  </div>
  <div class="card" id="donate">
    <h2>Make a donation</h2>
    <p class="muted">This is demo mode. No real payment will be charged.</p>
    <form class="form-grid" action="<%= request.getContextPath() %>/donate" method="post">
      <label>Your name<input name="name" maxlength="100" required autocomplete="name" placeholder="Enter your full name"></label>
      <label>Email address<input type="email" name="email" maxlength="190" required autocomplete="email" placeholder="you@example.com"></label>
      <div><label for="amount">Donation amount (₹)</label><div class="amounts">
        <button type="button" onclick="setAmount(100)">₹100</button><button type="button" onclick="setAmount(500)">₹500</button><button type="button" onclick="setAmount(1000)">₹1,000</button>
      </div><input id="amount" name="amount" type="number" min="1" max="1000000" step="0.01" required placeholder="Other amount"></div>
      <label>Message (optional)<textarea name="message" maxlength="500" placeholder="Why is this cause important to you?"></textarea></label>
      <button class="btn" type="submit">Record demo donation</button>
    </form>
  </div>
</section>
<section class="info" id="about">
  <div class="features">
    <article class="feature"><h3>♥ Give with purpose</h3><p class="muted">Choose an amount that feels right for you.</p></article>
    <article class="feature"><h3>◎ Transparent records</h3><p class="muted">Donations submitted here are stored for the admin to review.</p></article>
    <article class="feature"><h3>↗ Demo-safe</h3><p class="muted">No card details are requested and no real payment is processed.</p></article>
  </div>
</section>
</main>
<footer>GiveHope Donation Platform · Student/demo project</footer>
</body>
</html>
