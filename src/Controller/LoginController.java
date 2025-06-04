package Controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import Implementor.RegisterImplementor;

@WebServlet("/LoginController")
public class LoginController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		// ✅ Get form data
		String portIdParam = request.getParameter("port_id");
		String password = request.getParameter("password");
		String role = request.getParameter("role");

		// ✅ Validate input fields
		if (portIdParam == null || password == null || role == null || portIdParam.isEmpty() || password.isEmpty()
				|| role.isEmpty()) {
			request.setAttribute("errorMessage", "Please fill in all fields.");
			request.getRequestDispatcher("login.jsp").forward(request, response);
			return;
		}

		int portId = Integer.parseInt(portIdParam);

		// ✅ Authenticate user
		RegisterImplementor registerImplementor = new RegisterImplementor();
		String loginMessage = registerImplementor.loginUser(portId, password, role);

		if (loginMessage.contains("successful")) {
			// ✅ Store portId in session
			HttpSession session = request.getSession();
			session.setAttribute("port_id", portId);
			session.setAttribute("role", role);

			System.out.println("✅ Login Successful! Port ID stored in session: " + portId);

			// ✅ Redirect user based on role
			if ("Seller".equals(role)) {
				session.setAttribute("seller_id", portId); // Auto-fill seller forms
				response.sendRedirect("SellerInsUpDel.jsp");
			} else {
				response.sendRedirect("viewProducts"); // Redirect to product controller
			}
		} else {
			request.setAttribute("errorMessage", loginMessage);
			request.getRequestDispatcher("login.jsp").forward(request, response);
		}
	}
}