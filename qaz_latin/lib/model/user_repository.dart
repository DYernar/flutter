import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:qaz_latin/model/user.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class UserRepository {
  final GoogleSignIn _googleSignIn;

  UserRepository({FirebaseAuth firebaseAuth, GoogleSignIn googleSignin})
      : _googleSignIn = googleSignin ?? GoogleSignIn();

  Future<User> signInWithGoogle() async {
    try {
      GoogleSignIn _googleSignIn = GoogleSignIn(
        scopes: <String>[
          'email',
        ],
      );
      GoogleSignInAccount _currentUser =
          await _googleSignIn.signIn().catchError((err) {
        print(err);
        return null;
      });
      if (_currentUser == null) {
        return null;
      }

      await getToken(User(_currentUser.displayName, _currentUser.email,
          _currentUser.photoUrl, 0));

      return User(_currentUser.displayName, _currentUser.email,
          _currentUser.photoUrl, 0);
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<String> getToken(User user) async {
    var url = "https://evening-oasis-57787.herokuapp.com/signin";

    var body = jsonEncode({
      "username": user.username,
      "email": user.email,
      "name": user.img,
    });

    var r = await http.post(
      url,
      body: body,
      headers: {
        "Content-Type": "application/json",
        "appToken": "Qazaq latin app"
      },
    );

    if (r.statusCode == 200) {
      var userdata = json.decode(r.body);

      await saveUser(user, userdata['token']);
      return userdata['token'];
    }
    return "";
  }

  Future<bool> isSignedIn() async {
    final token = await getTokenPref();
    return token != "";
  }

  Future<void> signOut() async {
    await deleteUser();
    Future.wait([
      _googleSignIn.signOut(),
    ]);
  }

  Future<User> getUser() async {
    final token = await getTokenPref();
    if (token == "") {
      return null;
    } else {
      return await getUserPrefs();
    }
  }

  Future<void> deleteUser() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("displayname", "");
    await prefs.setString("email", "");
    await prefs.setString("img", "");
    await prefs.setString("token", "");
  }

  Future<void> saveUser(User user, String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("displayname", user.username);
    await prefs.setString("email", user.email);
    await prefs.setString("img", user.img);
    await prefs.setString("token", token);
    return;
  }

  Future<User> getUserPrefs() async {
    final prefs = await SharedPreferences.getInstance();

    final username = prefs.getString("displayname");
    final email = prefs.getString("email");
    final img = prefs.getString("img");

    return User(username, email, img, 0);
  }

  Future<String> getTokenPref() async {
    final prefs = await SharedPreferences.getInstance();

    final token = prefs.getString("token");
    return token;
  }
}
