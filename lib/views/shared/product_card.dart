import 'export.dart';
import 'export_packages.dart';

class ProductCard extends StatefulWidget {
  const ProductCard(
      {super.key,
      required this.price,
      required this.category,
      required this.id,
      required this.name,
      required this.image});

  final String price;
  final String category;
  final String id;
  final String name;
  final String image;

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  @override
  Widget build(BuildContext context) {
    var favoritesNotifier =
        Provider.of<FavoritesNotifier>(context, listen: true);
    favoritesNotifier.getFavorites();
    return Padding(
      padding: EdgeInsets.fromLTRB(2.w, 0, 4.w, 0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: 60.w,
          decoration: const BoxDecoration(boxShadow: [
            BoxShadow(
              color: Colors.white,
              spreadRadius: 1,
              blurRadius: 0.6,
              offset: Offset(1, 1),
            ),
          ]),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Stack(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.23,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: CachedNetworkImageProvider(widget.image),
                      ),
                    ),
                  ),
                  Positioned(
                    right: 2.w,
                    top: 2.w,
                    child: Consumer<LoginNotifier>(
                      builder: (context, authNotifier, _) {
                        return GestureDetector(
                          onTap: () {
                            if (authNotifier.loggeIn == true) {
                              if (favoritesNotifier.ids.contains(widget.id)) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const Favorites()));
                              } else {
                                favoritesNotifier.createFav({
                                  "id": widget.id,
                                  "name": widget.name,
                                  "category": widget.category,
                                  "price": widget.price,
                                  "imageUrl": widget.image,
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
                          child: favoritesNotifier.ids.contains(widget.id)
                              ? const Icon(CommunityMaterialIcons.heart)
                              : const Icon(
                                  CommunityMaterialIcons.heart_outline),
                        );
                      },
                    ),
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 2.5.w, top: 2.5.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.name,
                      style: appstyleWithHt(
                          18.sp, Colors.black, FontWeight.bold, 1.1),
                      overflow: TextOverflow.ellipsis, // Add this line
                      maxLines: 2, // Add this line
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 0.8.w),
                      child: Text(
                        widget.category,
                        style: appstyleWithHt(
                            10.sp, Colors.grey, FontWeight.bold, 1.1),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 2.w, right: 2.w),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.price,
                        style: appstyle(17.sp, Colors.black, FontWeight.w500),
                      ),
                      Row(
                        children: [
                          Text(
                            "Colors",
                            style:
                                appstyle(14.sp, Colors.grey, FontWeight.w500),
                          ),
                          SizedBox(
                            width: 1.8.w,
                          ),
                          Container(
                            width:
                                20.0, // Adjust the width and height to control the size of the circle
                            height: 20.0,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      )
                    ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
