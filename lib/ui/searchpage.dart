import 'package:lottie/lottie.dart';
import 'package:shop_online/views/shared/custom_field.dart';
import 'package:shop_online/views/shared/export.dart';
import 'package:shop_online/views/shared/export_packages.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var productProvider = Provider.of<ProductNotifier>(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 100,
        backgroundColor: Colors.black,
        elevation: 0,
        title: CustomField(
          hintText: 'Search For a Product',
          controller: searchController,
          onEditingComplete: () {
            setState(() {});
          },
          prefixIcon: GestureDetector(
            onTap: () {},
            child: const Icon(
              Ionicons.camera,
              color: Colors.black,
            ),
          ),
          suffixIcon: GestureDetector(
            onTap: () {
              setState(() {});
            },
            child: const Icon(
              Ionicons.search,
              color: Colors.black,
            ),
          ),
        ),
      ),
      body: searchController.text.isEmpty
          ? Center(
              child: Lottie.asset(
                'assets/animation/search_logo.json',
                width: 700.w, // Set the desired width
                height: 700.h,
              ),
            )
          : FutureBuilder<List<Products>>(
              future: Helper().search(searchController.text),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator.adaptive(),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: ReusableText(
                      text: 'Error Retrieving Data',
                      style: appstyle(20, Colors.black, FontWeight.bold),
                    ),
                  );
                } else if (snapshot.data!.isEmpty) {
                  return Center(
                    child: ReusableText(
                      text: 'No Products Found',
                      style: appstyle(20, Colors.black, FontWeight.bold),
                    ),
                  );
                } else {
                  final products = snapshot.data;
                  return ListView.builder(
                    itemCount: products!.length,
                    itemBuilder: (context, index) {
                      final product = products[index];
                      return GestureDetector(
                        onTap: () {
                          productProvider.productSizes = product.sizes!;
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProductPage(
                                products: product,
                              ),
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: ClipRRect(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(12),
                            ),
                            child: Container(
                              height: 100,
                              width: 325,
                              decoration: BoxDecoration(
                                color: Colors.grey.shade100,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.shade500,
                                    offset: const Offset(0, 1),
                                    blurRadius: 0.3,
                                    spreadRadius: 5,
                                  ),
                                ],
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(12),
                                        child: CachedNetworkImage(
                                          imageUrl: product.imageUrl[0],
                                          height: 70,
                                          width: 70,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 12, left: 10),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            ReusableText(
                                              text: product.name,
                                              style: appstyle(
                                                17,
                                                Colors.black,
                                                FontWeight.w600,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            ReusableText(
                                              text: product.category,
                                              style: appstyle(
                                                  14,
                                                  Colors.grey.shade600,
                                                  FontWeight.w600),
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            ReusableText(
                                              text: '\$ ${product.price}',
                                              style: appstyle(
                                                  14,
                                                  Colors.grey.shade600,
                                                  FontWeight.w600),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
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
    );
  }
}
