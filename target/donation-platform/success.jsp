<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%!
private String esc(String s) {
    if (s == null) return "";
    return s.replace("&","&amp;").replace("<","&lt;").replace(">","&gt;").replace("\"","&quot;").replace("'","&#x27;");
}
%>
<!DOCTYPE html><html lang="en"><head><meta charset="UTF-8"><meta name="viewport" content="width=device-width,initial-scale=1"><title>Donation recorded | GiveHope</title>
<style>body{margin:0;background:#f5f7fb;font-family:Arial,sans-serif;color:#172033;display:grid;place-items:center;min-height:100vh}.card{background:white;max-width:560px;margin:20px;padding:34px;border-radius:18px;box-shadow:0 12px 36px #15234412;text-align:center}.check{font-size:48px;color:#16845b}a{display:inline-block;background:#16845b;color:white;padding:12px 18px;border-radius:9px;text-decoration:none;font-weight:bold}</style></head>
<body><main class="card"><div class="check">✓</div><h1>Thank you, <%= esc((String)request.getAttribute("donorName")) %>!</h1><p>Your demo donation of ₹<%= esc((String)request.getAttribute("donationAmount")) %> has been recorded.</p><p>This is a demo only; no real payment was taken.</p><a href="<%= request.getContextPath() %>/">Back to GiveHope</a></main></body></html>
