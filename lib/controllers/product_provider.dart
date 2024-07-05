import 'package:shop_online/views/shared/export.dart';
import 'package:shop_online/views/shared/export_packages.dart';

class ProductNotifier extends ChangeNotifier {
  int _activePage = 0;
  List<dynamic> _productSizes = [];
  List<String> _sizes = [];
  final _cartBox = Hive.box('cart_box');

  int get activePage => _activePage;

  set activePage(int newIndex) {
    _activePage = newIndex;
    notifyListeners();
  }

  late Future<List<Products>> male;
  late Future<List<Products>> female;
  late Future<List<Products>> vintageAndRetroStyle;
  // late Future<Products> products;

  void getMale() {
    male = Helper().getMaleProducts();
  }

  void getFemale() {
    female = Helper().getFemaleProducts();
  }

  void getVintageAndRetroStyle() {
    vintageAndRetroStyle = Helper().getVintageAndRetroProducts();
  }

  List<dynamic> get productSizes => _productSizes;

  set productSizes(List<dynamic> newSizes) {
    _productSizes = newSizes;
    notifyListeners();
  }

  void toggleCheck(int index) {
    for (int i = 0; i < _productSizes.length; i++) {
      if (i == index) {
        _productSizes[i]['isSelected'] = !_productSizes[i]['isSelected'];
      }
    }
    notifyListeners();
  }

  Future<void> createCart(Map<String, dynamic> newCart) async {
    await _cartBox.add(newCart);
  }

  List<String> get sizes => _sizes;

  set sizes(List<String> newSizes) {
    _sizes = newSizes;
    notifyListeners();
  }

  // void getProducts(String category, String id) {
  //   if (category == "Men's Fashion") {
  //     products = Helper().getMaleProductsById(id);
  //   } else if (category == "Women's Fashion") {
  //     products = Helper().getFemaleProductsById(id);
  //   } else {
  //     products = Helper().getVintageAndRetroProductsById(id);
  //   }
  // }
}
