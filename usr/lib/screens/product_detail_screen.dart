import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/product.dart';
import '../providers/product_provider.dart';
import '../providers/cart_provider.dart';
import '../theme/app_theme.dart';

class ProductDetailScreen extends StatefulWidget {
  final String productId;

  const ProductDetailScreen({super.key, required this.productId});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int _quantityInGrams = 100;
  final Set<String> _selectedAddons = {};

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context, listen: false);
    
    // Find the product
    final Product? product = productProvider.products.cast<Product?>().firstWhere(
      (p) => p?.id == widget.productId, 
      orElse: () => null
    );

    if (product == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Error')),
        body: const Center(child: Text('Product not found')),
      );
    }

    final isDark = product.themeColor == 'dark';
    final themeColor = isDark ? AppTheme.darkBrown : AppTheme.primaryGreen;
    final onThemeColor = Colors.white;

    // Calculate total price
    double basePrice = (product.pricePer100g / 100) * _quantityInGrams;
    double addonsPrice = 0;
    for (var addonId in _selectedAddons) {
      final addon = product.availableAddons.firstWhere((a) => a.id == addonId);
      addonsPrice += addon.additionalPrice;
    }
    double totalPrice = basePrice + addonsPrice;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 250.0,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                product.imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(color: Colors.grey[300]),
              ),
            ),
            iconTheme: const IconThemeData(color: Colors.white),
          ),
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.all(20.0),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          product.name,
                          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Text(
                        '₹${product.pricePer100g.toInt()}/100g',
                        style: TextStyle(
                          color: themeColor,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    product.description,
                    style: TextStyle(color: Colors.grey[600], height: 1.5),
                  ),
                  const SizedBox(height: 20),
                  _buildNutritionSection(product),
                  const SizedBox(height: 24),
                  
                  // Quantity Selector
                  Text('Quantity (grams)', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      _buildQuantityButton(Icons.remove, () {
                        if (_quantityInGrams > 100) {
                          setState(() => _quantityInGrams -= 50);
                        }
                      }, themeColor),
                      const SizedBox(width: 20),
                      Text(
                        '${_quantityInGrams}g',
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(width: 20),
                      _buildQuantityButton(Icons.add, () {
                        if (_quantityInGrams < 1000) {
                          setState(() => _quantityInGrams += 50);
                        }
                      }, themeColor),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Ingredients Section
                  Text('Included Ingredients', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: product.defaultIngredients.map((i) => Chip(
                      label: Text(i.name),
                      backgroundColor: Colors.grey[200],
                      side: BorderSide.none,
                    )).toList(),
                  ),
                  const SizedBox(height: 24),

                  // Add-ons Section
                  if (product.availableAddons.isNotEmpty) ...[
                    Text('Add-ons', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10),
                    ...product.availableAddons.map((addon) {
                      final isSelected = _selectedAddons.contains(addon.id);
                      return CheckboxListTile(
                        title: Text(addon.name),
                        subtitle: addon.additionalPrice > 0 ? Text('+₹${addon.additionalPrice.toInt()}') : null,
                        value: isSelected,
                        activeColor: themeColor,
                        onChanged: (bool? value) {
                          setState(() {
                            if (value == true) {
                              _selectedAddons.add(addon.id);
                            } else {
                              _selectedAddons.remove(addon.id);
                            }
                          });
                        },
                        contentPadding: EdgeInsets.zero,
                        controlAffinity: ListTileControlAffinity.leading,
                      );
                    }).toList(),
                  ],
                  const SizedBox(height: 100), // Padding for bottom bar
                ],
              ),
            ),
          ),
        ],
      ),
      bottomSheet: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: SafeArea(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Total Price', style: TextStyle(color: Colors.grey)),
                  Text(
                    '₹${totalPrice.toStringAsFixed(0)}',
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: () {
                  final selectedAddonIngredients = product.availableAddons
                      .where((a) => _selectedAddons.contains(a.id))
                      .toList();
                  
                  Provider.of<CartProvider>(context, listen: false).addToCart(
                    product: product,
                    quantityInGrams: _quantityInGrams,
                    selectedAddons: selectedAddonIngredients,
                  );
                  
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Added to cart!'), duration: Duration(seconds: 2)),
                  );
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: themeColor,
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                ),
                child: Text('Add to Cart', style: TextStyle(color: onThemeColor, fontSize: 16, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNutritionSection(Product product) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNutritionItem('Calories', '${product.nutritionInfo.calories.toInt()}'),
          _buildNutritionItem('Protein', '${product.nutritionInfo.protein}g'),
          _buildNutritionItem('Carbs', '${product.nutritionInfo.carbs}g'),
          _buildNutritionItem('Fats', '${product.nutritionInfo.fats}g'),
        ],
      ),
    );
  }

  Widget _buildNutritionItem(String label, String value) {
    return Column(
      children: [
        Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 4),
        Text(label, style: TextStyle(color: Colors.grey[600], fontSize: 12)),
      ],
    );
  }

  Widget _buildQuantityButton(IconData icon, VoidCallback onPressed, Color color) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Icon(icon, color: color),
      ),
    );
  }
}