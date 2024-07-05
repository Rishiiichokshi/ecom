import 'package:shop_online/services/config.dart';
import 'package:shop_online/views/shared/export.dart';
import 'package:http/http.dart' as http;

class Helper {
  static var client = http.Client();
  Future<List<Products>> getMaleProducts() async {
    var url = Uri.http(Config.apiUrl, Config.products);
    var response = await client.get(url);

    if (response.statusCode == 200) {
      var maleList = Products.productsFromJson(response.body);
      var male =
          maleList.where((element) => element.category == "Men's Fashion");
      return male.toList();
    } else {
      throw Exception("Failed to get products list");
    }
  }

  Future<List<Products>> getFemaleProducts() async {
    var url = Uri.http(Config.apiUrl, Config.products);
    var response = await client.get(url);

    if (response.statusCode == 200) {
      var femaleList = Products.productsFromJson(response.body);
      var female =
          femaleList.where((element) => element.category == "Women's Fashion");
      return female.toList();
    } else {
      throw Exception("Failed to get products list");
    }
  }

  Future<List<Products>> getVintageAndRetroProducts() async {
    var url = Uri.http(Config.apiUrl, Config.products);
    var response = await client.get(url);

    if (response.statusCode == 200) {
      var vintageAndRetroList = Products.productsFromJson(response.body);
      var vintageAndRetro = vintageAndRetroList
          .where((element) => element.category == "Vintage and Retro Style");
      return vintageAndRetro.toList();
    } else {
      throw Exception("Failed to get products list");
    }
  }

  Future<List<Products>> search(String searchQuerry) async {
    var url = Uri.http(Config.apiUrl, "${Config.search}$searchQuerry");

    var response = await client.get(url);
    if (response.statusCode == 200) {
      var results = Products.productsFromJson(response.body);

      return results;
    } else {
      throw Exception("Failed to get products list");
    }
  }
}
