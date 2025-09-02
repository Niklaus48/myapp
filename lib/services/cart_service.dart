import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:myapp/models/product.dart';

class CartService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User? get _currentUser => _auth.currentUser;

  Future<void> addToCart(Product product) async {
    if (_currentUser == null) return;

    final cartRef = _firestore
        .collection('users')
        .doc(_currentUser!.uid)
        .collection('cart');

    final doc = await cartRef.doc(product.id.toString()).get();

    if (doc.exists) {
      await cartRef.doc(product.id.toString()).update({
        'quantity': FieldValue.increment(1),
      });
    } else {
      await cartRef.doc(product.id.toString()).set({
        ...product.toJson(),
        'quantity': 1,
      });
    }
  }

  Future<void> removeFromCart(Product product) async {
    if (_currentUser == null) return;

    final cartRef = _firestore
        .collection('users')
        .doc(_currentUser!.uid)
        .collection('cart');
    
    await cartRef.doc(product.id.toString()).delete();
  }

  Future<void> updateQuantity(Product product, int quantity) async {
    if (_currentUser == null) return;

    final cartRef = _firestore
        .collection('users')
        .doc(_currentUser!.uid)
        .collection('cart');
    
    if (quantity > 0) {
      await cartRef.doc(product.id.toString()).update({'quantity': quantity});
    } else {
      await removeFromCart(product);
    }
  }

  Stream<List<Product>> getCartStream() {
    if (_currentUser == null) {
      return Stream.value([]);
    }
    return _firestore
        .collection('users')
        .doc(_currentUser!.uid)
        .collection('cart')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        final data = doc.data();
        return Product.fromJson(data);
      }).toList();
    });
  }
}
