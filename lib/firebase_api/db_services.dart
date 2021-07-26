/// This class will handle all the activities with firebase cloud storage and database
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DBServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _database = FirebaseFirestore.instance;

  //Retrieve specific user data
  Future<DocumentSnapshot> retrieveUserData() async {
    return await _database
        .collection('users')
        .doc(_auth.currentUser!.uid)
        .get();
  }

  //Update user profile
  Future<bool> updateUser(String email,String firstName,String lastName) async {
    try {
      await _database.collection('users').doc(_auth.currentUser!.uid).update(
          {'email': email, 'first_name': firstName, 'last_name': lastName});
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> addProduct(String productName, String imageURL, String brand, String price) async {
    var _docRef;
    try{
      _docRef = await _database.collection('products').add({
        'name': productName.trim(),
        'imageURL': imageURL.trim(),
        'brand': brand.trim(),
        'price': price.trim()
      });
      await _database.collection('products').doc(_docRef.id).update({
        'id': _docRef.id,
      });
      return true;
    }catch(e){
      print(e);
      return false;
    }
  }

  Future<bool> deleteItem(String itemID) async {
    try{
      await _database.collection('products').doc(itemID).delete();
      return true;
    }catch(e){
      print('Failed to delete user: $e');
      return false;
    }
  }
  
  Future<bool> addToCart(
      String itemID,
      String productName,
      String imageURL,
      String price) async {
    try{
      await _database.collection('orders')
          .doc(_auth.currentUser!.uid)
          .collection('cart')
          .doc(itemID)
          .set({
        'itemID': itemID,
        'productName':productName,
        'price':price,
        'imageURL':imageURL});
      return true;
    }catch(e){
      print(e);
      return false;
    }
  }

  //Create a stream that listens to message changes
  Stream<QuerySnapshot> messageStream(String topic) {
    return _database
        .collection('board_message')
        .doc(topic)
        .collection(topic)
        .orderBy('sendAt', descending: true)
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
        .orderBy('name', descending: false)
        .snapshots();
  }
}
