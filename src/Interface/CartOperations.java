package Interface;


import java.util.List;

import Pojo.CartItem;

public interface CartOperations {
    boolean addToCart(int consumerId, int productId, int quantity);
    boolean removeFromCart(int consumerId, int productId);
    List<CartItem> viewCart(int consumerId);
}