import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:scoped_model/scoped_model.dart';
import 'package:flutter/material.dart';

class FanficModel extends Model {
  FirebaseAuth _auth = FirebaseAuth.instance;

  User? _firebaseUser;
  UserCredential? _userCredential;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Map<String, dynamic> userData = Map();

  bool isLoding = false;

  static FanficModel of(BuildContext context) =>
      ScopedModel.of<FanficModel>(context);

  @override
  void addListener(VoidCallback listener) {
    super.addListener(listener);
  }
}
