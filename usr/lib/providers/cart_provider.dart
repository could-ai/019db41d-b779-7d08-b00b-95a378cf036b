import 'package:flutter/foundation.dart';
import '../models/cart_item.dart';
import '../models/product.dart';

class CartProvider with ChangeNotifier {
  final List<CartItem> _items = [];
  final double _deliveryFee = 40.0; // Flat fee for Ahmedabad

  List<CartItem> get items => _items;
  double get deliveryFee => _deliveryFee;

  int get itemCount => _items.length;

  double get subtotalAmount {
    return _items.fold(0.0, (sum, item) => sum + item.totalPrice);
  }

  double get totalAmount {
    if (_items.isEmpty) return 0.0;
    return subtotalAmount + _deliveryFee;
  }

  void addToCart(Product product, int quantity, List<Ingredient> selectedIngredients) {
    // Check if identical item exists (same product, quantity, and ingredients)
    final existingIndex = _items.indexWhere(
      (item) =>
          item.product.id == product.id &&
          item.quantity == quantity &&
          listEquals(item.selectedIngredients, selectedIngredients),
    );

    if (existingIndex >= 0) {
      // Just a conceptual add: since it's a food bowl customized, you might want to increase count of this configuration,
      // but for simplicity, we add it as a new distinct item or update quantity if we have a separate count.
      // Let's add as new item with unique ID.
    }
    
    // We will use a mock ID generator here
    final String newItemId = DateTime.now().millisecondsSinceEpoch.toString();
    _items.add(
      CartItem(
        id: newItemId,
        product: product,
        quantity: quantity,
        selectedIngredients: selectedIngredients,
      ),
    );
    notifyListeners();
  }

  void removeItem(String itemId) {
    _items.removeWhere((item) => item.id == itemId);
    notifyListeners();
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }
}

// Simple helper to check list equality
bool listEquals<T>(List<T>? a, List<T>? b) {
  if (a == null) return b == null;
  if (b == null || a.length != b.length) return false;
  for (int i = 0; i < a.length; i++) {
    if (a[i] != b[i]) return false;
  }
  return true;
}