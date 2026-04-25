import 'package:flutter/foundation.dart';
import '../models/order_model.dart';
import '../models/cart_item.dart';
import '../models/user_model.dart';
import 'package:uuid/uuid.dart';

class OrderProvider with ChangeNotifier {
  final List<OrderModel> _orders = [];
  final _uuid = const Uuid();

  List<OrderModel> get orders => [..._orders].reversed.toList();

  void addOrder(List<CartItem> cartItems, double totalAmount) {
    final newOrder = OrderModel(
      id: _uuid.v4(),
      userId: 'user_1', // Mock user ID
      items: List.from(cartItems),
      totalAmount: totalAmount,
      status: OrderStatus.preparing,
      createdAt: DateTime.now(),
      deliveryAddress: Address(
        id: '1',
        type: 'Home',
        street: '123 Health Street',
        city: 'Ahmedabad',
        pincode: '380015',
      ), // Mock address
      deliveryFee: 40.0,
      paymentMethod: 'UPI',
    );

    _orders.add(newOrder);
    notifyListeners();
  }
}