package Interface;

import Pojo.Product;
import java.util.List;

public interface ProductDAO {
	List<Product> getAvailableProducts(int consumerId);
}