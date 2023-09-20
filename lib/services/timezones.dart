import 'package:timezone/timezone.dart' as tz;

class TimeZones {
  List<String> getTimeZones() {
    try {
      // Uri uri = Uri.parse("http://worldtimeapi.org/api/timezone/asia/");
      // Response res = await get(uri);
      // List<dynamic> data = jsonDecode(res.body);
      List<String> data = tz.timeZoneDatabase.locations.keys.toList();
      data = data.where((element) => element.contains('Asia')).toList();

      /// Fetching Countries Name
      //debugPrint("API CALL : $data");
      return data;
    } catch (e) {
      throw Exception('Unable to Fetch $e');
    }
  }
}
