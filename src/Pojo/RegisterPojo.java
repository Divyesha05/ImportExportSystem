package Pojo;

import Implementor.RegisterImplementor;

public class RegisterPojo {
	private int port_id;
	private String password;
	private String confirm_password;
	private String location;
	private String role;

	// Getters and Setters
	public int getPort_id() {
		return port_id;
	}

	public void setPort_id(int port_id) {
		this.port_id = port_id;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getConfirm_password() {
		return confirm_password;
	}

	public void setConfirm_password(String confirm_password) {
		this.confirm_password = confirm_password;
	}

	public String getLocation() {
		return location;
	}

	public void setLocation(String location) {
		this.location = location;
	}

	public String getRole() {
		return role;
	}

	public void setRole(String role) {
		this.role = role;
	}

	// Method to trigger registration
	public boolean register_user() {
		return new RegisterImplementor().registerUser(this);
	}
}
