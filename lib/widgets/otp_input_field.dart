import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OtpInputField extends StatelessWidget {
  final TextEditingController inputController;
  final ValueNotifier<bool> codeComplete;

  const OtpInputField(
      {Key? key, required this.inputController, required this.codeComplete})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: PinCodeTextField(
        backgroundColor: Colors.transparent,
        appContext: context,
        controller: inputController,
        length: 6,
        obscureText: false,
        animationType: AnimationType.fade,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        animationDuration: const Duration(milliseconds: 300),
        textStyle: Theme.of(context).textTheme.headline3,
        enableActiveFill: true,
        keyboardType: TextInputType.number,
        onCompleted: (v) {
          codeComplete.value = true;
        },
        beforeTextPaste: (text) {
          return true;
        },
        onChanged: (value) {
          if (value.isNotEmpty && value.length < 6) {
            codeComplete.value = false;
          }
        },
      ),
    );
  }
}
