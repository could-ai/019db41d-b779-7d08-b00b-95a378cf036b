import 'cart_item.dart';
import 'user_model.dart';

enum OrderStatus {
  placed,
  preparing,
  outForDelivery,
  delivered,
  cancelled
}

class OrderModel {
  final String id;
  final String userId;
  final List<CartItem> items;
  final OrderStatus status;
  final DateTime createdAt;
  final double deliveryFee;
  final double totalAmount;
  final Address deliveryAddress;
  final String paymentMethod; // e.g., 'UPI', 'COD'

  OrderModel({
    required this.id,
    required this.userId,
    required this.items,
    required this.status,
    required this.createdAt,
    required this.deliveryFee,
    required this.totalAmount,
    required this.deliveryAddress,
    required this.paymentMethod,
  });
}