package Controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Pojo.Consumer;

/**
 * Servlet implementation class ConsumerDashboardController
 */
@WebServlet("/ConsumerDashboardController")
public class ConsumerDashboardController extends HttpServlet {
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		ServletRequest session = null;
		if (session == null || session.getAttribute("consumerId") == null) {
            // Redirect to login or display an error message
            response.sendRedirect("login.jsp"); // Or appropriate error handling
            return;
        }

        int consumerId = (int) session.getAttribute("consumerId"); // Get from session

        Consumer consumerDAO = new Consumer();
        Consumer consumer = consumerDAO.getConsumerById(consumerId);

        if (consumer != null) {
            request.setAttribute("consumer", consumer);
            request.getRequestDispatcher("ConsumerDashboard.jsp").forward(request, response);
        } else {
            // Handle consumer not found (redirect or error message)
            response.sendRedirect("consumer_not_found.jsp"); // Or better error handling
        }
    }

	}


