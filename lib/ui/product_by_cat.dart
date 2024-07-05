import 'package:shop_online/views/shared/export.dart';
import 'package:shop_online/views/shared/export_packages.dart';

class ProductByCat extends StatefulWidget {
  const ProductByCat({super.key, required this.tabIndex});

  final int tabIndex;

  @override
  State<ProductByCat> createState() => _ProductByCatState();
}

class _ProductByCatState extends State<ProductByCat>
    with TickerProviderStateMixin {
  late final TabController _tabController =
      TabController(length: 3, vsync: this);

  @override
  void initState() {
    _tabController.animateTo(widget.tabIndex, curve: Curves.easeIn);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  List<String> brand = [
    "assets/images/adidas.png",
    "assets/images/gucci.png",
    "assets/images/jordan.png",
    "assets/images/nike.png",
  ];

  @override
  Widget build(BuildContext context) {
    var productNotifier = Provider.of<ProductNotifier>(context);
    productNotifier.getMale();
    productNotifier.getFemale();
    productNotifier.getVintageAndRetroStyle();

    return Scaffold(
      backgroundColor: const Color(0xFFE2E2E2),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(3.w, 2.h, 0, 0),
              height: MediaQuery.of(context).size.height * 0.4,
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/Rectangle 1.png"),
                    fit: BoxFit.fill),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(1.w, 1.h, 5.w, 3.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Icon(
                            Ionicons.close,
                            color: Colors.white,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            filter(context);
                          },
                          child: const Icon(
                            FontAwesomeIcons.sliders,
                            color: Colors.white,
                            size: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                  TabBar(
                    tabAlignment: TabAlignment.start,
                    padding: EdgeInsets.zero,
                    indicatorSize: TabBarIndicatorSize.label,
                    indicatorColor: Colors.transparent,
                    dividerColor: Colors.transparent,
                    controller: _tabController,
                    isScrollable: true,
                    labelColor: Colors.white,
                    labelStyle: appstyle(24, Colors.white, FontWeight.bold),
                    unselectedLabelColor: Colors.grey.withOpacity(0.3),
                    tabs: const [
                      Tab(
                        text: "Men's Fashion",
                      ),
                      Tab(
                        text: "Women's Fashion",
                      ),
                      Tab(
                        text: "Vintage and Retro Styles",
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 16.h, left: 4.w, right: 3.w),
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(16)),
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    LatestProducts(male: productNotifier.male),
                    LatestProducts(male: productNotifier.female),
                    LatestProducts(male: productNotifier.vintageAndRetroStyle),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<dynamic> filter(BuildContext context) {
    double value = 100;
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.white70,
      builder: (context) => Container(
        height: 82.0.h, // 82% of the screen height
        width: 100.0.w, // 100% of the screen width
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25.sp), // 25.scaledPoints
            topRight: Radius.circular(25.sp),
          ),
        ),
        child: Column(
          children: [
            SizedBox(height: 10.sp), // 10.scaledPoints
            Container(
              height: 5.sp, // 5.scaledPoints
              width: 40.sp, // 40.scaledPoints
              decoration: BoxDecoration(
                color: Colors.black38,
                borderRadius: BorderRadius.all(
                  Radius.circular(10.sp), // 10.scaledPoints
                ),
              ),
            ),
            SizedBox(
              height: 75.h, // 70% of the screen height
              child: Column(
                children: [
                  const CustomSpacer(),
                  Text(
                    "Filter",
                    style: appstyle(24.sp, Colors.black,
                        FontWeight.bold), // 40.scaledPoints
                  ),
                  const CustomSpacer(),
                  Text(
                    "Gender",
                    style: appstyle(13.sp, Colors.black,
                        FontWeight.bold), // 20.scaledPoints
                  ),
                  SizedBox(height: 17.sp),
                  const Row(
                    children: [
                      CategoryBtn(
                        buttonclr: Colors.black,
                        label: "Men",
                      ),
                      CategoryBtn(
                        buttonclr: Colors.black,
                        label: "Women",
                      ),
                      CategoryBtn(
                        buttonclr: Colors.black,
                        label: "Unisex",
                      ),
                    ],
                  ),
                  const CustomSpacer(),
                  Text(
                    "Category",
                    style: appstyle(13.sp, Colors.black,
                        FontWeight.bold), // 20.scaledPoints
                  ),
                  SizedBox(height: 17.sp),
                  const Row(
                    children: [
                      CategoryBtn(
                        buttonclr: Colors.black,
                        label: "Upper",
                      ),
                      CategoryBtn(
                        buttonclr: Colors.black,
                        label: "Lower",
                      ),
                      CategoryBtn(
                        buttonclr: Colors.black,
                        label: "Footwear",
                      ),
                    ],
                  ),
                  const CustomSpacer(),
                  Text(
                    "Price",
                    style: appstyle(13.sp, Colors.black, FontWeight.bold),
                  ),
                  const CustomSpacer(),
                  Slider(
                    value: value,
                    activeColor: Colors.black,
                    inactiveColor: Colors.grey,
                    thumbColor: Colors.black,
                    max: 500,
                    divisions: 50,
                    label: value.toString(),
                    secondaryTrackValue: 200,
                    onChanged: (double value) {},
                  ),
                  const CustomSpacer(),
                  Text(
                    "Brand",
                    style: appstyle(13.sp, Colors.black, FontWeight.bold),
                  ),
                  SizedBox(height: 17.sp),
                  Container(
                    padding: const EdgeInsets.all(8),
                    height: 80,
                    child: ListView.builder(
                      itemCount: brand.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8),
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(12))),
                            child: Image.asset(
                              brand[index],
                              height: 60,
                              width: 80,
                              color: Colors.black,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
