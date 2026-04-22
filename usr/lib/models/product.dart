class Product {
  final String id;
  final String name;
  final String description;
  final String imageUrl;
  final double pricePer100g; // ₹99
  final String themeColor; // 'dark' or 'green'
  final NutritionInfo nutritionInfo;
  final List<Ingredient> defaultIngredients;
  final List<Ingredient> availableAddons;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.pricePer100g,
    required this.themeColor,
    required this.nutritionInfo,
    required this.defaultIngredients,
    required this.availableAddons,
  });
}

class Ingredient {
  final String id;
  final String name;
  final bool isDefault;
  final double additionalPrice; // 0 if included in base price

  Ingredient({
    required this.id,
    required this.name,
    this.isDefault = false,
    this.additionalPrice = 0.0,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Ingredient && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}

class NutritionInfo {
  final double calories;
  final double protein;
  final double carbs;
  final double fats;

  NutritionInfo({
    required this.calories,
    required this.protein,
    required this.carbs,
    required this.fats,
  });
}