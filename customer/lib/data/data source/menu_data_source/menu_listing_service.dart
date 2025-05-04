import 'package:cloud_firestore/cloud_firestore.dart';

class MenuListingService {
  final fire = FirebaseFirestore.instance;

  Future<List<Map<String, dynamic>>> categoryList() async {
    try {
      final QuerySnapshot response = await fire
          .collection("category")
          .get()
          .timeout(Duration(seconds: 10));
      if (response.docs.isNotEmpty) {
        return response.docs.map((doc) {
          // Create a new map with all the document data
          Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

          data['id'] = doc.id;

          print('65362784:$data');

          return data;
        }).toList();
      }

      return [];
    } catch (e) {
      print('categorylist error:$e');
      return [];
    }
  }

  Future<List<Map<String, dynamic>>> productsList(String categoryId) async {
    try {
      final QuerySnapshot response = await fire
          .collection('products')
          .where("category_id", isEqualTo: categoryId)
          .where("is_deleted", isEqualTo: false)
          .where("is_active", isEqualTo: true)
          .get()
          .timeout(Duration(seconds: 10));

      if (response.docs.isNotEmpty) {
        return response.docs
            .map((doc) => doc.data() as Map<String, dynamic>)
            .toList();
      }
      return [];
    } catch (e) {
      print('Products listing error:$e');
      return [];
    }
  }
}
