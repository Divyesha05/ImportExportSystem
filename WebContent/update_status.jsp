<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page language="java" contentType="application/json; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*, org.json.JSONObject, Db.GetConnection" %>

<%
Connection con = null;
CallableStatement cs = null;
ResultSet rs = null;
JSONObject jsonResponse = new JSONObject();

try {
    int reportId = Integer.parseInt(request.getParameter("report_id"));

    con = GetConnection.getConnection();
    cs = con.prepareCall("{CALL UpdateReportedProductStatus(?, 'solved')}");
    cs.setInt(1, reportId);
    cs.executeUpdate();

    PreparedStatement ps = con.prepareStatement("SELECT solution FROM reported_products WHERE report_id = ?");
    ps.setInt(1, reportId);
    rs = ps.executeQuery();

    if (rs.next()) {
        jsonResponse.put("solution", rs.getString("solution"));
    }

    out.print(jsonResponse.toString());

} catch (Exception e) {
    jsonResponse.put("error", e.getMessage());
    out.print(jsonResponse.toString());
} finally {
    if (rs != null) try { rs.close(); } catch (SQLException ignored) {}
    if (cs != null) try { cs.close(); } catch (SQLException ignored) {}
    if (con != null) try { con.close(); } catch (SQLException ignored) {}
}
%>
