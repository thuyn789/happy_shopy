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

  Future<bool> removeFromCart(String itemID, double price, int quantity) async {
    try {
      final _snapshot =
          _database.collection('orders').doc(_auth.currentUser!.uid);

      //Update cart count and subtotal
      await _snapshot.get().then((DocumentSnapshot doc) {
        final docObj = doc.data() as Map<dynamic, dynamic>;
        int cartCount = docObj['cartCount'] - quantity;
        double subtotal = docObj['cartSubtotal'] - (price * quantity);
        subtotal = double.parse(subtotal.toStringAsFixed(2));
        _snapshot.update({'cartCount': cartCount, 'cartSubtotal': subtotal});
      });

      //Delete item from cart
      await _snapshot.collection('cart').doc(itemID).delete();
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> addToCart(String itemID, String productName, int quantity,
      String imageURL, double price) async {
    try {
      final _documentSnapshot =
          _database.collection('orders').doc(_auth.currentUser!.uid);

      await _documentSnapshot
          .collection('cart')
          .doc(itemID)
          .get()
          .then((DocumentSnapshot document) {
        if (document.exists) {
          final docObj = document.data() as Map<dynamic, dynamic>;
          //Update item quantity if item was previously added
          int cartQuantity = docObj['quantity'] + quantity;
          _documentSnapshot
              .collection('cart')
              .doc(itemID)
              .update({'quantity': cartQuantity});

          //Update subtotal to parent document of cart collection
          _documentSnapshot.get().then((DocumentSnapshot doc) {
            final docObj = doc.data() as Map<dynamic, dynamic>;
            int cartCount = docObj['cartCount'] + quantity;
            double subtotal = docObj['cartSubtotal'] + price;
            subtotal = double.parse(subtotal.toStringAsFixed(2));
            _documentSnapshot
                .update({'cartCount': cartCount, 'cartSubtotal': subtotal});
          });
        } else {
          //If item was not added before, add it to cart
          //Update Cart counter and subtotal to parent document of cart collection
          _documentSnapshot.get().then((DocumentSnapshot doc) {
            final docObj = doc.data() as Map<dynamic, dynamic>;
            int cartCount = docObj['cartCount'] + quantity;
            double subtotal = docObj['cartSubtotal'] + price;
            subtotal = double.parse(subtotal.toStringAsFixed(2));
            _documentSnapshot
                .update({'cartCount': cartCount, 'cartSubtotal': subtotal});
          });

          //Add item to cart collection
          _documentSnapshot.collection('cart').doc(itemID).set({
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
      final _snapshot =
          _database.collection('orders').doc(_auth.currentUser!.uid);

      //Reset cart counter and subtotal
      await _snapshot.get().then((DocumentSnapshot doc) {
        _snapshot.update({'cartCount': 0, 'cartSubtotal': 0.00});
      });

      await _snapshot.collection('cart').get().then((snapshot) {
        for (DocumentSnapshot doc in snapshot.docs) {
          doc.reference.delete();
        }
      });
    } catch (e) {
      print(e);
    }
  }

  Future<double> cartSubtotal() async {
    try {
      double subtotal = 0;
      await _database
          .collection('orders')
          .doc(_auth.currentUser!.uid)
          .get()
          .then((snapshot) {
        final docObj = snapshot.data() as Map<dynamic, dynamic>;
        subtotal = docObj['cartSubtotal'];
      });
      return subtotal;
    } catch (e) {
      print(e);
      return 0.00;
    }
  }

  Future<void> cartCount() async {
    try {
      await _database
          .collection('orders')
          .doc(_auth.currentUser!.uid)
          .get()
          .then((snapshot) {
        final docObj = snapshot.data() as Map<dynamic, dynamic>;
        print(docObj['cartCount']);
      });
    } catch (e) {
      print(e);
    }
  }

  //Retrieve all items in the cart via a stream
  Stream<QuerySnapshot> cartStream() {
    return _database
        .collection('orders')
        .doc(_auth.currentUser!.uid)
        .collection('cart')
        .orderBy('productName')
        .snapshots();
  }

  //Retrieve cart info, such as subtotal, item count, etc... via a stream
  Stream<DocumentSnapshot> cartInfoStream() {
    return _database
        .collection('orders')
        .doc(_auth.currentUser!.uid)
        .snapshots();
  }

  //Retrieve one user's data via a stream
  Stream<DocumentSnapshot> userDataStream() {
    return _database
        .collection('users')
        .doc(_auth.currentUser!.uid)
        .snapshots();
  }

  //Retrieve all items that are listed for sale
  Stream<QuerySnapshot> productStream() {
    return _database.collection('products').orderBy('name').snapshots();
  }
}
