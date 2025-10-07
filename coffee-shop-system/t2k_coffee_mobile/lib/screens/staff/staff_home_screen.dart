import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../../providers/auth_provider.dart';
import '../../providers/staff_provider.dart';
import '../../utils/app_theme.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/staff_order_card.dart';
import '../../widgets/connection_status_widget.dart';
import '../../widgets/notification_banner.dart';
import '../../models/order.dart';
import '../../services/speech_service.dart';

class StaffHomeScreen extends StatefulWidget {
  const StaffHomeScreen({super.key});

  @override
  State<StaffHomeScreen> createState() => _StaffHomeScreenState();
}

class _StaffHomeScreenState extends State<StaffHomeScreen> {
  Order? _lastNewOrder;
  bool _showNotification = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializeStaffServices();
    });
  }

  Future<void> _initializeStaffServices() async {
    final staffProvider = Provider.of<StaffProvider>(context, listen: false);
    await staffProvider.initialize();
  }

  void _checkForNewOrders(StaffProvider staffProvider) {
    final allOrders = staffProvider.allOrders;
    if (allOrders.isNotEmpty) {
      final latestOrder = allOrders.first;
      if (_lastNewOrder == null ||
          latestOrder.idOrder != _lastNewOrder!.idOrder) {
        _lastNewOrder = latestOrder;
        _showNewOrderNotification(latestOrder);

        // Play notification sound
        final speechService = SpeechService();
        speechService.playNotificationSound();
      }
    }
  }

  void _showNewOrderNotification(Order order) {
    setState(() {
      _showNotification = true;
    });

    // Auto hide after 5 seconds
    Future.delayed(const Duration(seconds: 5), () {
      if (mounted) {
        setState(() {
          _showNotification = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        title: const Text('T2K Coffee - Pha chế'),
        backgroundColor: AppTheme.primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          // Connection status
          Consumer<StaffProvider>(
            builder: (context, staffProvider, child) {
              return ConnectionStatusWidget(
                isConnected: staffProvider.isConnected,
                isConnecting: false,
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        staffProvider.isConnected
                            ? 'WebSocket đã kết nối'
                            : 'WebSocket chưa kết nối',
                      ),
                      duration: Duration(seconds: 2),
                    ),
                  );
                },
              );
            },
          ),
          const SizedBox(width: 8),
          // Reload button
          Consumer<StaffProvider>(
            builder: (context, staffProvider, child) {
              return IconButton(
                icon: const Icon(Icons.refresh),
                onPressed: staffProvider.refreshOrders,
              );
            },
          ),
          Consumer<AuthProvider>(
            builder: (context, authProvider, child) {
              return PopupMenuButton<String>(
                icon: const Icon(Icons.account_circle),
                onSelected: (value) {
                  if (value == 'logout') {
                    _showLogoutDialog(context, authProvider);
                  }
                },
                itemBuilder: (context) => [
                  PopupMenuItem(
                    value: 'profile',
                    child: Row(
                      children: [
                        const Icon(Icons.person, size: 20),
                        const SizedBox(width: 8),
                        Text(authProvider.currentUser?.fullName ?? 'Staff'),
                      ],
                    ),
                  ),
                  const PopupMenuItem(
                    value: 'logout',
                    child: Row(
                      children: [
                        Icon(
                          Icons.logout,
                          size: 20,
                          color: AppTheme.errorColor,
                        ),
                        SizedBox(width: 8),
                        Text(
                          'Đăng xuất',
                          style: TextStyle(color: AppTheme.errorColor),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
      body: Consumer<StaffProvider>(
        builder: (context, staffProvider, child) {
          // Check for new orders
          WidgetsBinding.instance.addPostFrameCallback((_) {
            _checkForNewOrders(staffProvider);
          });

          return Stack(
            children: [
              Column(
                children: [
                  _buildStatusBar(staffProvider),
                  Expanded(child: _buildMainContent(staffProvider)),
                ],
              ),
              // Notification overlay
              if (_showNotification && _lastNewOrder != null)
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: NotificationBanner(
                    title: 'Đơn hàng mới!',
                    message:
                        'Đơn hàng #${_lastNewOrder!.idOrder} - ${_lastNewOrder!.displayLocation}',
                    onTap: () {
                      setState(() {
                        _showNotification = false;
                      });
                    },
                    onDismiss: () {
                      setState(() {
                        _showNotification = false;
                      });
                    },
                  ),
                ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildStatusBar(StaffProvider staffProvider) {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.white,
      child: Row(
        children: [
          Expanded(
            child: _buildStatusCard(
              'Đơn hàng mới',
              staffProvider.newOrdersCount.toString(),
              AppTheme.warningColor,
              Icons.add_circle_outline,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _buildStatusCard(
              'Đang chế biến',
              staffProvider.preparingOrdersCount.toString(),
              AppTheme.accentColor,
              Icons.coffee,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _buildStatusCard(
              'Sẵn sàng',
              staffProvider.readyOrdersCount.toString(),
              AppTheme.successColor,
              Icons.check_circle_outline,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusCard(
    String title,
    String count,
    Color color,
    IconData icon,
  ) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 4),
          Text(
            count,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: color,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildMainContent(StaffProvider staffProvider) {
    if (staffProvider.isLoading) {
      return const Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(AppTheme.primaryColor),
        ),
      );
    }

    return Column(
      children: [
        // Quick actions
        Container(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Expanded(
                child: CustomButton(
                  text: 'Quản lý đơn hàng',
                  onPressed: () => context.push('/staff/orders'),
                  icon: Icons.receipt_long,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: CustomButton(
                  text: 'Sẵn sàng nhận đơn',
                  onPressed: () => staffProvider.notifyReady(),
                  isOutlined: true,
                  icon: Icons.notifications_active,
                ),
              ),
            ],
          ),
        ),

        // Orders list
        Expanded(child: _buildOrdersList(staffProvider)),
      ],
    );
  }

  Widget _buildOrdersList(StaffProvider staffProvider) {
    final allOrders = staffProvider.allOrders;

    if (allOrders.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.coffee_outlined,
              size: 64,
              color: AppTheme.textSecondary,
            ),
            const SizedBox(height: 16),
            Text(
              'Chưa có đơn hàng nào',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text(
              'Đơn hàng mới sẽ hiển thị ở đây',
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: allOrders.length,
      itemBuilder: (context, index) {
        final order = allOrders[index];
        return StaffOrderCard(
          order: order,
          onStatusUpdate: (newStatus) =>
              staffProvider.updateOrderStatus(order.idOrder!, newStatus),
        );
      },
    );
  }

  void _showLogoutDialog(BuildContext context, AuthProvider authProvider) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Đăng xuất'),
        content: const Text('Bạn có chắc muốn đăng xuất?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Hủy'),
          ),
          TextButton(
            onPressed: () async {
              await authProvider.logout();
              if (context.mounted) {
                Navigator.of(context).pop();
                context.go('/login');
              }
            },
            child: const Text('Đăng xuất'),
          ),
        ],
      ),
    );
  }
}
