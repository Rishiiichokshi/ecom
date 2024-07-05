import 'package:feather_icons/feather_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_online/controllers/payment_provider.dart';
import 'package:shop_online/models/cart/get_products.dart';
import 'package:shop_online/models/orders/orders_req.dart';
import 'package:shop_online/payments/paymentswebview.dart';
import 'package:shop_online/services/cartHelper.dart';
import 'package:shop_online/services/payment_helper.dart';
import 'package:shop_online/views/shared/export.dart';
import 'package:shop_online/views/shared/export_packages.dart';

class Cartpage extends StatefulWidget {
  const Cartpage({super.key});

  @override
  State<Cartpage> createState() => _CartpageState();
}

class _CartpageState extends State<Cartpage> {
  late Future<List<Product>> _cartList;

  @override
  void initState() {
    _cartList = CartHelper().getCart();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var cartProvider = Provider.of<CartProvider>(context);
    var paymentNotifier = Provider.of<PaymentNotifier>(context);
    return paymentNotifier.paymentUrl.contains('https')
        ? const PaymentsWebView()
        : Scaffold(
            backgroundColor: const Color(0xFFE2E2E2),
            body: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Icon(
                          Ionicons.chevron_back,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'My Cart',
                        style: appstyle(32, Colors.black, FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.60,
                        child: FutureBuilder(
                          future: _cartList,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                child: CircularProgressIndicator.adaptive(),
                              );
                            } else if (snapshot.hasError) {
                              return Center(
                                child: ReusableText(
                                  text: "Failed to Get Cart Data",
                                  style: appstyle(
                                      18, Colors.black, FontWeight.w600),
                                ),
                              );
                            } else {
                              final cartData = snapshot.data;
                              return ListView.builder(
                                itemCount: cartData!.length,
                                padding: EdgeInsets.zero,
                                itemBuilder: (context, index) {
                                  final data = cartData[index];
                                  return GestureDetector(
                                    onTap: () {
                                      cartProvider.setProductIndex = index;
                                      cartProvider.checkout.insert(0, data);
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(8),
                                      child: ClipRRect(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(12)),
                                        child: Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.15,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          decoration: BoxDecoration(
                                            color: Colors.grey.shade100,
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey.shade500,
                                                spreadRadius: 5,
                                                blurRadius: 0.3,
                                                offset: const Offset(0, 1),
                                              ),
                                            ],
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  Stack(
                                                    clipBehavior: Clip.none,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(13),
                                                        child:
                                                            CachedNetworkImage(
                                                          imageUrl: data
                                                              .cartItem
                                                              .imageUrl[0],
                                                          height: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .height *
                                                              0.1,
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              0.15,
                                                          fit: BoxFit.fill,
                                                        ),
                                                      ),
                                                      Positioned(
                                                        top: -20,
                                                        left: -11,
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child:
                                                              GestureDetector(
                                                            onTap: () async {},
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: Icon(
                                                                cartProvider.productIndex ==
                                                                        index
                                                                    ? FeatherIcons
                                                                        .checkCircle
                                                                    : FeatherIcons
                                                                        .circle,
                                                                size: 22,
                                                                color:
                                                                    Colors.blue,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Positioned(
                                                        bottom: -16,
                                                        left: -8,
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child:
                                                              GestureDetector(
                                                            onTap: () async {
                                                              await CartHelper()
                                                                  .deleteItem(
                                                                      data.id)
                                                                  .then(
                                                                      (response) {
                                                                if (response ==
                                                                    true) {
                                                                  Navigator
                                                                      .pushReplacement(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                      builder:
                                                                          (context) =>
                                                                              MainScreen(),
                                                                    ),
                                                                  );
                                                                } else {
                                                                  debugPrint(
                                                                      "Failed to Delete Item");
                                                                }
                                                              });
                                                            },
                                                            child: Container(
                                                              width: 40,
                                                              height: 30,
                                                              decoration:
                                                                  const BoxDecoration(
                                                                borderRadius: BorderRadius.only(
                                                                    topRight: Radius
                                                                        .circular(
                                                                            12)),
                                                                color: Colors
                                                                    .black,
                                                              ),
                                                              child:
                                                                  const Padding(
                                                                padding:
                                                                    EdgeInsets
                                                                        .all(
                                                                            8.0),
                                                                child: Icon(
                                                                  Ionicons
                                                                      .trash_sharp,
                                                                  size: 20,
                                                                  color: Colors
                                                                      .grey,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 12, left: 20),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        SizedBox(
                                                          width:
                                                              200, // Set your desired width here
                                                          child: Text(
                                                            data.cartItem.name,
                                                            style: appstyle(
                                                                16,
                                                                Colors.black,
                                                                FontWeight
                                                                    .bold),
                                                            maxLines: 1,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                            height: 10),
                                                        Text(
                                                          data.cartItem
                                                              .category,
                                                          style: appstyle(
                                                            14,
                                                            Colors.black,
                                                            FontWeight.w600,
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                            height: 10),
                                                        Row(
                                                          children: [
                                                            Text(
                                                              '₹ ${data.cartItem.price}',
                                                              style: appstyle(
                                                                18,
                                                                Colors.black,
                                                                FontWeight.w600,
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                                width: 30),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Consumer<CartProvider>(
                                                  builder: (context,
                                                      cartProvider, _) {
                                                    return Container(
                                                      decoration:
                                                          const BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                          Radius.circular(16),
                                                        ),
                                                        color: Colors.white,
                                                      ),
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          InkWell(
                                                            onTap: () {
                                                              cartProvider
                                                                  .decrement(); // Decrease quantity
                                                            },
                                                            child: const Icon(
                                                              Ionicons
                                                                  .remove_circle,
                                                              size: 20,
                                                              color:
                                                                  Colors.grey,
                                                            ),
                                                          ),
                                                          Text(
                                                            data.quantity
                                                                .toString(), // Use your data to display the quantity
                                                            style: appstyle(
                                                              16,
                                                              Colors.black,
                                                              FontWeight.w600,
                                                            ),
                                                          ),
                                                          InkWell(
                                                            onTap: () {
                                                              cartProvider
                                                                  .increment(); // Increase quantity
                                                            },
                                                            child: const Icon(
                                                              Ionicons
                                                                  .add_circle,
                                                              size: 20,
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              );
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                  cartProvider.checkout.isNotEmpty
                      ? Align(
                          alignment: Alignment.bottomCenter,
                          child: CheckoutButton(
                              onTap: () async {
                                final SharedPreferences prefs =
                                    await SharedPreferences.getInstance();
                                String? userId =
                                    prefs.getString('userId') ?? "";
                                Order model = Order(userId: userId, cartItems: [
                                  CartItem(
                                      name: cartProvider
                                          .checkout[0].cartItem.name,
                                      id: cartProvider.checkout[0].cartItem.id,
                                      price: cartProvider
                                          .checkout[0].cartItem.price,
                                      cartQuantity: 1),
                                ]);
                                PaymentHelper().payment(model).then((value) {
                                  paymentNotifier.setPaymentUrl = value;
                                });
                              },
                              label: "Proceed To Checkout"),
                        )
                      : const SizedBox.shrink(),
                ],
              ),
            ),
          );
  }

  void doNothing(BuildContext context) {}
}
