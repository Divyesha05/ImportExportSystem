package Interface;

import Pojo.Order;
import java.util.List;

public interface OrderOperations {
	List<Order> getOrdersByConsumer(int consumerId);
}
