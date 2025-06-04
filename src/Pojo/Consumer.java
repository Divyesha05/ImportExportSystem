package Pojo;


public class Consumer {
    private String name;
    private String email;

    public Consumer() {}

    public Consumer(String name, String email) {
        this.name = name;
        this.email = email;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

	public Consumer getConsumerById(int consumerId) {
		// TODO Auto-generated method stub
		return null;
	}
}
