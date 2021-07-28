/// This class will handle all the activities with firebase cloud storage and database
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DBServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _database = FirebaseFirestore.instance;

  //Update user profile
  Future<bool> updateUser(
      String email, String firstName, String lastName) async {
    try {
      await _database.collection('users').doc(_auth.currentUser!.uid).update(
          {'email': email, 'first_name': firstName, 'last_name': lastName});
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> addProduct(
      String productName, String imageURL, String brand, double price) async {
    var _docRef;
    try {
      _docRef = await _database.collection('products').add({
        'name': productName.trim(),
        'imageURL': imageURL.trim(),
        'brand': brand.trim(),
        'price': price
      });
      await _database.collection('products').doc(_docRef.id).update({
        'id': _docRef.id,
      });
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> deleteProductFromListing(String itemID) async {
    try {
      await _database.collection('products').doc(itemID).delete();
      return true;
    } catch (e) {
      print('Failed to delete: $e');
      return false;
    }
  }

  Future<bool> removeFromCart(String itemID) async {
    try {
      await _database
          .collection('orders')
          .doc(_auth.currentUser!.uid)
          .collection('cart')
          .doc(itemID)
          .delete();
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> addToCart(
      String itemID, String productName, int quantity, String imageURL, double price) async {
    try {
      final _documentSnapshot = _database
          .collection('orders')
          .doc(_auth.currentUser!.uid)
          .collection('cart')
          .doc(itemID);

      await _documentSnapshot.get().then((DocumentSnapshot document) {
        if(document.exists){
          final docObj = document.data() as Map<dynamic, dynamic>;
          int cartQuantity = docObj['quantity'] + 1;
          _documentSnapshot.update({'quantity': cartQuantity});
        }else{
          _documentSnapshot.set({
            'itemID': itemID,
            'productName': productName,
            'price': price,
            'quantity': quantity,
            'imageURL': imageURL
          });
        }
      });
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<void> emptyCart() async {
    try {
      await _database
          .collection('orders')
          .doc(_auth.currentUser!.uid)
          .collection('cart')
          .get()
          .then((snapshot) {
        for (DocumentSnapshot doc in snapshot.docs) {
          doc.reference.delete();
        }
      });
    } catch (e) {
      print(e);
    }
  }

  Future<double> cartSubtotal () async {
    try {
      double subtotal = 0;
      await _database
          .collection('orders')
          .doc(_auth.currentUser!.uid)
          .collection('cart')
          .get()
          .then((snapshot) {
        for (DocumentSnapshot doc in snapshot.docs) {
          final docObj = doc.data() as Map<dynamic, dynamic>;
          subtotal += docObj['price'];
        }
      });
      return subtotal;
    } catch (e) {
      print(e);
      return 0;
    }
  }

  Future<int> itemInCartCount() async {
    try {
      int cartLength = await _database
          .collection('orders')
          .doc(_auth.currentUser!.uid)
          .collection('cart')
          .orderBy('productName')
          .snapshots().length;
      return cartLength;
    } catch (e) {
      print(e);
      return 0;
    }
  }

  //Create a stream that listens to message changes
  Stream<QuerySnapshot> retrieveCartStream() {
    return _database
        .collection('orders')
        .doc(_auth.currentUser!.uid)
        .collection('cart')
        .orderBy('productName')
        .snapshots();
  }

  //Retrieve one user's data via a stream
  Stream<DocumentSnapshot> userDataStream() {
    return _database
        .collection('users')
        .doc(_auth.currentUser!.uid)
        .snapshots();
  }

  //Create a product stream
  Stream<QuerySnapshot> productStream() {
    return _database
        .collection('products')
        .orderBy('name')
        .snapshots();
  }
}
