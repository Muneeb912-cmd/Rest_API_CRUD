import 'package:flutter/foundation.dart';

class insert_model {
  //String id;
  String title;
  String description;
  String status;

  insert_model(
    {
     // required this.id,
      required this.title,
      required this.status,
      required this.description,
    }
  );

  Map<String, dynamic> toJson() {
    return {
      //"id":id,
      "title":title,
      "description":description,
      "status":status,
    };
  }
}