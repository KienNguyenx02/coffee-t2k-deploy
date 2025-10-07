package com.t2kcoffee.controller;

import com.t2kcoffee.service.WebSocketService;
import com.t2kcoffee.dto.WebSocketMessage;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.Map;

@RestController
@RequestMapping("/api/websocket")
@CrossOrigin(origins = "*")
public class WebSocketTestController {

    @Autowired
    private WebSocketService webSocketService;

    /**
     * Test WebSocket connection
     */
    @GetMapping("/test")
    public ResponseEntity<Map<String, Object>> testWebSocket() {
        Map<String, Object> response = new HashMap<>();
        response.put("status", "WebSocket service is running");
        response.put("activeStaff", webSocketService.getActiveStaffCount());
        response.put("activeCustomers", webSocketService.getActiveCustomerCount());
        response.put("timestamp", java.time.LocalDateTime.now().toString());
        
        return ResponseEntity.ok(response);
    }

    /**
     * Send test notification to all staff
     */
    @PostMapping("/test/notify-staff")
    public ResponseEntity<Map<String, Object>> testNotifyStaff(@RequestBody Map<String, String> testData) {
        String message = testData.getOrDefault("message", "Test notification from server");
        
        webSocketService.broadcastNotification(message, "TEST_NOTIFICATION");
        
        Map<String, Object> response = new HashMap<>();
        response.put("status", "Test notification sent to all staff");
        response.put("message", message);
        response.put("timestamp", java.time.LocalDateTime.now().toString());
        
        return ResponseEntity.ok(response);
    }

    /**
     * Send test notification to specific user
     */
    @PostMapping("/test/notify-user/{userId}")
    public ResponseEntity<Map<String, Object>> testNotifyUser(
            @PathVariable String userId, 
            @RequestBody Map<String, String> testData) {
        
        String message = testData.getOrDefault("message", "Test notification for user " + userId);
        String type = testData.getOrDefault("type", "TEST_NOTIFICATION");
        
        webSocketService.sendNotificationToUser(userId, message, type);
        
        Map<String, Object> response = new HashMap<>();
        response.put("status", "Test notification sent to user " + userId);
        response.put("message", message);
        response.put("type", type);
        response.put("timestamp", java.time.LocalDateTime.now().toString());
        
        return ResponseEntity.ok(response);
    }

    /**
     * Get WebSocket statistics
     */
    @GetMapping("/stats")
    public ResponseEntity<Map<String, Object>> getWebSocketStats() {
        Map<String, Object> stats = new HashMap<>();
        stats.put("activeStaffCount", webSocketService.getActiveStaffCount());
        stats.put("activeCustomerCount", webSocketService.getActiveCustomerCount());
        stats.put("timestamp", java.time.LocalDateTime.now().toString());
        
        return ResponseEntity.ok(stats);
    }

    /**
     * Check if user is online
     */
    @GetMapping("/user/{userId}/online")
    public ResponseEntity<Map<String, Object>> checkUserOnline(@PathVariable String userId) {
        boolean isOnline = webSocketService.isUserOnline(userId);
        
        Map<String, Object> response = new HashMap<>();
        response.put("userId", userId);
        response.put("isOnline", isOnline);
        response.put("timestamp", java.time.LocalDateTime.now().toString());
        
        return ResponseEntity.ok(response);
    }
}
