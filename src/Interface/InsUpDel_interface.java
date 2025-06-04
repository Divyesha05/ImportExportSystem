
package Interface;

import java.util.List;
import Pojo.InsUpDel_Pojo;

public interface InsUpDel_interface {
	void add_products(InsUpDel_Pojo pojo);

	void update_products(InsUpDel_Pojo pojo);

	void delete_products(InsUpDel_Pojo pojo);

	List<InsUpDel_Pojo> getProductsBySeller(int sellerId); // New method to fetch products by seller
}