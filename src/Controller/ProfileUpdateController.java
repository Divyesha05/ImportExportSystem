package Controller;

import Db.GetConnection;
import Pojo.User;
import Interface.productinterface;
import Implementor.UserImplementer;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;

@WebServlet("/ProfileUpdateController")
public class ProfileUpdateController extends HttpServlet {

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession(false);
		if (session == null || session.getAttribute("portId") == null || session.getAttribute("role") == null) {
			response.sendRedirect("login.jsp");
			return;
		}

		int portId = (int) session.getAttribute("portId");
		String role = (String) session.getAttribute("role");

		String oldPassword = request.getParameter("oldPassword");
		String newPassword = request.getParameter("newPassword");
		String confirmPassword = request.getParameter("confirmPassword");
		String newLocation = request.getParameter("address");
		String name = request.getParameter("name");
		String email = request.getParameter("email");
		String phone = request.getParameter("phone");

		try (Connection con = GetConnection.getConnection();
				CallableStatement stmt = con.prepareCall("{call UpdateUserInfo(?, ?, ?, ?, ?, ?, ?, ?, ?)}")) {

			stmt.setInt(1, portId);
			stmt.setString(2, role);
			stmt.setString(3, oldPassword);
			stmt.setString(4, newPassword);
			stmt.setString(5, confirmPassword);
			stmt.setString(6, newLocation);
			stmt.setString(7, name);
			stmt.setString(8, email);
			stmt.setString(9, phone);

			int rowsAffected = stmt.executeUpdate();

			if (rowsAffected > 0) {
				request.setAttribute("successMessage", "Profile updated successfully!");

				// Fetch updated user info and set it in the session (Using
				// Interface/Implementer)
				productinterface userInterface = new UserImplementer();
				User updatedUser = userInterface.getUserByIdAndRole(portId, role);
				if (updatedUser != null) {
					session.setAttribute("user", updatedUser);
				}

			} else {
				request.setAttribute("errorMessage", "Profile update failed. No changes were made.");
			}

			request.getRequestDispatcher("profile.jsp").forward(request, response);

		} catch (SQLException | ClassNotFoundException e) {
			e.printStackTrace();
			request.setAttribute("errorMessage", "Error updating profile: " + e.getMessage());
			request.getRequestDispatcher("profile.jsp").forward(request, response);
		}
	}
}