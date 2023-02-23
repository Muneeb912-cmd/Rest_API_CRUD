import 'dart:convert';

import 'package:api1/Models/insert_model.dart';
import 'package:api1/Models/post_model.dart';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class remort_services {
  Future<List<PostModel>?> getPosts() async {
    var client = http.Client();

    var uri = Uri.parse('https://pcc.edu.pk/ws/bscs2020/services.php');
    var response = await client.get(uri);
    if (response.statusCode == 200) {
      var json = response.body;
      return postModelFromJson(json);
    }
  }

  Future<bool> insertPosts(insert_model data) async {
    var client = http.Client();

    var uri = Uri.parse('https://pcc.edu.pk/ws/bscs2020/services.php');
    var response = await client.post(uri, body: json.encode(data.toJson()));
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> deletePosts(var id) async {
    // final http.Response response = await http.delete(
    //   Uri.parse(
    //     'https://pcc.edu.pk/ws/bscs2020/services.php',
    //   ),
    //   body: json.encode(id),
    // );
    // return response;

    print(id);
    print(json.encode(id));
    var client = http.Client();
    var uri = Uri.parse('https://pcc.edu.pk/ws/bscs2020/services.php');
    var response = await client.delete(uri, body: "{\"id\":\"$id\"}");
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> updatePosts(var id, insert_model data) async {
    String title = data.title;
    String des = data.description;
    String status = data.status;
    var client = http.Client();
    var uri = Uri.parse('https://pcc.edu.pk/ws/bscs2020/services.php');
    var response = await client.put(uri,
        body: jsonEncode(<String, String>{
          'id': id,
          'title': title,
          'description': des,
          'status': status
        }));
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
