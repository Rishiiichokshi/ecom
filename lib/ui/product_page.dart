import 'package:shop_online/models/cart/add_to_cart.dart';
import 'package:shop_online/services/cartHelper.dart';
import 'package:shop_online/views/shared/export.dart';
import 'package:shop_online/views/shared/export_packages.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key, required this.products});

  final Products products;

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final PageController pageController = PageController();
  late ProductNotifier productNotifier;

  @override
  void initState() {
    super.initState();
    productNotifier = Provider.of<ProductNotifier>(context, listen: false);
    // productNotifier.getProducts(widget.category, widget.id);
  }

  @override
  Widget build(BuildContext context) {
    var favouritesNotifier = Provider.of<FavoritesNotifier>(context);
    var authNotifier = Provider.of<LoginNotifier>(context);
    favouritesNotifier.getFavorites();
    return Scaffold(
      body: Consumer<ProductNotifier>(
        builder: (context, productNotifier, child) {
          return CustomScrollView(
            slivers: [
              SliverAppBar(
                automaticallyImplyLeading: false,
                leadingWidth: 0,
                title: Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                          // productNotifier.productSizes.clear();
                        },
                        child: const Icon(Ionicons.close),
                      ),
                      Consumer<FavoritesNotifier>(
                        builder: (context, favoritesNotifier, child) {
                          return GestureDetector(
                            onTap: () {
                              if (authNotifier.loggeIn == true) {
                                if (favoritesNotifier.ids
                                    .contains(widget.products.id)) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const Favorites(),
                                    ),
                                  );
                                } else {
                                  favouritesNotifier.createFav({
                                    "id": widget.products.id,
                                    "name": widget.products.name,
                                    "category": widget.products.category,
                                    "price": widget.products.price,
                                    "imageUrl": widget.products.imageUrl[0],
                                  });
                                }
                              } else {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const LoginPage(),
                                  ),
                                );
                              }
                              setState(() {});
                            },
                            child: favoritesNotifier.ids
                                    .contains(widget.products.id)
                                ? const Icon(Ionicons.heart)
                                : const Icon(Ionicons.heart_outline),
                          );
                        },
                      )
                    ],
                  ),
                ),
                pinned: true,
                snap: false,
                floating: true,
                backgroundColor: Colors.transparent,
                expandedHeight: MediaQuery.of(context).size.height,
                flexibleSpace: FlexibleSpaceBar(
                  background: Stack(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.5,
                        width: MediaQuery.of(context).size.width,
                        child: PageView.builder(
                          itemCount: widget.products.imageUrl.length,
                          scrollDirection: Axis.horizontal,
                          controller: pageController,
                          onPageChanged: (page) {
                            productNotifier.activePage = page;
                            setState(() {});
                          },
                          itemBuilder: (context, int index) {
                            return Stack(
                              children: [
                                Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.39,
                                  width: MediaQuery.of(context).size.width,
                                  color: Colors.grey.shade300,
                                  child: CachedNetworkImage(
                                    imageUrl: widget.products.imageUrl[index],
                                    fit: BoxFit.contain,
                                  ),
                                ),
                                Positioned(
                                  bottom: 0,
                                  right: 0,
                                  left: 0,
                                  height:
                                      MediaQuery.of(context).size.height * 0.3,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: List<Widget>.generate(
                                      widget.products.imageUrl.length,
                                      (index) => Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 4),
                                        child: CircleAvatar(
                                          radius: 5,
                                          backgroundColor:
                                              productNotifier.activePage !=
                                                      index
                                                  ? Colors.grey
                                                  : Colors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                      Positioned(
                        bottom: -10,
                        child: ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30),
                          ),
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.645,
                            width: MediaQuery.of(context).size.width,
                            color: Colors.white,
                            child: SingleChildScrollView(
                              child: Padding(
                                padding: const EdgeInsets.all(12),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      widget.products.name,
                                      style: appstyle(
                                          26, Colors.black, FontWeight.bold),
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          widget.products.category,
                                          style: appstyle(
                                              17, Colors.grey, FontWeight.w500),
                                        ),
                                        const SizedBox(
                                          width: 20,
                                        ),
                                        RatingBar.builder(
                                          initialRating: 4,
                                          minRating: 1,
                                          direction: Axis.horizontal,
                                          allowHalfRating: true,
                                          itemCount: 5,
                                          itemSize: 22,
                                          itemPadding:
                                              const EdgeInsets.symmetric(
                                                  horizontal: 1),
                                          itemBuilder: (context, _) =>
                                              const Icon(Icons.star),
                                          onRatingUpdate: (value) {},
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "\$${widget.products.price}",
                                          style: appstyle(24, Colors.black,
                                              FontWeight.w600),
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              "Colors",
                                              style: appstyle(17, Colors.black,
                                                  FontWeight.w600),
                                            ),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            const CircleAvatar(
                                              radius: 7,
                                              backgroundColor: Colors.black,
                                            ),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            const CircleAvatar(
                                              radius: 7,
                                              backgroundColor:
                                                  Colors.amberAccent,
                                            ),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Column(
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              "Select Sizes",
                                              style: appstyle(18, Colors.black,
                                                  FontWeight.w600),
                                            ),
                                            const SizedBox(
                                              width: 20,
                                            ),
                                            Text(
                                              "View size Guide",
                                              style: appstyle(14, Colors.grey,
                                                  FontWeight.w600),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        SizedBox(
                                          height: 40,
                                          child: ListView.builder(
                                              itemCount: productNotifier
                                                  .productSizes.length,
                                              scrollDirection: Axis.horizontal,
                                              padding: EdgeInsets.zero,
                                              itemBuilder: (context, index) {
                                                final sizes = productNotifier
                                                    .productSizes[index];

                                                return Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                    horizontal: 8.0,
                                                  ),
                                                  child: ChoiceChip(
                                                    shape: RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(60),
                                                        side: const BorderSide(
                                                            color: Colors.black,
                                                            width: 1,
                                                            style: BorderStyle
                                                                .solid)),
                                                    disabledColor: Colors.white,
                                                    label: Text(
                                                      sizes['size'],
                                                      style: appstyle(
                                                          14,
                                                          sizes['isSelected']
                                                              ? Colors.white
                                                              : Colors.black,
                                                          FontWeight.w500),
                                                    ),
                                                    selectedColor: Colors.black,
                                                    padding: const EdgeInsets
                                                        .symmetric(vertical: 7),
                                                    selected:
                                                        sizes['isSelected'],
                                                    onSelected: (newState) {
                                                      if (productNotifier.sizes
                                                          .contains(
                                                              sizes['size'])) {
                                                        productNotifier.sizes
                                                            .remove(
                                                                sizes['size']);
                                                      } else {
                                                        productNotifier.sizes
                                                            .add(sizes['size']);
                                                      }

                                                      productNotifier
                                                          .toggleCheck(index);
                                                    },
                                                  ),
                                                );
                                              }),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    const Divider(
                                      indent: 10,
                                      endIndent: 10,
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.8,
                                      child: Text(
                                        widget.products.title,
                                        style: appstyle(
                                            20, Colors.black, FontWeight.w700),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      widget.products.description,
                                      textAlign: TextAlign.justify,
                                      maxLines: 4,
                                      style: appstyle(
                                          12, Colors.grey, FontWeight.w500),
                                    ),
                                    Align(
                                      alignment: Alignment.bottomCenter,
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(top: 12.0),
                                        child: CheckoutButton(
                                          label: "Add to Cart",
                                          onTap: () async {
                                            if (authNotifier.loggeIn == true) {
                                              AddToCart model = AddToCart(
                                                  cartItem: widget.products.id,
                                                  quantity: 1);
                                              CartHelper().addToCart(model);
                                            } else {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      const LoginPage(),
                                                ),
                                              );
                                            }
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
