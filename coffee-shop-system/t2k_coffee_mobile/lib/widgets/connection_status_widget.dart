import 'package:flutter/material.dart';
import '../utils/app_theme.dart';

class ConnectionStatusWidget extends StatelessWidget {
  final bool isConnected;
  final bool isConnecting;
  final VoidCallback? onTap;

  const ConnectionStatusWidget({
    super.key,
    required this.isConnected,
    this.isConnecting = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    Color statusColor;
    IconData statusIcon;
    String tooltip;

    if (isConnecting) {
      statusColor = AppTheme.warningColor;
      statusIcon = Icons.wifi_off;
      tooltip = 'Đang kết nối...';
    } else if (isConnected) {
      statusColor = AppTheme.successColor;
      statusIcon = Icons.wifi;
      tooltip = 'Đã kết nối';
    } else {
      statusColor = AppTheme.errorColor;
      statusIcon = Icons.wifi_off;
      tooltip = 'Mất kết nối';
    }

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: statusColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: statusColor.withOpacity(0.3), width: 1),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(statusIcon, color: statusColor, size: 16),
            if (isConnecting) ...[
              const SizedBox(width: 4),
              SizedBox(
                width: 12,
                height: 12,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(statusColor),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
