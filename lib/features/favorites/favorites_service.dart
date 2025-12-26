import 'package:cloud_firestore/cloud_firestore.dart';
import '../product/product_model.dart';

class FavoritesService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addToFavorites(String userId, Product product) async {
    await _firestore
        .collection('favorites')
        .doc(userId)
        .collection('items')
        .doc(product.id.toString())
        .set({
      'title': product.title,
      'price': product.price,
      'image': product.image,
    });
  }

  Future<void> removeFromFavorites(String userId, String productId) async {
    await _firestore
        .collection('favorites')
        .doc(userId)
        .collection('items')
        .doc(productId)
        .delete();
  }
  Stream<QuerySnapshot> getFavorites(String userId){
    return _firestore
        .collection('favorites').doc(userId).collection('items').snapshots();
  }
}
