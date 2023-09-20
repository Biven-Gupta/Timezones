extension Removal on String {
  String underscoreSlash(String data) {
    String country = data.replaceAll('_', ' ').substring(5);
    return country;
  }
}
