import 'package:flutter/services.dart';

class CardNumberInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    String newText = newValue.text.replaceAll(' ', '');
    if (newText.length > 16) {
      newText = newText.substring(0, 16); // Limit to 16 digits
    }
    String formattedText = newText.replaceAllMapped(RegExp(r'.{1,4}'), (match) => '${match.group(0)} ');
    return newValue.copyWith(
      text: formattedText.trimRight(),
      selection: TextSelection.collapsed(offset: formattedText.trimRight().length),
    );
  }
}

class ExpiryDateInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    var text = newValue.text;

    if (text.length > 2 && !text.contains('/')) {
      text = text.substring(0, 2) + '/' + text.substring(2);
    }

    return newValue.copyWith(
      text: text,
      selection: TextSelection.collapsed(offset: text.length),
    );
  }
  
  }

