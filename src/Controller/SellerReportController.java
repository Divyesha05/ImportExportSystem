package Controller;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import Implementor.ReportOpImp;
import Pojo.ReportPojo;

@WebServlet("/SellerReportController")
public class SellerReportController extends HttpServlet {
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		Integer sellerId = (Integer) req.getSession().getAttribute("seller_id");
		if (sellerId == null) {
			resp.sendRedirect("login.jsp");
			return;
		}

		// Fetch reported issues for the seller
		ReportOpImp reportOp = new ReportOpImp();
		List<ReportPojo> reports = reportOp.getReportedIssuesForSeller(sellerId);

		// Set the data in the request scope for the JSP
		req.setAttribute("reports", reports);
		req.getRequestDispatcher("seller_reported_issues.jsp").forward(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		int reportId = Integer.parseInt(req.getParameter("report_id"));

		// Update the status of the reported issue
		ReportOpImp reportOp = new ReportOpImp();
		reportOp.updateReportStatus(reportId, "solved");

		// Redirect back to the same page to refresh the data
		resp.sendRedirect("SellerReportController");
	}
}