import 'package:shop_online/services/authhelper.dart';
import 'package:shop_online/ui/orders/orders.dart';
import 'package:shop_online/views/shared/export.dart';
import 'package:shop_online/views/shared/export_packages.dart';
import 'package:shop_online/views/shared/tiles_widget.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    var authNotifier = Provider.of<LoginNotifier>(context);
    return authNotifier.loggeIn == false
        ? const NonUser()
        : Scaffold(
            appBar: AppBar(
              backgroundColor: const Color(0xFFE2E2E2),
              elevation: 0,
              leading: const Icon(
                CommunityMaterialIcons.qrcode_scan,
                size: 22,
                color: Colors.black,
              ),
              actions: [
                GestureDetector(
                  onTap: () {},
                  child: Padding(
                    padding: const EdgeInsets.only(right: 16),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/flag.png',
                          width: 30,
                          height: 30,
                        ),
                        const SizedBox(width: 5),
                        Container(
                          width: 1,
                          height: 20,
                          color: Colors.grey.shade700,
                        ),
                        ReusableText(
                          text: ' IND',
                          style: appstyle(17, Colors.black, FontWeight.normal),
                        ),
                        const SizedBox(width: 15),
                        const Padding(
                          padding: EdgeInsets.only(bottom: 4),
                          child: Icon(
                            LineIcons.cog,
                            size: 22,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: 70,
                    decoration: const BoxDecoration(
                      color: Color(0xFFE2E2E2),
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(12, 10, 16, 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const SizedBox(
                                    height: 40,
                                    width: 40,
                                    child: CircleAvatar(
                                      backgroundImage: AssetImage(
                                        'assets/images/profile_photo.png',
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  FutureBuilder(
                                    future: AuthHelper().getProfile(),
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return const Center(
                                          child: CircularProgressIndicator
                                              .adaptive(),
                                        );
                                      } else if (snapshot.hasError) {
                                        return Center(
                                          child: ReusableText(
                                              text: "Error get you data",
                                              style: appstyle(18, Colors.black,
                                                  FontWeight.w600)),
                                        );
                                      } else {
                                        final userData = snapshot.data;
                                        return SizedBox(
                                          height: 35,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              ReusableText(
                                                text: userData?.username ?? "",
                                                style: appstyle(
                                                    10,
                                                    Colors.grey.shade700,
                                                    FontWeight.normal),
                                              ),
                                              ReusableText(
                                                text: userData?.email ?? "",
                                                style: appstyle(
                                                    10,
                                                    Colors.grey.shade700,
                                                    FontWeight.normal),
                                              ),
                                            ],
                                          ),
                                        );
                                      }
                                    },
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8),
                                child: GestureDetector(
                                  onTap: () {},
                                  child: const Icon(Ionicons.create_outline),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: 170,
                        color: Colors.grey.shade200,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TilesWidget(
                                OnTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const ProcessOrders(),
                                    ),
                                  );
                                },
                                title: "My Orders",
                                leading:
                                    CommunityMaterialIcons.truck_fast_outline),
                            TilesWidget(
                                OnTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const Favorites(),
                                    ),
                                  );
                                },
                                title: "My Favorites",
                                leading: CommunityMaterialIcons.heart_outline),
                            TilesWidget(
                                OnTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const Cartpage(),
                                    ),
                                  );
                                },
                                title: "Cart",
                                leading: CommunityMaterialIcons.cart_outline),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: 120,
                        color: Colors.grey.shade200,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TilesWidget(
                                OnTap: () {},
                                title: "Coupons",
                                leading: CommunityMaterialIcons.tag_outline),
                            TilesWidget(
                                OnTap: () {},
                                title: "My Store",
                                leading:
                                    CommunityMaterialIcons.shopping_outline),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: 170,
                        color: Colors.grey.shade200,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TilesWidget(
                                OnTap: () {},
                                title: "Shipping address",
                                leading: LineIcons.locationArrow),
                            TilesWidget(
                                OnTap: () {},
                                title: "Settings",
                                leading: LineIcons.cog),
                            TilesWidget(
                                OnTap: () {
                                  authNotifier.logout();
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const LoginPage(),
                                    ),
                                  );
                                },
                                title: "Logout",
                                leading: LineIcons.alternateSignOut),
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
  }
}
