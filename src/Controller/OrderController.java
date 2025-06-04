package Controller;



import java.io.IOException;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import Implementor.OrderImpl;
import Pojo.Order;

@WebServlet("/OrderController")
public class OrderController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		OrderImpl orderImpl = new OrderImpl();
		List<Order> orders = orderImpl.getOrdersByConsumer(21); 

		request.setAttribute("orders", orders);
		System.out.println("Sending orders to JSP: " + (orders != null ? orders.size() : 0));

		RequestDispatcher dispatcher = request.getRequestDispatcher("ConsumerViewOrder.jsp");
		dispatcher.forward(request, response);
	}
}
