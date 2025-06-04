package Interface;

import Pojo.Product;
import java.util.List;

public interface ProductOperation {
    List<Product> getAvailableProducts();
}