import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_online/controllers/payment_provider.dart';
import 'package:shop_online/ui/mainscreen.dart';
import 'package:antdesign_icons/antdesign_icons.dart';
import 'package:shop_online/views/shared/appstyle.dart';
import 'package:shop_online/views/shared/reusable_text.dart';

class PaymentFailed extends StatelessWidget {
  const PaymentFailed({super.key});

  @override
  Widget build(BuildContext context) {
    var paymentNotifier = Provider.of<PaymentNotifier>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white10,
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: GestureDetector(
          onTap: () {
            paymentNotifier.setPaymentUrl = '';
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => MainScreen()));
          },
          child: const Icon(
            AntIcons.clockCircleOutlined,
            color: Colors.black,
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/No.png",
              color: Colors.red,
            ),
            ReusableText(
                text: "Payment Failed",
                style: appstyle(28, Colors.black, FontWeight.bold))
          ],
        ),
      ),
    );
  }
}
