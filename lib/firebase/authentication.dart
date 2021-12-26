import 'package:chat/components/shared_database.dart';
import 'package:chat/hive/boxes.dart';
import 'package:chat/hive/user_info.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hive/hive.dart';

class FirebaseService {
  static FirebaseAuth _auth = FirebaseAuth.instance;
  static GoogleSignIn _googleSignIn = GoogleSignIn();
   static CollectionReference users = FirebaseFirestore.instance.collection('users');

  static Future<String?> signInwithGoogle() async {
    try {
      GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();
      GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount!.authentication;
      AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      await _auth.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      print(e.message);
      throw e;
    }
  }

  static Future<void> signOutFromGoogle() async{
    await _googleSignIn.signOut();
    await _auth.signOut();
  }

  static Future saveUserInfo() async {
    final currentUser =  _auth.currentUser!;
    Map<String, String> userInfo = {
      'uid': currentUser.uid.toString(),
      'email': currentUser.email.toString(),
      'displayName': currentUser.displayName.toString(),
      'photoUrl': currentUser.photoURL.toString(),
      'phoneNumber': currentUser.phoneNumber.toString(),
    };
    // SharedData.saveUser(userInfo);
    Boxes.getUserInfoBox().put('currentUser',UserInf.fromJson(userInfo));
    
  }

  static void writeData() {
    var user =  _auth.currentUser!;
    var email = user.email;
    users.doc(email).set({
      'uid': user.uid,
      'email': email,
      'photoUrl': user.photoURL,
      'displayName': user.displayName,
      'phoneNumber': user.phoneNumber,
    });
  }

  // getting list of documents from users collection
  static getUserList() async {
    QuerySnapshot querySnapshot = await users.get();
    List<Object?> allData = querySnapshot.docs.map((doc) => doc.data()).toList();
    allData = allData.map((e,) => e as Map<String, dynamic>).toList();
    return allData;
  }
}