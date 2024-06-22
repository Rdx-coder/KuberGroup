package optionchain;

import javax.websocket.server.ServerApplicationConfig;
import javax.websocket.server.ServerEndpointConfig;
import java.util.HashSet;
import java.util.Set;

public class WebSocketConfig implements ServerApplicationConfig {

    @Override
    public Set<ServerEndpointConfig> getEndpointConfigs(Set<Class<?>> endpointClasses) {
        Set<ServerEndpointConfig> configs = new HashSet<>();
        configs.add(ServerEndpointConfig.Builder.create(OptionChainWebSocket.class, "/websocket").build());
        return configs;
    }

    @Override
    public Set<Class<?>> getAnnotatedEndpointClasses(Set<Class<?>> scanned) {
        return scanned;
    }
}
