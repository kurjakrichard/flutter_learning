import 'package:flutter/material.dart';
import 'package:flutter_learning/l10n/app_localizations.dart';
import '../models/currency.dart';

class InterestCalculator extends StatefulWidget {
  const InterestCalculator({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _InterestCalculatorState();
  }
}

class _InterestCalculatorState extends State<InterestCalculator> {
  Currency? _currencyItemSelected;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    principalController.addListener(() {
      setState(() {
        _displayResult = principalController.text;
      });
    });
  }

  TextEditingController principalController = TextEditingController();
  TextEditingController roiController = TextEditingController();
  TextEditingController termController = TextEditingController();
  String _displayResult = '';

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.interestCalculator),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          children: <Widget>[
            picture('assets/3.png'),
            inputTextField(
                l10n.investment, l10n.investmentHint, principalController),
            inputTextField(
                l10n.interestRate, l10n.interestRateHint, roiController),
            Row(
              children: [
                Expanded(
                    child: inputTextField(
                        l10n.period, l10n.periodHint, termController)),
                Container(width: 20),
                dropDown(l10n)
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: [
                  button(l10n.calculate, () {
                    if (_formKey.currentState!.validate()) {
                      _displayResult = calculateTotalReturn();
                    }
                  }),
                  Container(width: 20),
                  button(l10n.reset, reset),
                ],
              ),
            ),
            Center(child: Text(_displayResult)),
          ],
        ),
      ),
    );
  }

  Widget button(String buttonText, VoidCallback buttonAction) {
    return Expanded(
        child: ElevatedButton(
      child: Text(buttonText),
      onPressed: () => setState(buttonAction),
    ));
  }

  Widget dropDown(AppLocalizations l10n) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(right: 20.0),
        child: DropdownButton<Currency>(
          items: Currency.values.map((Currency value) {
            return DropdownMenuItem<Currency>(
              value: value,
              child: Text(value.label(l10n)),
            );
          }).toList(),
          onChanged: (Currency? newValueSelected) {
            setState(() {
              _currencyItemSelected = newValueSelected!;
            });
          },
          value: _currencyItemSelected,
        ),
      ),
    );
  }

  Widget picture(String path) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Image.asset(
        path,
        height: 150,
      ),
    );
  }

  Widget inputTextField(
      String labelText, String hintText, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextFormField(
        validator: (value) {
          if (!checkNumbers(value)) {
            return AppLocalizations.of(context).enterNumber;
          }
          return null;
        },
        keyboardType: TextInputType.number,
        controller: controller,
        decoration: InputDecoration(
            errorStyle: const TextStyle(color: Colors.red, fontSize: 15.0),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
            labelText: labelText,
            hintText: hintText),
      ),
    );
  }

  String calculateTotalReturn() {
    double principal = double.parse(principalController.text);
    double roi = double.parse(roiController.text);
    double term = double.parse(termController.text);

    double totalAmountPayable = principal + (principal * roi * term) / 100;

    final l10n = AppLocalizations.of(context);
    return l10n.interestResult(
      term.toString(),
      totalAmountPayable.toString(),
      _currencyItemSelected?.label(l10n) ?? '',
    );
  }

  void reset() {
    principalController.text = '';
    roiController.text = '';
    termController.text = '';
    _displayResult = '';
    _currencyItemSelected = Currency.forint;
  }

  bool checkNumbers(String? value) {
    try {
      // ignore: unused_local_variable
      double checknumber = double.parse(value!);
      return true;
    } on Exception {
      return false;
    }
  }
}
