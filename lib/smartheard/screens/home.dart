import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_learning/l10n/app_localizations.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          try {
            final files = await FilePicker.pickFiles();
            // Cancel returns an empty list, not null: .first would throw
            if (files.isEmpty) {
              debugPrint('File picking canceled');
              return;
            }
            debugPrint('Selected file: ${files.first.name}');
          } catch (error) {
            debugPrint('Error picking file: $error');
          }
        },
        child: const Icon(Icons.add),
      ),
      body: Container(
        color: Colors.orangeAccent,
        child: Column(
          children: [
            Row(
              children: [
                textWidget('Mumbai', 40),
                textWidget('Mumbai', 30),
              ],
            ),
            Row(
              children: [
                textWidget('Mumbai', 20),
                textWidget('Mumbaihkhk kkkjkjkgjfhd', 20),
              ],
            ),
            Image.asset('assets/1.jpg', height: 250),
            Image.asset('assets/2.jpg', height: 250),
            buttonWidget(context, AppLocalizations.of(context).button, 20),
          ],
        ),
      ),
    );
  }

  Widget textWidget(String text, double size) {
    return Expanded(
      child: Text(
        text,
        style: TextStyle(
          decoration: TextDecoration.none,
          color: Colors.yellow,
          fontFamily: 'Roboto',
          fontStyle: FontStyle.italic,
          fontSize: size,
        ),
      ),
    );
  }

  Widget buttonWidget(BuildContext context, String text, double size) {
    return ElevatedButton(
      onPressed: () {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              final l10n = AppLocalizations.of(context);
              return AlertDialog(
                title: Text(l10n.goodFlight),
                content: Text(l10n.goodFlight),
                actions: [
                  TextButton(
                    onPressed: () {
                      // Bezárja a dialógust, majd visszalép a Smartheard menübe.
                      Navigator.of(context)
                        ..pop()
                        ..pop();
                    },
                    child:
                        Text(MaterialLocalizations.of(context).okButtonLabel),
                  ),
                ],
              );
            });
      },
      child: Text(
        text,
        style: TextStyle(
          decoration: TextDecoration.none,
          color: Colors.deepOrange,
          fontFamily: 'Roboto',
          fontStyle: FontStyle.italic,
          fontSize: size,
        ),
      ),
    );
  }
}
