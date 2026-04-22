import 'package:flutter/foundation.dart';
import '../models/order_model.dart';
import '../models/cart_item.dart';
import 'package:uuid/uuid.dart';

class OrderProvider with ChangeNotifier {
  final List<Order> _orders = [];
  final _uuid = const Uuid();

  List<Order> get orders => [..._orders].reversed.toList();

  void addOrder(List<CartItem> cartItems, double totalAmount) {
    final newOrder = Order(
      id: _uuid.v4(),
      userId: 'user_1', // Mock user ID
      items: List.from(cartItems),
      totalAmount: totalAmount,
      status: OrderStatus.processing,
      createdAt: DateTime.now(),
      deliveryAddress: '123 Health Street, Ahmedabad', // Mock address
    );

    _orders.add(newOrder);
    notifyListeners();
  }
}