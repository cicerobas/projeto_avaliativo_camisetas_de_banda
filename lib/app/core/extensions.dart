import 'package:flutter/material.dart';

extension FormatCurrency on double {
  String get toStringBRL {
    return 'R\$ ${toStringAsFixed(2).replaceAll('.', ',')}';
  }
}

extension ContextThemeColors on BuildContext {
  ColorScheme get colors => Theme.of(this).colorScheme;
}
