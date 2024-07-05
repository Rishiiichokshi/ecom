// ignore: file_names
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_online/models/cart/add_to_cart.dart';
import 'package:shop_online/models/cart/get_products.dart';
import 'package:shop_online/models/orders/orders_res.dart';
import 'package:shop_online/services/config.dart';
import 'package:shop_online/views/shared/export_packages.dart' as http;

class CartHelper {
  static var client = http.Client();

  Future<bool> addToCart(AddToCart model) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userToken = prefs.getString('token');
    Map<String, String> requestHeaders = {
      'content-type': 'application/json',
      'token': 'Bearer $userToken',
    };

    var url = Uri.https(Config.apiUrl, Config.addCartUrl);

    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode(model.toJson()),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<List<Product>> getCart() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userToken = prefs.getString('token');
    Map<String, String> requestHeaders = {
      'content-type': 'application/json',
      'token': 'Bearer $userToken',
    };

    var url = Uri.https(Config.apiUrl, Config.getCartUrl);

    var response = await client.get(
      url,
      headers: requestHeaders,
    );

    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      List<Product> cart = [];

      if (jsonData.containsKey('products')) {
        var products = jsonData['products'];

        cart = List<Product>.from(
          products.map(
            (product) => Product.fromJson(product),
          ),
        );
      }

      return cart;
    } else {
      throw Exception("Failed to get Cart Items");
    }
  }

  Future<bool> deleteItem(String id) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userToken = prefs.getString('token');
    Map<String, String> requestHeaders = {
      'content-type': 'application/json',
      'token': 'Bearer $userToken',
    };

    var url = Uri.https(Config.apiUrl, "${Config.addCartUrl}/$id");

    var response = await client.delete(
      url,
      headers: requestHeaders,
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<List<PaidOrders>> getOrders() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String? userToken = prefs.getString('token');
      Map<String, String> requestHeaders = {
        'content-type': 'application/json',
        'token': 'Bearer $userToken',
      };

      var url = Uri.http(Config.apiUrl, Config.orders);

      var response = await client.get(
        url,
        headers: requestHeaders,
      );

      if (response.statusCode == 200) {
        var products = paidOrdersFromJson(response.body);
        return products;
      } else {
        throw Exception("Failed to get orders");
      }
    } catch (e) {
      throw Exception("Failed to get orders: $e");
    }
  }
}
