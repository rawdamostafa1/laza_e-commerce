import 'package:cloud_firestore/cloud_firestore.dart';
import '../product/product_model.dart';

class CartService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addToCart(String userId, Product product) async {
    await _firestore
        .collection('carts')
        .doc(userId)
        .collection('items')
        .doc(product.id.toString())
        .set({
      'title': product.title,
      'price': product.price,
      'image': product.image,
      'quantity': 1,
    });
  }

  Future<void> removeFromCart(String userId, String productId) async {
    await _firestore
        .collection('carts')
        .doc(userId)
        .collection('items')
        .doc(productId)
        .delete();
  }

  Stream<QuerySnapshot> getCartItems(String userId) {
    return _firestore
        .collection('carts')
        .doc(userId)
        .collection('items')
        .snapshots();
  }

  Future<void> clearCart(String userId) async {
    final items = await _firestore
        .collection('carts')
        .doc(userId)
        .collection('items')
        .get();
    for (var item in items.docs) {
      await item.reference.delete();
    }
  }
}
