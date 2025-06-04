package Controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import Pojo.InsUpDel_Pojo;
import Implementor.InsUpDel_implementor;

@WebServlet("/InsUpDel_Controller")
public class InsUpDel_Controller extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private InsUpDel_implementor productService = new InsUpDel_implementor();

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String action = req.getParameter("action");

		// Validate sellerID
		int sellerID = 0;
		try {
			sellerID = Integer.parseInt(req.getParameter("sellerID"));
		} catch (NumberFormatException e) {
			resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Seller ID is required and must be a valid number.");
			return;
		}

		if ("view".equals(action)) {
			List<InsUpDel_Pojo> products = productService.getProductsBySeller(sellerID);

			if (products == null) {
				products = new ArrayList<>();
			}

			req.setAttribute("products", products);
			req.getRequestDispatcher("SellerInsUpDel.jsp").forward(req, resp);
			return;
		}

		// Common Pojo object
		InsUpDel_Pojo pojo = new InsUpDel_Pojo();
		pojo.setSellerId(sellerID);

		if ("add".equals(action)) {
			String productName = req.getParameter("productName");
			String priceStr = req.getParameter("price");
			String quantityStr = req.getParameter("quantity");

			if (productName == null || productName.trim().isEmpty() || priceStr == null || priceStr.trim().isEmpty()
					|| quantityStr == null || quantityStr.trim().isEmpty()) {
				resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Product Name, Price, and Quantity are required.");
				return;
			}

			try {
				pojo.setProductName(productName);
				pojo.setPrice(Double.parseDouble(priceStr));
				pojo.setQuantity(Integer.parseInt(quantityStr));
			} catch (NumberFormatException e) {
				resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid Price or Quantity format.");
				return;
			}

			productService.add_products(pojo);
			System.out.println("Product added successfully");
		}

		else if ("update".equals(action)) {
			String productIDStr = req.getParameter("productID");
			String newName = req.getParameter("newName");
			String newPriceStr = req.getParameter("newPrice");
			String newQuantityStr = req.getParameter("newQuantity");

			if (productIDStr == null || productIDStr.trim().isEmpty()) {
				resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Product ID is required for update.");
				return;
			}

			try {
				pojo.setProductId(Integer.parseInt(productIDStr));

				if (newName != null && !newName.trim().isEmpty()) {
					pojo.setProductName(newName);
				}
				if (newPriceStr != null && !newPriceStr.trim().isEmpty()) {
					pojo.setPrice(Double.parseDouble(newPriceStr));
				}
				if (newQuantityStr != null && !newQuantityStr.trim().isEmpty()) {
					pojo.setQuantity(Integer.parseInt(newQuantityStr));
				}

			} catch (NumberFormatException e) {
				resp.sendError(HttpServletResponse.SC_BAD_REQUEST,
						"Invalid input format for Product ID, Price, or Quantity.");
				return;
			}

			productService.update_products(pojo);
			System.out.println("Product updated successfully");

		}

		else if ("delete".equals(action)) {
			String productIDStr = req.getParameter("productID");

			if (productIDStr == null || productIDStr.trim().isEmpty()) {
				resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Product ID is required for deletion.");
				return;
			}

			try {
				pojo.setProductId(Integer.parseInt(productIDStr));
			} catch (NumberFormatException e) {
				resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid Product ID format.");
				return;
			}

			productService.delete_products(pojo);
			System.out.println("Product deleted successfully");
		}

		else {
			resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid action.");
			return;
		}

		resp.sendRedirect("SellerInsUpDel.jsp");
	}
}	