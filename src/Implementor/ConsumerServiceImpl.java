package Implementor;


import Pojo.Consumer;
import java.util.HashMap;
import java.util.Map;

import Interface.ConsumerService;

public class ConsumerServiceImpl implements ConsumerService {
    private static Map<String, Consumer> consumers = new HashMap<>();

    static {
        consumers.put("consumer@example.com", new Consumer("John Doe", "consumer@example.com"));
    }

    @Override
    public Consumer getConsumerByEmail(String email) {
        return consumers.get(email);
    }
}
