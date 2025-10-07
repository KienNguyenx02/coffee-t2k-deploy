import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/staff_provider.dart';
import '../../models/order.dart';
import '../../utils/app_theme.dart';
import '../../widgets/staff_order_card.dart';
import '../../widgets/loading_widget.dart';

class OrdersManagementScreen extends StatefulWidget {
  const OrdersManagementScreen({super.key});

  @override
  State<OrdersManagementScreen> createState() => _OrdersManagementScreenState();
}

class _OrdersManagementScreenState extends State<OrdersManagementScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        title: const Text('Quản lý đơn hàng'),
        backgroundColor: AppTheme.primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          Consumer<StaffProvider>(
            builder: (context, staffProvider, child) {
              return IconButton(
                icon: const Icon(Icons.refresh),
                onPressed: staffProvider.refreshOrders,
              );
            },
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          indicatorColor: Colors.white,
          isScrollable: true,
          tabs: const [
            Tab(text: 'Mới'),
            Tab(text: 'Chế biến'),
            Tab(text: 'Sẵn sàng'),
            Tab(text: 'Gửi món'),
            Tab(text: 'Đã hủy'),
          ],
        ),
      ),
      body: Consumer<StaffProvider>(
        builder: (context, staffProvider, child) {
          if (staffProvider.isLoading) {
            return const LoadingWidget(message: 'Đang tải đơn hàng...');
          }

          return TabBarView(
            controller: _tabController,
            children: [
              _buildOrdersList(staffProvider.getOrdersByStatus('processing')),
              _buildOrdersList(staffProvider.getOrdersByStatus('preparing')),
              _buildOrdersList(staffProvider.getOrdersByStatus('ready')),
              _buildOrdersList(staffProvider.getOrdersByStatus('completed')),
              _buildOrdersList(staffProvider.getOrdersByStatus('cancelled')),
            ],
          );
        },
      ),
    );
  }

  Widget _buildOrdersList(List<Order> orders) {
    if (orders.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.receipt_long_outlined,
              size: 64,
              color: AppTheme.textSecondary,
            ),
            const SizedBox(height: 16),
            Text(
              'Không có đơn hàng nào',
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

    return RefreshIndicator(
      onRefresh: () async {
        final staffProvider = Provider.of<StaffProvider>(
          context,
          listen: false,
        );
        await staffProvider.refreshOrders();
      },
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: orders.length,
        itemBuilder: (context, index) {
          final order = orders[index];
          return StaffOrderCard(
            order: order,
            onStatusUpdate: (newStatus) {
              final staffProvider = Provider.of<StaffProvider>(
                context,
                listen: false,
              );
              staffProvider.updateOrderStatus(order.idOrder!, newStatus);
            },
          );
        },
      ),
    );
  }
}
