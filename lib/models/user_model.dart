import 'package:biblioteca_de_fanfic/data/ImageData.dart';
import 'package:biblioteca_de_fanfic/data/user_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:scoped_model/scoped_model.dart';
import 'package:flutter/material.dart';

class UserModel extends Model {
  FirebaseAuth _auth = FirebaseAuth.instance;

  User? _firebaseUser;
  UserCredential? _userCredential;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  UserData? userData;

  bool isLoding = false;

  static UserModel of(BuildContext context) =>
      ScopedModel.of<UserModel>(context);

  @override
  void addListener(VoidCallback listener) {
    super.addListener(listener);

    _loadCurrentUser();
  }

  void updateFanfic(String? fanficId, Map<String, dynamic> data) async {
    await _firestore
        .collection('users')
        .doc(_firebaseUser!.uid)
        .collection('fanfics')
        .doc(fanficId)
        .update(data);
  }

  Future<void> createFanfic(Map<String, dynamic> data) async {
    await _firestore
        .collection('users')
        .doc(_firebaseUser!.uid)
        .collection('fanfics')
        .add(data);
  }

  Future<void> deleteFanfic(String fanficId) async {
    await _firestore
        .collection('users')
        .doc(_firebaseUser!.uid)
        .collection('fanfics')
        .doc(fanficId)
        .delete();
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getAllFanfics() async {
    return await _firestore
        .collection('users')
        .doc(_firebaseUser!.uid)
        .collection('fanfics')
        .get();
  }

  String getUserUid() {
    return _firebaseUser!.uid;
  }

  //fazer cadastro
  void signUp(
      {required UserData userData,
      required String pass,
      required VoidCallback onSuccess,
      required VoidCallback onFail}) {
    isLoding = true;
    notifyListeners();

    _auth
        .createUserWithEmailAndPassword(
      email: userData.email!,
      password: pass,
    )
        .then((user) async {
      _userCredential = user;
      _firebaseUser = _auth.currentUser;

      userData.setId(_userCredential!.user!.uid);

      await _saveUserData(userData);

      onSuccess();
      isLoding = false;
      notifyListeners();
    }).catchError((e) {
      onFail();
      isLoding = false;
      notifyListeners();
    });
  }

  //fazer login
  void signIn(
      {required String email,
      required String pass,
      required VoidCallback onSuccess,
      required VoidCallback onFail}) async {
    isLoding = true;
    notifyListeners();

    _auth.signInWithEmailAndPassword(email: email, password: pass).then((user) {
      _userCredential = user;
      _loadCurrentUser();

      onSuccess();
      isLoding = false;
      notifyListeners();
    }).catchError((e) {
      onFail();

      isLoding = false;
      notifyListeners();
    });
  }

  void signOut() async {
    await _auth.signOut();

    userData = null;
    _firebaseUser = null;

    notifyListeners();
  }

  //recuperar senha
  void recoverPass(String email) {
    _auth.sendPasswordResetEmail(email: email);
  }

  void updateEmail(String email) {
    _firebaseUser!.updateEmail(email).catchError((onError) => print(onError));
  }

  Future<List<ImageData>> loadImages() async {
    final result = await _firestore.collection("images_profile").get();

    return result.docs
        .map((image) => ImageData(
              image.id,
              image.data()["url"] as String,
            ))
        .toList();
  }

  Future<Null> _loadCurrentUser() async {
    if (_firebaseUser == null) _firebaseUser = _auth.currentUser;

    if (_firebaseUser != null) {
      if (userData == null) {
        DocumentSnapshot docUser = await _firestore
            .collection("users")
            .doc(_auth.currentUser!.uid)
            .get();
        userData = UserData.fromDocument(docUser);

        final image = ImageData(
          userData!.image!.id,
          await findImageUrl(
            userData!.image!.id,
          ),
        );
        userData?.setImage(image);
      }
    }
    notifyListeners();
  }

  Future<String> findImageUrl(String id) async {
    final doc = await _firestore.collection("images_profile").doc(id).get();
    final data = doc.data();
    return doc.data()?["url"];
  }

  //saber se esta logado
  bool isLoggedIn() {
    return _firebaseUser != null;
  }

  Future<Null> _saveUserData(UserData? userData) async {
    this.userData = userData;

    await _firestore
        .collection("users")
        .doc(_firebaseUser!.uid)
        .set(userData!.userToMap());
  }

  Future updateUserDate(UserData userDate) async {
    isLoding = true;
    notifyListeners();

    try {
      await _saveUserData(userDate);

      isLoding = false;
      notifyListeners();
    } catch (e) {
      isLoding = false;
      notifyListeners();
    }
  }

  Future<void> updateUserLocal() async {
    isLoding = true;
    notifyListeners();

    try {
      await _saveUserData(this.userData);

      isLoding = false;
      notifyListeners();
    } catch (e) {
      isLoding = false;
      notifyListeners();
    }
  }

  Future<void> updateUser(
      {required UserData userData,
      required VoidCallback onSuccess,
      required VoidCallback onFail}) async {
    isLoding = true;
    notifyListeners();

    try {
      await _saveUserData(userData);

      onSuccess();
      isLoding = false;
      notifyListeners();
    } catch (e) {
      onFail();
      isLoding = false;
      notifyListeners();
    }
  }
}
