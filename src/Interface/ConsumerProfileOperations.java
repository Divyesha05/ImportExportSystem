package Interface;

import Pojo.profile;

public interface ConsumerProfileOperations {
	profile getConsumerByPortId(int portId);

	boolean updateConsumer(int portId, String newPassword, String location);

	boolean deleteConsumer(int portId, String password);
}