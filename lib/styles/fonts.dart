part of styles;

class AppFonts {
  static TextStyle getAppFont({
    required FontWeight fontWeight,
    required double fontSize,
    required Color color,
    required double letterSpacing,
    double height = 1.2,
    TextDecoration decoration = TextDecoration.none,
  }) {
    return GoogleFonts.brawler(
        textStyle: TextStyle(
      letterSpacing: letterSpacing,
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      height: height,
    ).copyWith(fontWeight: FontWeight.w600));
  }

  static final primaryHeader = getAppFont(
    fontSize: 35,
    fontWeight: FontWeight.normal,
    color: Colors.black,
    letterSpacing: 0,
  );
  static final noteTitle = getAppFont(
    fontSize: 20,
    fontWeight: FontWeight.normal,
    color: Colors.black,
    letterSpacing: 0,
  );
  static final noteSubTitle = getAppFont(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: Colors.black,
    letterSpacing: 0,
  );
  static final noteTime = getAppFont(
    fontSize: 12,
    fontWeight: FontWeight.normal,
    color: Colors.black,
    letterSpacing: 0,
  );
}
