import 'package:shop_online/views/shared/export_packages.dart';

class TilesWidget extends StatelessWidget {
  final String title;
  final IconData leading;
  // ignore: non_constant_identifier_names
  final Function()? OnTap;

  const TilesWidget({
    Key? key,
    required this.title,
    required this.leading,
    // ignore: non_constant_identifier_names
    this.OnTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: OnTap,
      leading: Icon(leading),
      title: Text(
        title,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
      trailing: title != "Settings"
          ? const Icon(
              Ionicons.chevron_forward_outline,
              size: 16,
            )
          : Image.asset(
              "assets/images/flag.png",
              width: 20,
              height: 20,
            ),
    );
  }
}
