package com.t2kcoffee.dto;

import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.AllArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class WebSocketMessage {
    private String type;
    private Object data;
    private String timestamp;
    private String userId;
    private String sessionId;
    
    public WebSocketMessage(String type, Object data) {
        this.type = type;
        this.data = data;
        this.timestamp = java.time.LocalDateTime.now().toString();
    }
}
