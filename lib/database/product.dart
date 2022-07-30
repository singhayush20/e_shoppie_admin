import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class ProductService {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _prodcutsRef = 'products';
  void uploadProduct(String productName, String brand, String category,
      List sizes, List<String> images, int price, int quantity) {
    var uuid = Uuid();
    String productId = uuid.v1();
    _firestore.collection(_prodcutsRef).doc('$productId').set(
      {
        'name': productName,
        'id': productId,
        'brand': brand,
        'category': category,
        'price': price,
        'quantity': quantity,
        'availableSizes': sizes,
        'productImages': images,
      },
    );
  }
}
