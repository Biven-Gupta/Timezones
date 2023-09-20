import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SecondBlock extends StatelessWidget {
  final List<String> data;

  const SecondBlock({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ListView.builder(
              itemCount: data.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(data.toList()[index]),
                  onTap: () {
                    showDialog(
                        barrierDismissible: true,
                        context: context,
                        builder: (_) =>
                            //debugPrint('123567890');
                            CupertinoAlertDialog(
                              title: const Text('Change Country'),
                              content:
                                  const Text('Do you want to Change Country'),
                              actions: [
                                CupertinoDialogAction(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text('Update')),
                                CupertinoDialogAction(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text('Skip'))
                              ],
                            ));
                  },
                );
              }),
        ),
      ),
    );
  }
}
