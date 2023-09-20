extension Removal on List<String> {
  List<String> underscoreSlash(List<String> data) {
    List<String> country = [];
    for (String x in data) {
      x = x.replaceAll('_', ' ').substring(5);
      country.add(x);
    }
    return country;
  }
}
