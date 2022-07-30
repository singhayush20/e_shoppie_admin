import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class CategoryService {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String categories = 'categories';
  void createCategory(String name) {
    var uuid = Uuid();
    String categoryId = uuid.v1();
    _firestore
        .collection(categories)
        .doc('$categoryId')
        .set({'categoryName': name});
  }

  Future<List<DocumentSnapshot>> getCategories() {
    return _firestore.collection(categories).get().then((value) {
      return value.docs;
    });
  }

  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>> getSuggestion(
          String suggestion) =>
      _firestore
          .collection(categories)
          .where('categoryName', /*arrayContains: */ isEqualTo: suggestion)
          .get()
          .then((snap) {
        return snap.docs;
      });
}
