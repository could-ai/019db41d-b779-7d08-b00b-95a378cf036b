import 'package:flutter/foundation.dart';
import '../models/product.dart';
import '../core/mock_data.dart';

class ProductProvider with ChangeNotifier {
  List<Product> _products = [];
  bool _isLoading = false;

  List<Product> get products => _products;
  bool get isLoading => _isLoading;

  ProductProvider() {
    loadProducts();
  }

  Future<void> loadProducts() async {
    _isLoading = true;
    notifyListeners();

    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 800));
    _products = MockData.products;

    _isLoading = false;
    notifyListeners();
  }
}