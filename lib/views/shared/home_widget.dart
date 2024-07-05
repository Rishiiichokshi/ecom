import 'export.dart';
import 'export_packages.dart';

class HomeWidget extends StatelessWidget {
  const HomeWidget({
    super.key,
    required Future<List<Products>> male,
    required this.tabIndex,
  }) : _male = male;

  final Future<List<Products>> _male;
  final int tabIndex;

  @override
  Widget build(BuildContext context) {
    var productNotifier = Provider.of<ProductNotifier>(context);
    return Column(
      children: [
        SizedBox(
          height: 40.h,
          child: FutureBuilder<List<Products>>(
            future: _male,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator.adaptive(),
                );
              } else if (snapshot.hasError) {
                return Text("Error ${snapshot.error}");
              } else {
                final male = snapshot.data;
                return ListView.builder(
                    itemCount: male!.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      final product = snapshot.data![index];
                      return GestureDetector(
                        onTap: () {
                          productNotifier.productSizes = product.sizes!;
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProductPage(
                                products: product,
                              ),
                            ),
                          );
                        },
                        child: ProductCard(
                          category: product.category,
                          image: product.imageUrl[0],
                          price: "\$${product.price}",
                          id: product.id,
                          name: product.name,
                        ),
                      );
                    });
              }
            },
          ),
        ),
        Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(2.w, 1.2.h, 2.5.w, 1.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Latest Arrivals",
                    style: appstyle(22, Colors.black, FontWeight.bold),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductByCat(
                            tabIndex: tabIndex,
                          ),
                        ),
                      );
                    },
                    child: Row(
                      children: [
                        Text(
                          "Show All",
                          style: appstyle(16, Colors.black, FontWeight.w300),
                        ),
                        const Icon(
                          Ionicons.caret_forward,
                          size: 20,
                        )
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
        SizedBox(
          height: 12.5.h,
          child: FutureBuilder<List<Products>>(
            future: _male,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator.adaptive(),
                );
              } else if (snapshot.hasError) {
                return Text("Error ${snapshot.error}");
              } else {
                final male = snapshot.data;
                return ListView.builder(
                  itemCount: male!.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    final product = snapshot.data![index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: NewProducts(
                          onTap: () {
                            productNotifier.productSizes = product.sizes!;
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProductPage(
                                  products: product,
                                ),
                              ),
                            );
                          },
                          imageUrl: product.imageUrl[0]),
                    );
                  },
                );
              }
            },
          ),
        )
      ],
    );
  }
}
