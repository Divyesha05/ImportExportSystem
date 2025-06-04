package Interface;

import Pojo.RegisterPojo;

public interface Operations {
    boolean registerUser(RegisterPojo pojo);
    String loginUser(int portId, String password, String role);
}
