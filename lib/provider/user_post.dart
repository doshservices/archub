import 'dart:convert';

import 'package:archub/model/post_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../config.dart' as config;

class UserPost with ChangeNotifier {
  List<PostData> postData = [];

  Future<void> getAllUserPort() async {
    final prefs = await SharedPreferences.getInstance();
    final extractdata = json.decode(prefs.getString("userData"));
    String token = extractdata["token"];
    
    // print(token);
    try {
      postData = [];
      final response = await http.get(
        "${config.baseUrl}/posts/all",
        headers: {
          "content-type": "application/json",
          "Authorization": "Bearer $token"
        },
      );
      var resData = jsonDecode(response.body);

      print(resData);
      if(resData["message"] == "success"){
        List<dynamic> entities = resData["data"]["data"];
        entities.forEach((entity) {
          PostData itemcategory = PostData();

          itemcategory.isActive = entity['isActive'];
          itemcategory.reactions = entity['reactions'];
          itemcategory.id = entity['_id'];
          itemcategory.sourceId = entity['sourceId'];
          itemcategory.title = entity['title'];
          itemcategory.description = entity['description'];
          itemcategory.attachmentName = entity['attachmentName'];
          itemcategory.attachmentURI = entity['attachmentURI'];
          itemcategory.attachmentSize = entity['attachmentSize'];
          itemcategory.createdAt = entity['createdAt'];
          itemcategory.updatedAt = entity['updatedAt'];

          postData.add(itemcategory);
        });
        print(postData.length);
      }
      // {isActive: true, reactions: [], _id: 611fc1c522dfb033acd31855, sourceId: 611276d4a94aad6b9083aca9, title: jokes, 
      // description: fine, attachmentName: bot.png, attachmentURI: http://res.cloudinary.com/dasek9hic/image/upload/v1629471173/a3xcdv3lclheeiyi7ili.png, attachmentSize: 0.027mb, 
      // tag: 611b942dc64f7d2178e83fe5, createdAt: 2021-08-20T14:52:53.389Z, updatedAt: 2021-08-20T14:52:53.389Z, __v: 0}
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }
}

// {
//         "_id": "61183d4b23fa1c5c9007b784",
//         "sourceId": "611276d4a94aad6b9083aca9",
//         "title": "Niceeetttte",
//         "description": "BFBFBBFBBFss",
//         "attachmentName": "file_example_MP4_480_1_5MG.mp4",
//         "attachmentURI": "http://res.cloudinary.com/dasek9hic/video/upload/v1628978507/m8c8wif4yvarwqmzllwd.mp4",
//         "attachmentSize": "1.57mb",
//         "createdAt": "2021-08-14T22:01:47.773Z",
//         "updatedAt": "2021-08-16T17:13:15.610Z",
//         "__v": 1
//       },