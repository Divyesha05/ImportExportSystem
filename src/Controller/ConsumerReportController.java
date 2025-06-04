package Controller;

import Implementor.ReportOpImp;
import Pojo.ReportPojo;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet("/viewReportedIssues")
public class ConsumerReportController extends HttpServlet {
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession(false);

		// Check if session exists and consumerId is present
		if (session == null || session.getAttribute("port_id") == null) {
			response.sendRedirect("login.jsp"); // Redirect to login if session is invalid
			return;
		}

		int consumerId = (Integer) session.getAttribute("port_id");

		// Call the Model to fetch reported issues
		ReportOpImp reportOp = new ReportOpImp();
		List<ReportPojo> reports = reportOp.viewReportedIssues(consumerId);

		// Set the data in the request scope for the View
		request.setAttribute("reports", reports);

		// Forward to the View (JSP)
		request.getRequestDispatcher("consumer_reported_issues.jsp").forward(request, response);
	}
}