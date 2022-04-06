import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopping_portal_demo/src/core/helpers/alert_helper.dart';
import 'package:shopping_portal_demo/src/core/helpers/common_constants.dart';
import 'package:shopping_portal_demo/src/core/helpers/prefs_constants.dart';
import 'package:shopping_portal_demo/src/core/helpers/url_constants.dart';
import 'package:shopping_portal_demo/src/core/models/http_exception.dart';
import 'package:shopping_portal_demo/src/core/models/table_schemas/user_table_schema.dart';

class AuthProvider with ChangeNotifier {
  GenderTypes _signUpSelectedGenderType = GenderTypes.male;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final databaseReference = FirebaseFirestore.instance;

  String? _token;
  String? _userID;
  String? _userDocID;

  GenderTypes get getSignUpSelectedGenderType {
    return _signUpSelectedGenderType;
  }

  void setSignUpSelectedGenderTypeTo({@required GenderTypes? gender}) {
    _signUpSelectedGenderType = gender!;
    notifyListeners();
  }

  Future<bool> signUp({
    @required BuildContext? ctx,
    @required String? email,
    @required String? password,
    String mobNum = '',
    @required String? name,
  }) async {
    final status = await _firebaseAuth
        .createUserWithEmailAndPassword(email: email!, password: password!)
        .then((authResult) async {
      User user = authResult.user!;

      print('FirebaseUser:');
      print('User ID: ${user.uid}');
      _userID = user.uid;

      try {
        final userData = {
          UserTable.userID: _userID,
          UserTable.emailID: email,
          UserTable.gender:
              _signUpSelectedGenderType == GenderTypes.male ? '1' : '2',
          UserTable.mobNum: mobNum,
          UserTable.name: name,
        };
        await databaseReference
            .collection(Tables.users)
            .add(userData)
            .then((value) async {
          print('New user documentID: ${value.id}');
          _userDocID = value.id;

          final prefs = await SharedPreferences.getInstance();
          final userData = json.encode(
            {
              FSPrefs.userID: _userID,
              FSPrefs.userDocID: _userDocID,
              FSPrefs.userImageUrl: '',
              FSPrefs.userName: name,
              FSPrefs.userToken: _token ?? '',
            },
          );
          prefs.setString(FSPrefs.userData, userData);
        }).catchError((err) {
          print('New user server error: ${err.message}');
        });
      } on FirebaseAuthException catch (e) {
        print('New user method error: ${e.message}');
      }

      print('Return true');
      return true;
    }).catchError((error) {
      print('createUserWithEmailAndPassword error: $error');
      AlertHelper.showOnlyOkAlertDialog(ctx: ctx!, msg: error.message);
      return false;
    });
    return status;
  }

  Future<bool> signIn({
    @required BuildContext? ctx,
    @required String? email,
    @required String? password,
  }) async {
    try {
      final authResult = await _firebaseAuth.signInWithEmailAndPassword(
          email: email!, password: password!);
      User user = authResult.user!;
      print('FirebaseUser:');
      print('User ID: ${user.uid}');

      final snapShot = await databaseReference
          .collection(Tables.users)
          .where(UserTable.userID, isEqualTo: user.uid)
          .get();

      if (snapShot.docs.isEmpty) {
        print('UserTable: No documents found!');
        throw HttpException(message: 'No user found!');
      }
      for (var document in snapShot.docs) {
        print('documentID: ${document.id}');

        // final prefs = await SharedPreferences.getInstance();
        // final userData = json.encode(
        //   {
        //     FSPrefs.userID: document[UserTable.userID],
        //     FSPrefs.userDocID: document.id,
        //     FSPrefs.userImageUrl: document[UserTable.imageUrl] ?? '',
        //     FSPrefs.userName: document[UserTable.name],
        //     FSPrefs.userToken: _token ?? '',
        //   },
        // );
        // prefs.setString(FSPrefs.userData, userData);

        _userID = user.uid;
        _userDocID = document.id;
      }

      return true;
    } on FirebaseAuthException catch (error) {
      print('signIn error: $error');
      AlertHelper.showOnlyOkAlertDialog(ctx: ctx!, msg: error.message!);
      return false;
    }
  }

  Future<bool> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey(FSPrefs.userData)) {
      return false;
    }
    final extractedUserData =
        json.decode(prefs.getString(FSPrefs.userData)!) as Map<String, Object>;

    _token = (extractedUserData[FSPrefs.userToken] ?? '') as String?;
    _userID = extractedUserData[FSPrefs.userID] as String?;
    _userDocID = extractedUserData[FSPrefs.userDocID] as String?;

    notifyListeners();
    return true;
  }

  bool get isAuthorized {
    return getUserID != null;
  }

  String? get getUserID {
    return _userID;
  }

  String? get getUserDocID {
    return _userDocID;
  }

  Future<bool?> logOut() async {
    _userID = null;
    _token = null;

    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey(FSPrefs.userData)) {
      return false;
    }
    prefs.remove(FSPrefs.userData);
    return null;
  }
}
