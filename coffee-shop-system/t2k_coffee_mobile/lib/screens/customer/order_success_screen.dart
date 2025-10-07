import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../models/order.dart';
import '../../utils/app_theme.dart';
import '../../widgets/custom_button.dart';

class OrderSuccessScreen extends StatelessWidget {
  final Order order;

  const OrderSuccessScreen({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Success icon
                      Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          color: AppTheme.successColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(60),
                        ),
                        child: const Icon(
                          Icons.check_circle,
                          size: 80,
                          color: AppTheme.successColor,
                        ),
                      ),

                      const SizedBox(height: 32),

                      // Success message
                      Text(
                        'Đặt hàng thành công!',
                        style: Theme.of(context).textTheme.headlineMedium
                            ?.copyWith(
                              color: AppTheme.successColor,
                              fontWeight: FontWeight.bold,
                            ),
                        textAlign: TextAlign.center,
                      ),

                      const SizedBox(height: 16),

                      Text(
                        'Đơn hàng #${order.idOrder} đã được tiếp nhận',
                        style: Theme.of(context).textTheme.bodyLarge,
                        textAlign: TextAlign.center,
                      ),

                      const SizedBox(height: 8),

                      Text(
                        'Chúng tôi sẽ chuẩn bị đơn hàng của bạn ngay',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppTheme.textSecondary,
                        ),
                        textAlign: TextAlign.center,
                      ),

                      const SizedBox(height: 48),

                      // Order details
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 10,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            _buildDetailRow(
                              'Mã đơn hàng:',
                              '#${order.idOrder}',
                            ),
                            _buildDetailRow('Vị trí:', order.displayLocation),
                            _buildDetailRow(
                              'Thanh toán:',
                              order.payment?.paymentMethodText ?? 'Tiền mặt',
                            ),
                            _buildDetailRow(
                              'Tổng tiền:',
                              order.formattedTotalAmount,
                            ),
                            if (order.note != null && order.note!.isNotEmpty)
                              _buildDetailRow('Ghi chú:', order.note!),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Action buttons
              Column(
                children: [
                  CustomButton(
                    text: 'Theo dõi đơn hàng',
                    onPressed: () {
                      context.go('/customer/orders');
                    },
                    icon: Icons.track_changes,
                    width: double.infinity,
                  ),

                  const SizedBox(height: 12),

                  CustomButton(
                    text: 'Tiếp tục đặt món',
                    onPressed: () {
                      context.go('/customer');
                    },
                    isOutlined: true,
                    width: double.infinity,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _getDisplayLocation(Order order) {
    // Kiểm tra nếu có table object (dine-in)
    if (order.table != null && order.table!.tableNumber != null) {
      String locationText = 'Bàn ${order.table!.tableNumber}';
      if (order.table!.location != null && order.table!.location!.isNotEmpty) {
        locationText += ' (${order.table!.location})';
      }
      return locationText;
    }
    
    // Nếu không có table, mặc định là takeaway
    return 'Mang đi';
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 14,
                color: AppTheme.textSecondary,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 14,
                color: AppTheme.textPrimary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
