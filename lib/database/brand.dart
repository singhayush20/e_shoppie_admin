import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';
import 'dart:convert';

class BrandService {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String brands = 'brands';
  void createBrand(String name) {
    var uuid = Uuid();
    String brandId = uuid.v1();
    _firestore.collection(brands).doc('$brandId').set({'brandName': name});
  }

  Future<List<DocumentSnapshot>> getBrands() {
    return _firestore.collection(brands).get().then((value) {
      return value.docs;
    });
  }

  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>> getSuggestion(
          String suggestion) =>
      _firestore
          .collection(brands)
          .where('brandName', /*isEqualTo*/ arrayContains: suggestion)
          .get()
          .then((snap) {
        return snap.docs;
      });
}
