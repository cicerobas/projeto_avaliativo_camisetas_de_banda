import 'dart:convert';

class PurchaseModel {
  final String productName;
  final String size;
  final int quantity;
  final int installments;
  final double totalValue;
  final String customerName;
  final String customerAddress;

  PurchaseModel({
    required this.productName,
    required this.size,
    required this.quantity,
    required this.installments,
    required this.totalValue,
    required this.customerName,
    required this.customerAddress,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'productName': productName,
      'size': size,
      'quantity': quantity,
      'installments': installments,
      'totalValue': totalValue,
      'customerName': customerName,
      'customerAddress': customerAddress,
    };
  }

  String toJson() => const JsonEncoder.withIndent('  ').convert(toMap());
}
