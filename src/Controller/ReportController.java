package Controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import Implementor.ReportOpImp;
import Pojo.ReportPojo;

@WebServlet("/ReportController")
public class ReportController extends HttpServlet {
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// Handle GET requests (e.g., display the report form)

		// Get the product_id from the request parameter (if passed)
		String productId = req.getParameter("product_id");

		// Set the product_id in the request scope for the JSP
		req.setAttribute("product_id", productId);

		// Forward to the report form page
		req.getRequestDispatcher("report_product.jsp").forward(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// Handle POST requests (e.g., submit the report form)

		// Print values to debug
		System.out.println("Received form data:");
		System.out.println("Product ID: " + req.getParameter("product_id"));
		System.out.println("Consumer Port ID: " + req.getParameter("consumer_port_id"));
		System.out.println("Issue Type: " + req.getParameter("issueType"));

		// Check if any value is missing
		if (req.getParameter("product_id") == null || req.getParameter("consumer_port_id") == null
				|| req.getParameter("issueType") == null || req.getParameter("product_id").trim().isEmpty()
				|| req.getParameter("consumer_port_id").trim().isEmpty()
				|| req.getParameter("issueType").trim().isEmpty()) {

			req.setAttribute("errorMessage", "All fields are required.");
			req.getRequestDispatcher("report_product.jsp").forward(req, resp);
			return;
		}

		// Parsing values safely
		try {
			ReportPojo pojo = new ReportPojo();
			pojo.setProductId(Integer.parseInt(req.getParameter("product_id")));
			pojo.setConsumerPortId(Integer.parseInt(req.getParameter("consumer_port_id")));
			pojo.setIssueType(req.getParameter("issueType"));

			// Call the service layer to report the product
			ReportOpImp reportOp = new ReportOpImp();
			reportOp.reportProduct(pojo); // This now uses the stored procedure

			// Redirect to the reported issues page after successful submission
			resp.sendRedirect("viewReportedIssues");
		} catch (NumberFormatException e) {
			req.setAttribute("errorMessage", "Invalid number format for Product ID or Consumer Port ID.");
			req.getRequestDispatcher("report_product.jsp").forward(req, resp);
		}
	}
}