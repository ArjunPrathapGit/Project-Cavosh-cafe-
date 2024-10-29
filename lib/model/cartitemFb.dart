class CartItem {
  final String id;
  final String image;
  final String name;
  final double rate;
  final int quantity; // Ensure you have this field

  CartItem({
    required this.id,
    required this.image,
    required this.name,
    required this.rate,
    required this.quantity,
  });

  // Create a method to convert Firestore data into a CartItem object
  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      id: json['id'] ?? '',
      image: json['image'] ?? '',
      name: json['name'] ?? '',
      rate: json['rate']?.toDouble() ?? 0.0,
      quantity: json['quantity'] ?? 1, // Default to 1 if not provided
    );
  }

  // Convert a CartItem object to JSON format
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'image': image,
      'name': name,
      'rate': rate,
      'quantity': quantity,
    };
  }
}
