/// This class will handle all the activities with firebase cloud storage and database
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DBServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _database = FirebaseFirestore.instance;

  ///
  /// USER SETTINGS
  ///

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

  ///
  /// MANAGE PRODUCT
  ///

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

  ///
  /// MANAGE CART
  ///

  Future<bool> removeFromCart(String itemID, double price, int quantity) async {
    try {
      final _snapshot =
          _database.collection('orders').doc(_auth.currentUser!.uid);

      //Update cart counter and subtotal
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

      var successful =
          await _documentSnapshot.get().then((DocumentSnapshot doc) {
        final docObj = doc.data() as Map<dynamic, dynamic>;
        final maxItemInCart = 15;

        //Check if cart has 15 items, return if true
        if (docObj['cartCount'] >= maxItemInCart) {
          return false;
        }

        //Update subtotal to parent document of cart collection
        int cartCount = docObj['cartCount'] + quantity;
        double subtotal = docObj['cartSubtotal'] + price;
        subtotal = double.parse(subtotal.toStringAsFixed(2));
        _documentSnapshot
            .update({'cartCount': cartCount, 'cartSubtotal': subtotal});

        //Add item to cart
        //if item was added to cart before, update quantity
        //if item is a new item, add to cart collection
        _documentSnapshot
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
          } else {
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
      });
      return successful;
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

      //Go to all documents and delete them one by one
      await _snapshot.collection('cart').get().then((snapshot) {
        for (DocumentSnapshot doc in snapshot.docs) {
          doc.reference.delete();
        }
      });
    } catch (e) {
      print(e);
    }
  }

  ///
  /// PAYMENT
  ///

  //Store all information of an order after payment is authorized and processed
  Future<void> paymentConfirm(
      final paymentInfo, final cardInfo, final cartInfo) async {
    try {
      String orderNumber = '${paymentInfo['created']}';

      final _snapshot =
          _database.collection('orders').doc(_auth.currentUser!.uid);

      //Move all item from cart to orders collection
      //Empty cart upon moving
      await _snapshot.collection('cart').get().then((snapshot) {
        for (DocumentSnapshot doc in snapshot.docs) {
          final docObj = doc.data() as Map<String, dynamic>;

          //Copy item from cart collection to orders collection
          _snapshot
              .collection('orders')
              .doc(orderNumber)
              .collection('items')
              .doc(doc.id)
              .set(docObj);

          _snapshot
              .collection('orders')
              .doc(orderNumber)
              .collection('items')
              .doc(doc.id)
              .update({'order_number': orderNumber});

          //Delete item from cart collection
          doc.reference.delete();
        }
      });

      //Update order counter
      //Reset cart counter and subtotal
      await _snapshot.get().then((DocumentSnapshot doc) {
        final docObj = doc.data() as Map<dynamic, dynamic>;
        int orderCount = docObj['orderCount'] + 1;
        _snapshot.update(
            {'cartCount': 0, 'cartSubtotal': 0.00, 'orderCount': orderCount});
      });

      //Store payment and credit card info
      //Store cart info, such as subtotal, tax, total
      await _snapshot.collection('orders').doc(orderNumber).set({
        'order_number': orderNumber,
        'tokenID': paymentInfo['id'],
        'card_brand': cardInfo['brand'],
        'card_country': cardInfo['country'],
        'card_expMonth': cardInfo['expMonth'],
        'card_expYear': cardInfo['expYear'],
        'card_funding': cardInfo['funding'],
        'card_last4': cardInfo['last4'],
        'order_subtotal': cartInfo['subtotal'],
        'order_shipping': cartInfo['shipping'],
        'order_tax': cartInfo['tax'],
        'order_taxRate': cartInfo['taxRate'],
        'order_total': cartInfo['total'],
        'item_count': cartInfo['itemCount'],
        'canceled': 0,
        'refund': 0,
      });
    } catch (e) {
      print(e);
    }
  }

  ///
  /// ORDERS
  ///

  //Retrieve user's orders
  Future<QuerySnapshot> retrieveOrders(String userID) async {
    String _userID = userID == '' ? _auth.currentUser!.uid : userID;

    return _database
        .collection('orders')
        .doc(_userID)
        .collection('orders')
        .get();
  }

  //Cancel an item from an order
  Future<bool> cancelItemFromOrder(String itemID, String orderNumber, String userID) async {
    try {
      String _userID = userID == '' ? _auth.currentUser!.uid : userID;

      final _snapshot =
          _database.collection('orders').doc(_userID);

      //Update the status to the item being cancel
      await _snapshot
          .collection('orders')
          .doc(orderNumber)
          .collection('items')
          .doc(itemID)
          .update({'status': 'Canceled'});

      //Update refund amount to the order document
      //Update the counter for canceled item
      await _snapshot
          .collection('orders')
          .doc(orderNumber)
          .collection('items')
          .doc(itemID)
          .get()
          .then((DocumentSnapshot document) {
        final dataObj = document.data() as Map<dynamic, dynamic>;
        double price = dataObj['price'];
        int itemCount = dataObj['quantity'];
        double taxRate = 0.08;

        double estimateRefund = price * itemCount * (taxRate+1);
        estimateRefund = double.parse(estimateRefund.toStringAsFixed(2));

        _snapshot
            .collection('orders')
            .doc(orderNumber)
            .get()
            .then((DocumentSnapshot document) {
          final dataObj = document.data() as Map<dynamic, dynamic>;
          int canceled = dataObj['canceled'] + itemCount;
          double refund = dataObj['refund'] + estimateRefund;
          _snapshot
              .collection('orders')
              .doc(orderNumber)
              .update({'canceled': canceled, 'refund': refund});
        });
      });

      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  ///
  /// STREAM SECTIONS
  ///

  //Retrieve all orders of a user
  Stream<QuerySnapshot> orderStream(String userID) {
    String _userID = userID == '' ? _auth.currentUser!.uid : userID;
    return _database
        .collection('orders')
        .doc(_userID)
        .collection('orders')
        .snapshots();
  }

  //Retrieve all items in an orders
  Stream<QuerySnapshot> orderItemStream(String orderNumber, String userID) {
    String _userID = userID == '' ? _auth.currentUser!.uid : userID;
    return _database
        .collection('orders')
        .doc(_userID)
        .collection('orders')
        .doc(orderNumber)
        .collection('items')
        .orderBy('productName')
        .snapshots();
  }

  //Retrieve order info
  Stream<DocumentSnapshot> orderInfoStream(String orderNumber, String userID) {
    String _userID = userID == '' ? _auth.currentUser!.uid : userID;
    return _database
        .collection('orders')
        .doc(_userID)
        .collection('orders')
        .doc(orderNumber)
        .snapshots();
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
