import 'product.dart';

class CartItem {
  final String id;
  final Product product;
  final int quantity; // e.g., 1 for 100g, 2 for 200g, etc.
  final List<Ingredient> selectedIngredients;

  CartItem({
    required this.id,
    required this.product,
    required this.quantity,
    required this.selectedIngredients,
  });

  double get totalPrice {
    // Base price calculation: (quantity * 100g)
    double basePrice = product.pricePer100g * quantity;
    
    // Add additional prices from selected ingredients that have an extra cost
    double addOnsPrice = selectedIngredients.fold(
      0.0,
      (sum, ingredient) => sum + ingredient.additionalPrice,
    );
    
    return basePrice + addOnsPrice;
  }

  CartItem copyWith({
    String? id,
    Product? product,
    int? quantity,
    List<Ingredient>? selectedIngredients,
  }) {
    return CartItem(
      id: id ?? this.id,
      product: product ?? this.product,
      quantity: quantity ?? this.quantity,
      selectedIngredients: selectedIngredients ?? this.selectedIngredients,
    );
  }
}