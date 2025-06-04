package Controller;

import java.io.IOException;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import Db.GetConnection;

@WebServlet("/CheckoutController")
public class CheckoutController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Connection conn = null;
        CallableStatement stmt = null;

        try {
            conn = GetConnection.getConnection();
            int consumerId = Integer.parseInt(request.getParameter("consumer_id"));

            // Call stored procedure to place the order
            stmt = conn.prepareCall("{CALL PlaceOrder(?)}");
            stmt.setInt(1, consumerId);
            stmt.executeUpdate();

            // Redirect to an order confirmation page or homepage
            response.sendRedirect("order_confirmation.jsp");

        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        } finally {
            try {
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
