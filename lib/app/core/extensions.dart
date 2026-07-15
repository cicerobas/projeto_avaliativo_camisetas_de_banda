extension FormatCurrency on double {
  String get toStringBRL {
    return 'R\$ ${toStringAsFixed(2).replaceAll('.', ',')}';
  }
}
