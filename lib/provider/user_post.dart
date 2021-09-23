import 'dart:convert';
import 'dart:io';
import 'dart:convert' as convert;

import 'package:archub/model/comment.dart';
import 'package:archub/model/http_exception.dart';
import 'package:archub/model/post_data.dart';
import 'package:archub/model/tag.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../config.dart' as config;
import 'package:http_parser/http_parser.dart';

class UserPost with ChangeNotifier {
  List<PostData> postData = [];
  List<PostData> storyData = [];
  List<PostData> sourceIdData = [];
  List<TagData> tagData = [];
  List<CommentData> commentData = [];
  PostData postDatabyId = PostData();

  Future<void> getAllUserPort() async {
    final prefs = await SharedPreferences.getInstance();
    final extractdata = json.decode(prefs.getString("userData"));
    String token = extractdata["token"];

    print(extractdata);
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
          itemcategory.postFiles = entity['postFiles'];
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

  Future<void> getAllUserStory() async {
    final prefs = await SharedPreferences.getInstance();
    final extractdata = json.decode(prefs.getString("userData"));
    String token = extractdata["token"];

    print(extractdata);
    try {
      storyData = [];
      final response = await http.get(
        "https://archub.herokuapp.com/stories",
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
          itemcategory.postFiles = entity['postFiles'];
          itemcategory.attachmentSize = entity['attachmentSize'];
          itemcategory.createdAt = entity['createdAt'];
          itemcategory.updatedAt = entity['updatedAt'];

          storyData.add(itemcategory);
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

      // print("/// 777 " +resData.toString());
      if (resData["message"] == "success") {
        print("/// 777 " +resData.toString());
        PostData itemcategory = PostData();

        itemcategory.isActive = resData['data']['data']['isActive'];
        // print(itemcategory.isActive);
        itemcategory.reactions = resData['data']['data']['reactions']==null ? [] : resData['data']['data']['reactions'];
        itemcategory.id = resData['data']['data']['_id'];
        // itemcategory.sourceId = resData['data']['data']['sourceId'];
        itemcategory.title = resData['data']['data']['title'];
        itemcategory.description = resData['data']['data']['description'];
        itemcategory.attachmentName = resData['data']['data']['attachmentName'];
        itemcategory.postFiles = resData['data']['data']['postFiles'];
        itemcategory.attachmentSize = resData['data']['data']['attachmentSize'];
        itemcategory.createdAt = resData['data']['data']['createdAt'];
        itemcategory.updatedAt = resData['data']['data']['updatedAt'];
        itemcategory.numberOfComments = resData['data']['data']['numberOfComments'];

        postDatabyId = itemcategory;
      }
      print(postDatabyId.id);
      print("here is $token");
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> getPostBySourceId(id) async {
    final prefs = await SharedPreferences.getInstance();
    final extractdata = json.decode(prefs.getString("userData"));
    String token = extractdata["token"];
    print(id);

    print("${config.baseUrl}/posts?sourceId=$id");
    try {
      sourceIdData = [];
      final response = await http.get(
        "${config.baseUrl}/posts?sourceId=$id",
        headers: {
          "content-type": "application/json",
          "Authorization": "Bearer $token"
        },
      );
      var resData = jsonDecode(response.body);

      print("/// 777 " +resData.toString());
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
          itemcategory.postFiles = entity['postFiles'];
          itemcategory.attachmentSize = entity['attachmentSize'];
          itemcategory.createdAt = entity['createdAt'];
          itemcategory.updatedAt = entity['updatedAt'];

          sourceIdData.add(itemcategory);
        });
      }
      print('done');
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> getCommentById(id) async {
    final prefs = await SharedPreferences.getInstance();
    final extractdata = json.decode(prefs.getString("userData"));
    String token = extractdata["token"];

    print(token);
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
      if (response.statusCode==200) {
        List<dynamic> entities = resData["message"];
        entities.forEach((entity) {
          CommentData itemcategory = CommentData();

          itemcategory.id = entity['_id'];
          itemcategory.comment = entity['comment'];

          commentData.add(itemcategory);
        });

        print(commentData.length);
      }
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> creatPost(File base64Image, title, tag, description, postTo) async {
    final prefs = await SharedPreferences.getInstance();
    final extractdata = json.decode(prefs.getString("userData"));
    String token = extractdata["token"];
    print(token);
    print(title);
    print(tag.toString());
    print(description);
    print(postTo);
    // Map<String,String> headers={
    //   "Authorization":"Bearer $token",
    //   "Content-type": "multipart/form-data"
    // };
    // print(title + " " + tag + " " + description + " " + postTo);

    print(base64Image.path.split(".").last);
    try{
      print(base64Image.path);
      var request = http.MultipartRequest('POST',
          Uri.parse("https://archub.herokuapp.com/api/posts"));
      Map<String,String> headers={
      "Authorization":"Bearer $token",
      "Content-type": "multipart/form-data"
    };
    request.files.add(
        http.MultipartFile(
           'postFiles',
            base64Image.readAsBytes().asStream(),
            base64Image.lengthSync(),
            // file.readAsBytes().asStream(),
            filename: base64Image.path.split("/").last,
          contentType: MediaType('image',"${base64Image.path.split(".").last}"),
        ),
    );
    request.fields.addAll({
      "title":title,
      "description":description,
      "tag":tag,
      "postTo" : postTo.toString()
    });
      // request.files.add(
      //   await http.MultipartFile.fromPath(
      //     'postFiles', 
      //     base64Image.path,
      //   // filename: base64Image.path.split("/").last,
      //   // contentType: MediaType.parse('image/jpg'),
      //   )
      // );
      // if (image1 != null) {
      //   request.files.add(
      //       await http.MultipartFile.fromPath('other_photos', image1.path));
      // }
      // request.fields['title'] = title;
      // request.fields['description'] = description;
      // request.fields['tag'] = tag;
      // request.fields['postTo'] = postTo.toString();
      // request.fields['scale_id'] = scale_id.toString();
      // request.fields['qty'] = qty.toString();
      // request.headers.addAll({"Authorization": "Bearer $token"});
      request.headers.addAll(headers);
      print("request: "+request.toString());
      var response = await request.send();

      // print("????*******");
      var body = await response.stream.bytesToString();
      if (response.statusCode != 200) {
        print(body);
        // print("Error Uploading Product");
        throw HttpException("Error Uploading Product");
        
      }
      else{
        // print(jsonDecode(body));
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

  Future<void> followuser(id) async {
    final prefs = await SharedPreferences.getInstance();
    final extractdata = json.decode(prefs.getString("userData"));
    String token = extractdata["token"];
    print(token);
    print(id);

    try {
      final response = await http.get(
        "${config.baseUrl}/users/$id/follow",
        headers: {
          "content-type": "application/json",
          "Authorization": "Bearer $token"
        },
      );
      var resData = jsonDecode(response.body);

      print(resData);
      if (resData["message"] != "success") {
        throw HttpException(resData["message"]);
      }

      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> unfollowuser(id) async {
    final prefs = await SharedPreferences.getInstance();
    final extractdata = json.decode(prefs.getString("userData"));
    String token = extractdata["token"];
    print(token);
    print(id);

    try {
      final response = await http.get(
        "${config.baseUrl}/users/$id/unfollow",
        headers: {
          "content-type": "application/json",
          "Authorization": "Bearer $token"
        },
      );
      var resData = jsonDecode(response.body);

      print(resData);
      if (resData["message"] != "success") {
        throw HttpException(resData["message"]);
      }

      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<int> reacttoPost(react, id, reactvalue) async {
    final prefs = await SharedPreferences.getInstance();
    final extractdata = json.decode(prefs.getString("userData"));
    String token = extractdata["token"];
    print(token);
    var data = jsonEncode({
        "reactionType":react
    });

    try {
      final response = await http.post(
        "${config.baseUrl}/posts/$id/react",
        headers: {
          "content-type": "application/json",
          "Authorization": "Bearer $token"
        },
        body: data
      );
      var resData = jsonDecode(response.body);

      print(resData);
      if (resData["message"] != "success") {
        if(resData['status']=="error"){
          return reactvalue;
        }
        // throw HttpException(resData["message"]);
      }else{
        return reactvalue + 1;
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
