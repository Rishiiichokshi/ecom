import 'package:shop_online/views/shared/export.dart';
import 'package:shop_online/views/shared/export_packages.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late final TabController _tabController =
      TabController(length: 3, vsync: this);

  @override
  Widget build(BuildContext context) {
    var productnotifier = Provider.of<ProductNotifier>(context);
    productnotifier.getMale();
    productnotifier.getFemale();
    productnotifier.getVintageAndRetroStyle();

    var favoritesNotfier = Provider.of<FavoritesNotifier>(context);
    favoritesNotfier.getFavorites();

    final authNotifier = Provider.of<LoginNotifier>(context, listen: false);
    authNotifier.getPrefs();
    return Scaffold(
      backgroundColor: const Color(0xFFE2E2E2),
      body: SizedBox(
        height: 100.h,
        child: Stack(
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(4.w, 1.h, 0, 0),
              height: 37.h,
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/Rectangle 1.png"),
                    fit: BoxFit.cover),
              ),
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.only(left: 2.w, bottom: 5.h),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Timeless Elegance",
                        style: appstyleWithHt(
                            35, Colors.white, FontWeight.bold, 1.7.sp),
                      ),
                      Text(
                        "Apparel",
                        style: appstyleWithHt(
                            35, Colors.white, FontWeight.bold, 0.7.sp),
                      ),
                      TabBar(
                        tabAlignment: TabAlignment.start,
                        padding: EdgeInsets.only(top: 3.h),
                        indicatorSize: TabBarIndicatorSize.label,
                        indicatorColor: Colors.transparent,
                        dividerColor: Colors.transparent,
                        controller: _tabController,
                        isScrollable: true,
                        labelColor: Colors.white,
                        labelStyle:
                            appstyle(13.sp, Colors.white, FontWeight.w600),
                        unselectedLabelColor: Colors.grey.withOpacity(0.4),
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
                    ]),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 26.h),
              child: Container(
                padding: EdgeInsets.only(left: 2.w),
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    HomeWidget(
                      male: productnotifier.male,
                      tabIndex: 0,
                    ),
                    HomeWidget(
                      male: productnotifier.female,
                      tabIndex: 1,
                    ),
                    HomeWidget(
                      male: productnotifier.vintageAndRetroStyle,
                      tabIndex: 2,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
