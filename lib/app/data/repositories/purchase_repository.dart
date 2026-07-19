import 'package:projeto_avaliativo_camisetas_de_banda/app/data/models/purchase_model.dart';
import 'package:projeto_avaliativo_camisetas_de_banda/app/data/services/purchase_service.dart';

class PurchaseRepository {
  final PurchaseService _service;

  PurchaseRepository(this._service);

  void processPurchase(PurchaseModel purchaseData) {
    _service.processPurchase(purchaseData.toJson());
  }
}
