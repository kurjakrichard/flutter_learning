import 'package:flutter/material.dart';
import 'package:flutter_learning/l10n/app_localizations.dart';
import '../models/currency.dart';

class Home4 extends StatefulWidget {
  const Home4({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _Home4State();
  }
}

class _Home4State extends State<Home4> {
  String _nameCity = '';
  String _nameCountry = '';
  Currency _currencyItemSelected = Currency.forint;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(l10n.statefulExample)),
      body: SingleChildScrollView(
        child: Container(
            margin: const EdgeInsets.all(20.0),
            child: Column(
              children: <Widget>[
                TextField(
                  maxLength: 60,
                  onSubmitted: (String userInput) {
                    setState(() {
                      _nameCity = userInput;
                    });
                  },
                ),
                Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Text(l10n.bestCity(_nameCity)),
                ),
                TextField(
                  maxLength: 60,
                  onSubmitted: (String userInput) {
                    setState(() {
                      _nameCountry = userInput;
                    });
                  },
                ),
                Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Text(l10n.bestCountry(_nameCountry)),
                ),
                DropdownButton<Currency>(
                  items: Currency.values.map((Currency currency) {
                    return DropdownMenuItem<Currency>(
                        value: currency, child: Text(currency.label(l10n)));
                  }).toList(),
                  onChanged: (Currency? newValueSelected) {
                    setState(() {
                      _currencyItemSelected = newValueSelected!;
                    });
                  },
                  value: _currencyItemSelected,
                )
              ],
            )),
      ),
    );
  }
}
