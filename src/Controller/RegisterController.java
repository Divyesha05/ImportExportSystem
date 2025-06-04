package Controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import Pojo.RegisterPojo;
import Implementor.RegisterImplementor;

@WebServlet("/RegisterController")
public class RegisterController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {
			// Retrieve form data
			int port_id = Integer.parseInt(request.getParameter("port_id"));
			String password = request.getParameter("password").trim();
			String confirmPassword = request.getParameter("confirm_password").trim();
			String location = request.getParameter("location").trim();
			String role = request.getParameter("role").trim(); // Remove spaces

			// Convert role properly to match ENUM('Consumer', 'Seller')
			if (role.equalsIgnoreCase("consumer")) {
				role = "Consumer";
			} else if (role.equalsIgnoreCase("seller")) {
				role = "Seller";
			} else {
				System.out.println("Invalid role provided: " + role);
				response.sendRedirect("register.jsp?error=Invalid role selected.");
				return;
			}

			// Debugging: Print received data
			System.out.println("Received Registration Data:");
			System.out.println("Port ID: " + port_id);
			System.out.println("Password: " + password);
			System.out.println("Confirm Password: " + confirmPassword);
			System.out.println("Location: " + location);
			System.out.println("Role: " + role);

			// Validate passwords match
			if (!password.equals(confirmPassword)) {
				System.out.println("Passwords do not match!");
				response.sendRedirect("register.jsp?error=Passwords do not match.");
				return;
			}

			// Create RegisterPojo object
			RegisterPojo pojo = new RegisterPojo();
			pojo.setPort_id(port_id);
			pojo.setPassword(password);
			pojo.setConfirm_password(confirmPassword);
			pojo.setLocation(location);
			pojo.setRole(role);

			// Call Implementor to register user
			RegisterImplementor registerImplementor = new RegisterImplementor();
			boolean isRegistered = registerImplementor.registerUser(pojo);

			// Debugging: Print result
			System.out.println("Registration Status: " + (isRegistered ? "Success" : "Failed"));

			// Redirect based on registration result
			if (isRegistered) {
				response.sendRedirect("login.jsp?message=Registration Successful! Please log in.");
			} else {
				response.sendRedirect("register.jsp?error=Registration Failed. Try Again.");
			}

		} catch (NumberFormatException e) {
			System.out.println("Error: Invalid Port ID format!");
			response.sendRedirect("register.jsp?error=Invalid Port ID format.");
		} catch (Exception e) {
			e.printStackTrace();
			response.sendRedirect("register.jsp?error=An unexpected error occurred.");
		}
	}
}
