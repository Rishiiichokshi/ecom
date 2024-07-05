import 'package:flutter/material.dart';
import 'package:shop_online/models/orders/orders_res.dart';
import 'package:shop_online/services/cartHelper.dart';
import 'package:shop_online/views/shared/export.dart';

class ProcessOrders extends StatefulWidget {
  const ProcessOrders({super.key});

  @override
  State<ProcessOrders> createState() => _ProcessOrdersState();
}

class _ProcessOrdersState extends State<ProcessOrders> {
  Future<List<PaidOrders>>? _orders;

  @override
  void initState() {
    super.initState();
    _orders = CartHelper().getOrders();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 50,
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white, // Set the color for the back button
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height * 0.9,
          width: MediaQuery.of(context).size.width * 1.2,
          color: Colors.black,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ReusableText(
                  text: 'My Orders',
                  style: appstyle(36, Colors.white, FontWeight.bold),
                ),
                const SizedBox(
                  height: 5,
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.8,
                  width: MediaQuery.of(context).size.height * 0.5,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: FutureBuilder<List<PaidOrders>>(
                    future: _orders,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator.adaptive(),
                        );
                      } else if (snapshot.hasError) {
                        return Center(
                          child: ReusableText(
                            text: "Error ${snapshot.error}",
                            style: appstyle(18, Colors.black, FontWeight.bold),
                          ),
                        );
                      } else {
                        final products = snapshot.data;
                        return ListView.builder(
                          itemCount: products!.length,
                          itemBuilder: (context, index) {
                            var order = products[index];
                            return Container(
                              margin: const EdgeInsets.all(8),
                              padding: const EdgeInsets.all(8),
                              height: MediaQuery.of(context).size.height *
                                  0.13, // Adjusted height
                              decoration: BoxDecoration(
                                color: Colors.black12,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: 70, // Adjusted image width
                                    height: 70, // Adjusted image height
                                    decoration: const BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(12),
                                      ),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: Image.network(
                                        order.productId.imageUrl[0],
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      ReusableText(
                                        text: order.productId.name,
                                        style: appstyle(
                                            15, Colors.black, FontWeight.bold),
                                      ),
                                      const SizedBox(
                                        height: 3,
                                      ),
                                      ConstrainedBox(
                                        constraints: const BoxConstraints(
                                          maxWidth: 325 *
                                              0.58, // Set your desired maximum width
                                        ),
                                        child: ReusableText(
                                          text: order.productId.title,
                                          style: appstyle(12, Colors.black,
                                              FontWeight.w600),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      ReusableText(
                                        text: "\$ ${order.productId.price}",
                                        style: appstyle(
                                            13, Colors.black, FontWeight.w600),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 25),
                                        decoration: BoxDecoration(
                                          color: Colors.black,
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        child: ReusableText(
                                          text:
                                              order.paymentStatus.toUpperCase(),
                                          style: appstyle(12, Colors.white,
                                              FontWeight.w600),
                                        ),
                                      )
                                    ],
                                  )
                                ],
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
          ),
        ),
      ),
    );
  }
}
