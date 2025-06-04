package Pojo;



public class CartItem {
    private int productId;
    private String productName;
    private int quantity;
    private double price;
    private int stock; 

    public CartItem(int productId, String productName, int quantity, double price, int stock) {
        this.productId = productId;
        this.productName = productName;
        this.quantity = quantity;
        this.price = price;
        this.stock = stock; 
    }

    public int getProductId() {
        return productId;
    }

    public String getProductName() {
        return productName;
    }

    public int getQuantity() {
        return quantity;
    }

    public double getPrice() {
        return price;
    }

    public int getStock() { // 🔥 Add getter for stock
        return stock;
    }

    public double getSubtotal() {
        return quantity * price;
    }
}
