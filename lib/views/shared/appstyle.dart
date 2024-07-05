import 'export_packages.dart';

TextStyle appstyle(double size, Color color, FontWeight fw) {
  return GoogleFonts.poppins(fontSize: size, color: color, fontWeight: fw);
}

TextStyle appstyleWithHt(double size, Color color, FontWeight fw, double ht) {
  return GoogleFonts.poppins(
      fontSize: size, color: color, fontWeight: fw, height: ht);
}
