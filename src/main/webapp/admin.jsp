<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.*,java.math.BigDecimal" %>
<%!
private String esc(Object value) {
    if (value == null) return "";
    return value.toString().replace("&","&amp;").replace("<","&lt;").replace(">","&gt;").replace("\"","&quot;").replace("'","&#x27;");
}
%>
<!DOCTYPE html><html lang="en"><head><meta charset="UTF-8"><meta name="viewport" content="width=device-width,initial-scale=1"><title>Admin dashboard | GiveHope</title>
<style>*{box-sizing:border-box}body{margin:0;background:#f5f7fb;color:#172033;font-family:Arial,sans-serif}header{background:#14213d;color:white;padding:18px 5%;display:flex;justify-content:space-between;align-items:center;gap:12px;flex-wrap:wrap}header a{color:white}.wrap{max-width:1200px;margin:30px auto;padding:0 20px}.stats{display:grid;grid-template-columns:repeat(2,minmax(0,1fr));gap:18px}.stat,.panel{background:white;padding:22px;border-radius:14px;box-shadow:0 8px 26px #1523440c}.stat span{color:#5c667a}.stat strong{display:block;font-size:30px;margin-top:10px}.table-wrap{overflow:auto}table{border-collapse:collapse;width:100%;min-width:780px}th,td{text-align:left;padding:12px;border-bottom:1px solid #e7ebf2;font-size:14px;vertical-align:top}th{background:#f7f9fc}.status{color:#126b4a;background:#dff7eb;padding:5px 8px;border-radius:99px;font-size:12px;font-weight:bold}.error{color:#b42318;background:#fff0ef;padding:12px;border-radius:8px}@media(max-width:600px){.stats{grid-template-columns:1fr}}</style></head>
<body><header><strong>♥ GiveHope · Admin Dashboard</strong><div><a href="<%= request.getContextPath() %>/" style="margin-right:18px">View site</a><form style="display:inline" action="<%= request.getContextPath() %>/admin/logout" method="post"><button type="submit">Log out</button></form></div></header>
<main class="wrap"><h1>Donation overview</h1><p>These are demo donation records, not verified payments.</p>
<% if (request.getAttribute("dbError") != null) { %><p class="error"><%= esc(request.getAttribute("dbError")) %></p><% } %>
<section class="stats"><div class="stat"><span>Total records</span><strong><%= esc(request.getAttribute("donationCount")) %></strong></div><div class="stat"><span>Total demo donations</span><strong>₹<%= esc(request.getAttribute("totalAmount")) %></strong></div></section>
<section class="panel" style="margin-top:22px"><h2>Recent donations</h2><div class="table-wrap"><table><thead><tr><th>ID</th><th>Donor</th><th>Email</th><th>Amount</th><th>Message</th><th>Status</th><th>Date</th></tr></thead><tbody>
<% List<Map<String,Object>> rows = (List<Map<String,Object>>)request.getAttribute("donations");
if (rows == null || rows.isEmpty()) { %><tr><td colspan="7">No donations yet. Submit a demo donation from the homepage to see it here.</td></tr><% } else { for (Map<String,Object> row : rows) { %>
<tr><td><%= esc(row.get("id")) %></td><td><%= esc(row.get("name")) %></td><td><%= esc(row.get("email")) %></td><td>₹<%= esc(row.get("amount")) %></td><td><%= esc(row.get("message")) %></td><td><span class="status"><%= esc(row.get("status")) %></span></td><td><%= esc(row.get("createdAt")) %></td></tr>
<% } } %></tbody></table></div></section></main></body></html>
