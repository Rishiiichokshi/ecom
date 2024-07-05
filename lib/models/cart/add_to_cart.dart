import 'dart:convert';

String addToCartToJson(AddToCart data) => json.encode(data.toJson());

class AddToCart {
  String cartItem; // Ensure 'cartItem' is of type String
  int quantity;

  AddToCart({
    required this.cartItem,
    required this.quantity,
  });

  Map<String, dynamic> toJson() => {
        "cartItem": cartItem,
        "quantity": quantity,
      };
}
