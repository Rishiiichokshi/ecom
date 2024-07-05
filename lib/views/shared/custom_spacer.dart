import 'export_packages.dart';

class CustomSpacer extends StatelessWidget {
  const CustomSpacer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 18.0
          .sp, // Use sizer to set height as a percentage of the screen height
    );
  }
}
