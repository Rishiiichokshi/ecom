import 'package:shop_online/views/shared/export_packages.dart';
import 'package:shop_online/views/shared/export.dart';

class NonUser extends StatelessWidget {
  const NonUser({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              height: 750,
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
                            ReusableText(
                              text: "Hello, Please Login into Your Account",
                              style:
                                  appstyle(12, Colors.grey.shade700, FontWeight.normal),
                            ),
                          ],
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LoginPage(),
                              ),
                            );
                          },
                          child: Container(
                            margin: const EdgeInsets.only(top: 6),
                            width: 60,
                            height: 30,
                            decoration: const BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.all(
                                Radius.circular(20),
                              ),
                            ),
                            child: Center(
                                child: ReusableText(
                              text: 'Login',
                              style:
                                  appstyle(12, Colors.white, FontWeight.normal),
                            )),
                          ),
                        ),
                      ],
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
