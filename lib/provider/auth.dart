import 'dart:convert';

import 'package:archub/model/http_exception.dart';
import 'package:archub/model/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../config.dart' as config;

class Auth with ChangeNotifier {
  String _token;
  String _accessTokenType;
  String walletNumber, walletBalance;
  String weblink;
  String transactionref;
  // dynamic socketIo;

  User user = User();

  bool get isAuth {
    return token != null;
  }

  String get token {
    if (_token != null) {
      return _token;
    }
    return null;
  }

  String get accessTokenType {
    if (_accessTokenType != null) {
      return _accessTokenType;
    }
    return null;
  }

  Future<void> signUp(User user, token) async {
    var data = jsonEncode({
      "fullName": user.fullName,
      "email": user.email,
      "userType": "USER",
      "otp": token,
      "password": user.password
    });
    print(data);
    try {
      final response = await http.post(
        "${config.baseUrl}/users",
        headers: {"content-type": "application/json"},
        body: data,
      );
      var resData = jsonDecode(response.body);

      print(resData);
      if (resData["message"] != "success") {
        if (resData["status"] == "error") {
          throw HttpException(resData["message"]['message'][0]);
        } else {
          throw HttpException(resData["error"]);
        }
      }

      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> editProfile(fullName, city, country, phoneNumber, location) async {
    var data = jsonEncode({
    "fullName": fullName,
    "city":city,
    "country":country,
    "phoneNumber": phoneNumber,
    "location":location
   });
   print(data);
    print(data);
    try {
      final response = await http.put(
        "${config.baseUrl}/users/update-profile",
        headers: {
          "content-type": "application/json",
          "Authorization": "Bearer $token"
        },
        body: data,
      );
      var resData = jsonDecode(response.body);

      print(resData);
      if (resData["message"] != "success") {
        if (resData["status"] == "error") {
          throw HttpException(resData["message"]['message'][0]);
        } else {
          throw HttpException(resData["error"]);
        }
      }

      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> getProfile() async {
    
    // print(data);
    try {
      final response = await http.get(
        "${config.baseUrl}/users",
        headers: {
          "content-type": "application/json",
          "Authorization": "Bearer $token"
        },
      );
      var resData = jsonDecode(response.body);

      print(resData);
      if (resData["message"] != "success") {
        if (resData["status"] == "error") {
          throw HttpException(resData["message"]['message'][0]);
        } else {
          throw HttpException(resData["error"]);
        }
      }

      if (resData["message"] == "success") {
        // _token = resData["data"]["token"];
        User userdata = User();
        userdata.id = resData["data"]["user"]['_id'];
        
        userdata.fullName = resData["data"]["user"]['fullName'];
        userdata.phone = resData["data"]["user"]['phoneNumber'];
        userdata.email = resData["data"]["user"]['email'];
        userdata.pictureUrl = resData["data"]["user"]['image'];

        user = userdata;

        // _autoLogout();

      }
      print("here is $token");

      final prefs = await SharedPreferences.getInstance();
      final userData = json.encode({
        'token': token,
        'userId': user.id,
        "userPhone": user.phone,
        "userEmail": user.email,
        "fullName": user.fullName,
        // "pictureUrl": user.pictureUrl,
      });
      prefs.setString("userData", userData);


      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> getOtp(User user) async {
    var data = jsonEncode({
    "email": user.email
    });
    print(data);
    try {
      final response = await http.post(
        "${config.baseUrl}/send-token",
        headers: {"content-type": "application/json"},
        body: data,
      );
      var resData = jsonDecode(response.body);
      print('//////get data');
      print(resData);
      print(response.statusCode);
      print(data);
      if (resData["message"] != "success") {
        throw HttpException(resData["message"]);
      }

      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> signIn(String email, String password) async {
    var data = jsonEncode({"loginId": email, "password": password});
    try {
      final response = await http.post(
        "${config.baseUrl}/users/login",
        headers: {"content-type": "application/json"},
        body: data,
      );
      var resData = jsonDecode(utf8.decode(response.bodyBytes));

      print(resData);
      print(response.statusCode);
      print(data);
      if (resData["message"] != "success") {
        throw HttpException(resData["message"]);
      }

      if (resData["message"] == "success") {
        _token = resData["data"]["token"];
        User userdata = User();
        userdata.id = resData["data"]["userDetails"]['_id'];
        
        userdata.fullName = resData["data"]["userDetails"]['fullName'];
        // userdata.phone = resData["data"]["userDetails"]['_id'];
        userdata.email = resData["data"]["userDetails"]['email'];
        userdata.pictureUrl = resData["data"]["userDetails"]['image'];

        user = userdata;

        // _autoLogout();

      }
      print("here is $token");

      final prefs = await SharedPreferences.getInstance();
      final userData = json.encode({
        'token': token,
        'userId': user.id,
        "userPhone": user.phone,
        "userEmail": user.email,
        "fullName": user.fullName,
        // "pictureUrl": user.pictureUrl,
      });
      prefs.setString("userData", userData);
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> forgot(String email) async {
    var data = jsonEncode({
    "email":email
});
    try {
      final response = await http.post(
        "${config.baseUrl}/users/forgot-password",
        headers: {"content-type": "application/json"},
        body: data,
      );
      var resData = jsonDecode(utf8.decode(response.bodyBytes));

      print(resData);
      print(response.statusCode);
      print(data);
      if (resData["message"] != "success") {
        throw HttpException(resData["message"]);
      }

      if (resData["message"] == "success") {
       throw HttpException(resData['data']["message"]);
        // _autoLogout();

      }
      print("here is $token");
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> verifyOtp(String phone, String phoneToken) async {
    var data = jsonEncode({"phone": phone, "otp": phoneToken});

    try {
      final response = await http.post(
        "${config.baseUrl}/onboarding/complete",
        headers: {"content-type": "application/json"},
        body: data,
      );
      var resData = jsonDecode(response.body);

      print(resData);
      print(data);
      if (resData['status'] != "success") {
        throw HttpException(resData["message"]);
      }

      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> resendOtp(int userId) async {
    var data = jsonEncode({
      "user_id": userId,
    });

    try {
      final response = await http.post(
        "${config.baseUrl}/resend_phone_token",
        headers: {"content-type": "application/json"},
        body: data,
      );
      var resData = jsonDecode(response.body);

      print(resData);
      print(data);
      if (resData["success"] == null) {
        throw HttpException(resData["error"]);
      }

      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<bool> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    await Future.delayed(Duration(milliseconds: 2000), () {
      print(prefs.getString('userData'));
      if (!prefs.containsKey("userData")) {
        return false;
      }

      final extractedUserData = json.decode(prefs.getString("userData"));

      _token = extractedUserData["token"];
      user.id = extractedUserData["userId"];
      user.email = extractedUserData["userEmail"];
      // user.phone = extractedUserData["userPhone"];
      user.fullName = extractedUserData["fullName"];
      // user.pictureUrl = extractedUserData["pictureUrl"];

      notifyListeners();
      // _autoLogout();
      return true;
    });
  }

  void logout() async {
    _token = null;
    user = null;
    // if (_authTimer != null) {
    //   _authTimer.cancel();
    //   _authTimer = null;
    // }
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    prefs.remove("userData");
    this.user = User();
  }
}
