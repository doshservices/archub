import 'dart:convert';
import 'dart:io';

import 'package:archub/model/comment.dart';
import 'package:archub/model/http_exception.dart';
import 'package:archub/model/post_data.dart';
import 'package:archub/model/tag.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../config.dart' as config;

class UserPost with ChangeNotifier {
  List<PostData> postData = [];
  List<TagData> tagData = [];
  List<CommentData> commentData = [];
  PostData postDatabyId = PostData();

  Future<void> getAllUserPort() async {
    final prefs = await SharedPreferences.getInstance();
    final extractdata = json.decode(prefs.getString("userData"));
    String token = extractdata["token"];

    // print(token);
    try {
      postData = [];
      final response = await http.get(
        "${config.baseUrl}/posts",
        headers: {
          "content-type": "application/json",
          "Authorization": "Bearer $token"
        },
      );
      var resData = jsonDecode(response.body);

      print(resData);
      if (resData["message"] == "success") {
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
        // print(postData.length);
      }
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> getTag() async {
    final prefs = await SharedPreferences.getInstance();
    final extractdata = json.decode(prefs.getString("userData"));
    String token = extractdata["token"];

    // print(token);
    try {
      tagData = [];
      final response = await http.get(
        "${config.baseUrl}/tags",
        headers: {
          "content-type": "application/json",
          "Authorization": "Bearer $token"
        },
      );
      var resData = jsonDecode(response.body);

      print(resData);
      if (resData["message"] == "success") {
        List<dynamic> entities = resData["data"]["tags"];
        entities.forEach((entity) {
          TagData itemcategory = TagData();

          itemcategory.name = entity['name'];
          itemcategory.id = entity['_id'];

          tagData.add(itemcategory);
        });
        // print(postData.length);
      }
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> getPostById(id) async {
    final prefs = await SharedPreferences.getInstance();
    final extractdata = json.decode(prefs.getString("userData"));
    String token = extractdata["token"];

    print(id);
    try {
      final response = await http.get(
        "${config.baseUrl}/posts/$id",
        headers: {
          "content-type": "application/json",
          "Authorization": "Bearer $token"
        },
      );
      var resData = jsonDecode(response.body);

      print("/// 777 " +resData.toString());
      if (resData["message"] == "success") {
        PostData itemcategory = PostData();

        itemcategory.isActive = resData['data']['data']['isActive'];
        print(itemcategory.isActive);
        itemcategory.reactions = resData['data']['data']['reactions'];
        itemcategory.id = resData['data']['data']['_id'];
        itemcategory.sourceId = resData['data']['data']['sourceId'];
        itemcategory.title = resData['data']['data']['title'];
        itemcategory.description = resData['data']['data']['description'];
        itemcategory.attachmentName = resData['data']['data']['attachmentName'];
        itemcategory.attachmentURI = resData['data']['data']['attachmentURI'];
        itemcategory.attachmentSize = resData['data']['data']['attachmentSize'];
        itemcategory.createdAt = resData['data']['data']['createdAt'];
        itemcategory.updatedAt = resData['data']['data']['updatedAt'];
        itemcategory.reactions = resData['data']['data']['reactions'];

        postDatabyId = itemcategory;

        // print(postData.length);
      }
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> getCommentById(id) async {
    final prefs = await SharedPreferences.getInstance();
    final extractdata = json.decode(prefs.getString("userData"));
    String token = extractdata["token"];

    // print(token);
    try {
      commentData = [];
      final response = await http.get(
        "${config.baseUrl}/comments/post-comments/$id",
        headers: {
          "content-type": "application/json",
          "Authorization": "Bearer $token"
        },
      );
      var resData = jsonDecode(response.body);

      print(resData);
      if (resData["message"] == "success") {
        List<dynamic> entities = resData["data"];
        entities.forEach((entity) {
          CommentData itemcategory = CommentData();

          itemcategory.id = entity['_id'];
          itemcategory.comment = entity['comment'];

          commentData.add(itemcategory);
        });

        // print(postData.length);
      }
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> creatPost(base64Image, title, tag, description, location) async {
    final prefs = await SharedPreferences.getInstance();
    final extractdata = json.decode(prefs.getString("userData"));
    String token = extractdata["token"];
    print(token);
    print(title + " " + tag + " " + description + " " + location);
    print(base64Image);

    var data = jsonEncode({
      "title": title.toString(),
      "description": description.toString(),
      "tag": tag.toString(),
      "location": location.toString(),
      "base64": base64Image.toString()
    });

    try {
      final response = await http.post(
        "${config.baseUrl}/posts",
        headers: {
          "content-type": "application/json",
          "Authorization": "Bearer $token"
        },
        body: data,
      );
      var resData = jsonDecode(response.body);

      // print(resData);
      // print(data);
      if (resData["message"] != "success") {
        throw HttpException(resData["error"]);
      }

      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> creatComment(comment, postId) async {
    final prefs = await SharedPreferences.getInstance();
    final extractdata = json.decode(prefs.getString("userData"));
    String token = extractdata["token"];
    print(token);
    print(postId);
    print(comment);

    var data = jsonEncode({
    "postId": postId.toString(),
    "comment": comment.toString()
  });

    try {
      final response = await http.post(
        "${config.baseUrl}/comments",
        headers: {
          "content-type": "application/json",
          "Authorization": "Bearer $token"
        },
        body: data,
      );
      var resData = jsonDecode(response.body);

      print(resData);
      // print(data);
      if (resData["message"] != "success") {
        throw HttpException(resData["error"]);
      }

      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  // Future<void> uploadFarmProduct({
  //   String name,
  //   String price,
  //   String desc,
  //   int category_id,
  //   int scale_id,
  //   int qty,
  //   File image,
  //   File image1,
  //   File image2,
  //   File image3,
  // }) async {

  //   try {

  //     var request = http.MultipartRequest('POST',
  //         Uri.parse("Https://farmfocus.herokuapp.com/api/farmer/add-product"));
  //     request.files.add(await http.MultipartFile.fromPath('image', image.path));
  //     if (image1 != null) {
  //       request.files.add(
  //           await http.MultipartFile.fromPath('other_photos', image1.path));
  //     }
  //     if (image2 != null) {
  //       request.files.add(
  //           await http.MultipartFile.fromPath('other_photos', image2.path));
  //     }
  //     if (image3 != null) {
  //       request.files.add(
  //           await http.MultipartFile.fromPath('other_photos', image3.path));
  //     }
  //     request.fields['name'] = name;
  //     request.fields['description'] = desc;
  //     request.fields['price'] = price;
  //     request.fields['category_id'] = category_id.toString();
  //     request.fields['scale_id'] = scale_id.toString();
  //     request.fields['qty'] = qty.toString();
  //     request.headers.addAll({"Authorization": "Bearer " + _token});
  //     var response = await request.send();

  //     if (response.statusCode != 200) {
  //       throw HttpException("Error Uploading Product");
  //     }

  //     notifyListeners();
  //   } catch (error) {
  //     throw error;
  //   }
  // }

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
