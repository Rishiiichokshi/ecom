import 'dart:convert';


//this is class basically a template structuer 
//for a product it convrets dart to json and json to dart, It's like a translator.
//Think of it as a set of instructions on how your app should understand and work with product information
class Products {
  final String id;
  final String name;
  final String title;
  final String category;
  final List<String> imageUrl;
  final String oldPrice;
  final List<dynamic>? sizes;
  final String price;
  final String description;

  Products({
    required this.id,
    required this.name,
    required this.title,
    required this.category,
    required this.imageUrl,
    required this.oldPrice,
    required this.sizes,
    required this.price,
    required this.description,
  });

  factory Products.fromJson(Map<String, dynamic> json) => Products(
        id: json["_id"] ?? "",
        name: json["name"] ?? "",
        title: json["title"] ?? "",
        category: json["category"] ?? "",
        imageUrl: (json["imageUrl"] as List<dynamic>?)
                ?.map((imageUrl) => imageUrl.toString())
                .toList() ??
            [],
        oldPrice: json["oldPrice"] ?? "",
        sizes: (json["sizes"] as List<dynamic>?) ?? [],
        price: json["price"] ?? "",
        description: json["description"] ?? "",
      );

  static List<Products> productsFromJson(String str) =>
      List<Products>.from((json.decode(str) as List<dynamic>? ?? [])
          .map((x) => Products.fromJson(x as Map<String, dynamic>)));

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "title": title,
        "category": category,
        "imageUrl": List<dynamic>.from(imageUrl.map((x) => x)),
        "oldPrice": oldPrice,
        "sizes": sizes,
        "price": price,
        "description": description,
      };
}
