import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:timezones/extension/remove_from_list.dart';
import 'package:timezones/extension/remove_from_string.dart';
import 'package:timezones/services/shared_data.dart';
import 'package:timezones/services/timezones.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String value = '';
  String? state;
  int flag = 1;
  List<String> timeZones = [];

  void showAlert(String value) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (_) =>
            //debugPrint('123567890');
            CupertinoAlertDialog(
              title: const Text('Change Country'),
              content: const Text('Do you want to Change Country'),
              actions: [
                CupertinoDialogAction(
                  onPressed: () async {
                    setState(() {
                      this.value = value;
                    });
                    await TimezoneSharedPreferences().setTimezone(value);
                    debugPrint('1234567890   $value');
                    flag = 0;
                    Navigator.pop(context);
                  },
                  child: const Text('Update'),
                  isDefaultAction: true,
                ),
                CupertinoDialogAction(
                  onPressed: () async {
                    /*if (state != value) {
                      // setState(() {
                      //   this.value = value;
                      // });
                    }*/
                    flag = 0;
                    await TimezoneSharedPreferences().setFlag(flag);
                    Navigator.pop(context);
                  },
                  child: const Text('Skip'),
                  isDestructiveAction: true,
                )
              ],
            ));
  }

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
        value: item,
        child: Text(item),
      );

  getData() async {
    timeZones = TimeZones().getTimeZones();
    timeZones = timeZones.underscoreSlash(timeZones);
    value = TimezoneSharedPreferences().getTimezone() ?? timeZones.first;
    flag = TimezoneSharedPreferences().getFlag() ?? 1;
    state = await FlutterNativeTimezone.getLocalTimezone();
    state = state!.underscoreSlash(state!);

    debugPrint("qwerty state      :$state");
    debugPrint("qwerty state      :$flag");
    if (value != state && flag == 1) {
      flag = 0;
      await TimezoneSharedPreferences().setFlag(flag);
      debugPrint('State : $state');
      debugPrint('Value : $value');
      showAlert(state!);
    }
  }

  @override
  void initState() {
    super.initState();
    getData();
    debugPrint("qwerty      :$value");
    debugPrint("qwerty state      :$state");
  }

  @override
  Widget build(BuildContext context) {
    //debugPrint("HomePage data : ${timeZones.toString()}");

    return Scaffold(
      appBar: AppBar(
        title: const Text('Timezones in Asia'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
                color: Colors.orangeAccent,
                constraints: const BoxConstraints(
                  minHeight: 200,
                  minWidth: 400,
                ),
                child: Center(
                    child: Text(
                        // /*value ??*/ Localizations.localeOf(context).toString(),
                        //DateTime.now().timeZoneName,
                        value,
                        style: const TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                        )))),
            const Divider(
              thickness: 8,
              height: 8,
              color: Colors.orange,
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              //child: SecondBlock(data: timeZones!),
              padding: const EdgeInsets.all(8.0),
              height: 60,
              width: 150,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 2),
                borderRadius: BorderRadius.circular(20),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  isExpanded: true,
                  icon: const Icon(
                    Icons.arrow_drop_down,
                    color: Colors.black,
                    size: 30,
                  ),
                  value: value,
                  onChanged: (value) {
                    //state = timeZones!.value;
                    showAlert(value!);
                  },
                  items: timeZones.map(buildMenuItem).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
