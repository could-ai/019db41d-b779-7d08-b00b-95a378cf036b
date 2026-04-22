import '../models/product.dart';

class MockData {
  static final List<Ingredient> _oatsIngredients = [
    Ingredient(id: 'i1', name: 'Oats', isDefault: true),
    Ingredient(id: 'i2', name: 'Milk', isDefault: true),
    Ingredient(id: 'i3', name: 'Banana', isDefault: true),
    Ingredient(id: 'i4', name: 'Peanut Butter', isDefault: true),
    Ingredient(id: 'i5', name: 'Dry Fruits', isDefault: true),
    Ingredient(id: 'i6', name: 'Seeds', isDefault: true),
    Ingredient(id: 'i7', name: 'Honey', isDefault: false, additionalPrice: 15.0),
    Ingredient(id: 'i8', name: 'Extra Protein Scoop', isDefault: false, additionalPrice: 50.0),
  ];

  static final List<Ingredient> _sproutsIngredients = [
    Ingredient(id: 's1', name: 'Sprouted Moong', isDefault: true),
    Ingredient(id: 's2', name: 'Sprouted Chana', isDefault: true),
    Ingredient(id: 's3', name: 'Peanuts', isDefault: true),
    Ingredient(id: 's4', name: 'Cucumber', isDefault: true),
    Ingredient(id: 's5', name: 'Carrot', isDefault: true),
    Ingredient(id: 's6', name: 'Beetroot', isDefault: true),
    Ingredient(id: 's7', name: 'Onion', isDefault: true),
    Ingredient(id: 's8', name: 'Lemon Juice', isDefault: false, additionalPrice: 5.0),
    Ingredient(id: 's9', name: 'Extra Paneer', isDefault: false, additionalPrice: 30.0),
  ];

  static final List<Product> products = [
    Product(
      id: 'p1',
      name: 'Protein Oats Bowl',
      description: 'High protein, high calorie oats bowl perfect for post-workout recovery. No added sugar.',
      imageUrl: 'https://images.unsplash.com/photo-1517673132405-a56a62b18caf?auto=format&fit=crop&q=80&w=800',
      pricePer100g: 99.0,
      themeColor: 'dark',
      nutritionInfo: NutritionInfo(calories: 350, protein: 20, carbs: 45, fats: 12),
      defaultIngredients: _oatsIngredients.where((i) => i.isDefault).toList(),
      availableAddons: _oatsIngredients.where((i) => !i.isDefault).toList(),
    ),
    Product(
      id: 'p2',
      name: 'Sprouts Power Bowl',
      description: 'Fresh and natural sprouts salad with veggies. No oil, no sugar. Fully natural.',
      imageUrl: 'https://images.unsplash.com/photo-1512621776951-a57141f2eefd?auto=format&fit=crop&q=80&w=800',
      pricePer100g: 99.0,
      themeColor: 'green',
      nutritionInfo: NutritionInfo(calories: 220, protein: 12, carbs: 35, fats: 4),
      defaultIngredients: _sproutsIngredients.where((i) => i.isDefault).toList(),
      availableAddons: _sproutsIngredients.where((i) => !i.isDefault).toList(),
    ),
  ];
}