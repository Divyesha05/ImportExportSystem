
package Interface;

import Pojo.User;
import java.sql.SQLException;

public interface productinterface {
	User getUserByIdAndRole(int portId, String role) throws SQLException, ClassNotFoundException;
}