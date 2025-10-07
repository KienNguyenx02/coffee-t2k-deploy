import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../models/product.dart';
import '../../models/cart_item.dart';
import '../../providers/cart_provider.dart';
import '../../utils/app_theme.dart';
import '../../widgets/custom_button.dart';

class ProductDetailScreen extends StatefulWidget {
  final Product product;

  const ProductDetailScreen({super.key, required this.product});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  String _selectedSize = 'M';
  String _iceLevel = 'Bình thường';
  String _sugarLevel = 'Bình thường';
  List<String> _selectedToppings = [];
  int _quantity = 1;

  final List<String> _sizes = ['S', 'M', 'L'];
  final List<String> _iceLevels = [
    'Không đá',
    'Ít đá',
    'Bình thường',
    'Nhiều đá',
  ];
  final List<String> _sugarLevels = [
    'Không đường',
    'Ít đường',
    'Bình thường',
    'Nhiều đường',
  ];
  final List<String> _toppings = [
    'Trân châu',
    'Thạch dừa',
    'Kem cheese',
    'Đậu đỏ',
    'Kem tươi',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        title: Text(widget.product.productName ?? 'Chi tiết sản phẩm'),
        backgroundColor: AppTheme.primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image
            Container(
              height: 300,
              width: double.infinity,
              child: CachedNetworkImage(
                imageUrl: widget.product.imageUrl,
                width: double.infinity,
                height: 300,
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(
                  color: AppTheme.backgroundColor,
                  child: const Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        AppTheme.primaryColor,
                      ),
                    ),
                  ),
                ),
                errorWidget: (context, url, error) => Container(
                  color: AppTheme.backgroundColor,
                  child: const Center(
                    child: Icon(
                      Icons.image_not_supported,
                      color: AppTheme.textSecondary,
                      size: 80,
                    ),
                  ),
                ),
              ),
            ),

            // Product Info
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Product Name
                  Text(
                    widget.product.productName ?? 'Unknown Product',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.textPrimary,
                    ),
                  ),

                  const SizedBox(height: 8),

                  // Price
                  Text(
                    widget.product.formattedPrice,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.primaryColor,
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Description
                  Text(
                    'Mô tả',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: AppTheme.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.product.description ?? 'Không có mô tả',
                    style: const TextStyle(
                      fontSize: 16,
                      color: AppTheme.textSecondary,
                      height: 1.5,
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Size Selection
                  _buildSectionTitle('Kích thước'),
                  const SizedBox(height: 8),
                  _buildSizeSelector(),

                  const SizedBox(height: 20),

                  // Ice Level
                  _buildSectionTitle('Mức độ đá'),
                  const SizedBox(height: 8),
                  _buildIceSelector(),

                  const SizedBox(height: 20),

                  // Sugar Level
                  _buildSectionTitle('Mức độ đường'),
                  const SizedBox(height: 8),
                  _buildSugarSelector(),

                  const SizedBox(height: 20),

                  // Toppings
                  _buildSectionTitle('Topping'),
                  const SizedBox(height: 8),
                  _buildToppingsSelector(),

                  const SizedBox(height: 20),

                  // Quantity
                  _buildSectionTitle('Số lượng'),
                  const SizedBox(height: 8),
                  _buildQuantitySelector(),

                  const SizedBox(height: 32),

                  // Add to Cart Button
                  _buildAddToCartButton(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: AppTheme.textPrimary,
      ),
    );
  }

  Widget _buildSizeSelector() {
    return Row(
      children: _sizes.map((size) {
        final isSelected = _selectedSize == size;
        return Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: GestureDetector(
              onTap: () => setState(() => _selectedSize = size),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: isSelected ? AppTheme.primaryColor : Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: isSelected
                        ? AppTheme.primaryColor
                        : AppTheme.textSecondary,
                  ),
                ),
                child: Text(
                  size,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: isSelected ? Colors.white : AppTheme.textPrimary,
                  ),
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildIceSelector() {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: _iceLevels.map((level) {
        final isSelected = _iceLevel == level;
        return GestureDetector(
          onTap: () => setState(() => _iceLevel = level),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: isSelected ? AppTheme.primaryColor : Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: isSelected
                    ? AppTheme.primaryColor
                    : AppTheme.textSecondary,
              ),
            ),
            child: Text(
              level,
              style: TextStyle(
                fontSize: 14,
                color: isSelected ? Colors.white : AppTheme.textPrimary,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildSugarSelector() {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: _sugarLevels.map((level) {
        final isSelected = _sugarLevel == level;
        return GestureDetector(
          onTap: () => setState(() => _sugarLevel = level),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: isSelected ? AppTheme.primaryColor : Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: isSelected
                    ? AppTheme.primaryColor
                    : AppTheme.textSecondary,
              ),
            ),
            child: Text(
              level,
              style: TextStyle(
                fontSize: 14,
                color: isSelected ? Colors.white : AppTheme.textPrimary,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildToppingsSelector() {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: _toppings.map((topping) {
        final isSelected = _selectedToppings.contains(topping);
        return GestureDetector(
          onTap: () {
            setState(() {
              if (isSelected) {
                _selectedToppings.remove(topping);
              } else {
                _selectedToppings.add(topping);
              }
            });
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: isSelected ? AppTheme.primaryColor : Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: isSelected
                    ? AppTheme.primaryColor
                    : AppTheme.textSecondary,
              ),
            ),
            child: Text(
              topping,
              style: TextStyle(
                fontSize: 14,
                color: isSelected ? Colors.white : AppTheme.textPrimary,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildQuantitySelector() {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            if (_quantity > 1) {
              setState(() => _quantity--);
            }
          },
          child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: _quantity > 1
                  ? AppTheme.primaryColor
                  : AppTheme.textSecondary,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.remove, color: Colors.white),
          ),
        ),
        const SizedBox(width: 16),
        Text(
          '$_quantity',
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppTheme.textPrimary,
          ),
        ),
        const SizedBox(width: 16),
        GestureDetector(
          onTap: () {
            if (_quantity < 10) {
              setState(() => _quantity++);
            }
          },
          child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: _quantity < 10
                  ? AppTheme.primaryColor
                  : AppTheme.textSecondary,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.add, color: Colors.white),
          ),
        ),
      ],
    );
  }

  Widget _buildAddToCartButton() {
    return CustomButton(
      text:
          'Thêm vào giỏ - ${(widget.product.price! * _quantity).toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')} đ',
      onPressed: _addToCart,
      height: 50,
    );
  }

  void _addToCart() {
    final cartProvider = Provider.of<CartProvider>(context, listen: false);

    // Create variants
    final variants = ProductVariants(
      size: _selectedSize,
      ice: _iceLevel,
      sugar: _sugarLevel,
      toppings: _selectedToppings,
    );

    // Add to cart with quantity
    cartProvider.addItem(
      widget.product,
      variants: variants,
      quantity: _quantity,
    );

    // Show success message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Đã thêm $_quantity ${widget.product.productName} vào giỏ hàng',
        ),
        backgroundColor: AppTheme.primaryColor,
        duration: const Duration(seconds: 2),
      ),
    );

    // Navigate back
    Navigator.pop(context);
  }
}
