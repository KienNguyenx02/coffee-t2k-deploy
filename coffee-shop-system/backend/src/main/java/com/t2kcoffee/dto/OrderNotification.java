package com.t2kcoffee.dto;

import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.AllArgsConstructor;
import com.t2kcoffee.entity.CafeOrder;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class OrderNotification {
    private String notificationType; // NEW_ORDER, ORDER_UPDATED, ORDER_COMPLETED, ORDER_CANCELLED
    private CafeOrder order;
    private String message;
    private String priority; // HIGH, MEDIUM, LOW
    private String timestamp;
    
    public OrderNotification(String notificationType, CafeOrder order, String message) {
        this.notificationType = notificationType;
        this.order = order;
        this.message = message;
        this.priority = "MEDIUM";
        this.timestamp = java.time.LocalDateTime.now().toString();
    }
    
    public OrderNotification(String notificationType, CafeOrder order, String message, String priority) {
        this.notificationType = notificationType;
        this.order = order;
        this.message = message;
        this.priority = priority;
        this.timestamp = java.time.LocalDateTime.now().toString();
    }
}
