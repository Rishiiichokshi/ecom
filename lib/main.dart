import 'package:shop_online/controllers/payment_provider.dart';
import 'package:shop_online/views/shared/export_packages.dart';
import 'package:shop_online/views/shared/export.dart';
 import 'dart:io';



void main() async {
  //i need widgets flutter binding
  WidgetsFlutterBinding.ensureInitialized();

  //now initialize hive and create cart box and favourite box
  await Hive.initFlutter();
  await Hive.openBox('cart_box');
  await Hive.openBox('fav_box');
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => MainScreenNotifier()),
        ChangeNotifierProvider(create: (context) => ProductNotifier()),
        ChangeNotifierProvider(create: (context) => FavoritesNotifier()),
        ChangeNotifierProvider(create: (context) => CartProvider()),
        ChangeNotifierProvider(create: (context) => LoginNotifier()),
        ChangeNotifierProvider(create: (context) => PaymentNotifier()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return SafeArea(
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              scaffoldBackgroundColor: const Color(0xFFE2E2E2),
              useMaterial3: true,
            ),
            home: MainScreen(),
          ),
        );
      },
    );
  }
}
