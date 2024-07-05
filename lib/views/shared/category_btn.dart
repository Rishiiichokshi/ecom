import 'export.dart';
import 'export_packages.dart';


class CategoryBtn extends StatelessWidget {
  const CategoryBtn(
      {super.key, this.onPress, required this.buttonclr, required this.label});
  final void Function()? onPress;
  final Color buttonclr;
  final String label;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPress,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.244,
        decoration: BoxDecoration(
          border:
              Border.all(width: 1, color: buttonclr, style: BorderStyle.solid),
          borderRadius: const BorderRadius.all(
            Radius.circular(9),
          ),
        ),
        child: Center(
          child: FittedBox(
            fit:
                BoxFit.scaleDown, // This ensures the text is scaled down to fit
            alignment: Alignment.center,
            child: Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: 5), // Adjust the padding as needed
              child: Text(
                label,
                style: appstyle(17, buttonclr, FontWeight.w600),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
