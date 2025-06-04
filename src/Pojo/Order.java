package Pojo;

import java.sql.Date;

public class Order {
	private int orderId;
	private Date orderDate;
	private int quantity;
	private int productId;
	private int consumerPortId;
	private boolean orderPlaced;
	private boolean shipped;
	private boolean outForDelivery;
	private boolean delivered;
	private String productName;
	private double price;

	public Order(int orderId, Date orderDate, int quantity, int productId, int consumerPortId, boolean orderPlaced,
			boolean shipped, boolean outForDelivery, boolean delivered, String productName, double price) {
		this.orderId = orderId;
		this.orderDate = orderDate;
		this.quantity = quantity;
		this.productId = productId;
		this.consumerPortId = consumerPortId;
		this.orderPlaced = orderPlaced;
		this.shipped = shipped;
		this.outForDelivery = outForDelivery;
		this.delivered = delivered;
		this.productName = productName;
		this.price = price;
	}

	// Getters
	public int getOrderId() {
		return orderId;
	}

	public Date getOrderDate() {
		return orderDate;
	}

	public int getQuantity() {
		return quantity;
	}

	public int getProductId() {
		return productId;
	}

	public int getConsumerPortId() {
		return consumerPortId;
	}

	public boolean isOrderPlaced() {
		return orderPlaced;
	}

	public boolean isShipped() {
		return shipped;
	}

	public boolean isOutForDelivery() {
		return outForDelivery;
	}

	public boolean isDelivered() {
		return delivered;
	}

	public String getProductName() {
		return productName;
	}

	public double getPrice() {
		return price;
	}
}
