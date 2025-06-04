package Controller;

import Interface.ProductDAO;
import Implementor.ProductDAOImpl;
import Pojo.Product;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet("/viewProducts")
public class ProductController extends HttpServlet {
	private ProductDAO productDAO = new ProductDAOImpl();

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		HttpSession session = request.getSession();
		Integer portId = (Integer) session.getAttribute("port_id");

		if (portId == null) {
			System.out.println("❌ Port ID not found in session!");
			request.setAttribute("error", "Please log in again.");
			request.getRequestDispatcher("login.jsp").forward(request, response);
			return;
		}

		System.out.println("✅ Port ID found: " + portId);

		// Fetch available products
		List<Product> productList = productDAO.getAvailableProducts(portId);
		request.setAttribute("productList", productList);

		System.out.println("✅ Products added to request: " + productList.size());
		request.getRequestDispatcher("product.jsp").forward(request, response);
	}
}