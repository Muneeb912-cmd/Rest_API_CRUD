// ignore_for_file: prefer_const_constructors

import 'package:auto_size_text/auto_size_text.dart';
import 'package:api1/Models/insert_model.dart';
import 'package:api1/services/remort_services.dart';
import 'package:api1/utils/constants.dart';
import 'package:api1/utils/widgets_function.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import 'Posts.dart';

class Insert extends StatefulWidget {
  const Insert({super.key});

  @override
  State<Insert> createState() => _Insert();
}

class _Insert extends State<Insert> {
  final Title = TextEditingController();
  final Description = TextEditingController();
  int _selectedOption = 0;
  bool inserted = false;
  //final ID = TextEditingController();

  @override
  void initState() {
    super.initState();
    _selectedOption = 0;
  }

  getStatus() {
    if (_selectedOption == 1) {
      return 'Active';
    } else {
      return 'InActive';
    }
  }

  process() {
    try {
      insertData();
      return;
    } catch (e) {
      inserted = false;
      return;
    }
  }

  insertData() async {
    if (Title.text != '' && Description.text != '' && _selectedOption != 0) {
      insert_model im = insert_model(
          //id: ID.text,
          title: Title.text,
          status: getStatus(),
          description: Description.text);
      inserted = true;
      await remort_services().insertPosts(im);
      return;
    }
    inserted = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(99, 89, 133, 1.0),
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.arrow_left_rounded,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Posts()),
              );
            },
          ),
          centerTitle: true,
          title: const Text(
            'CRUD Application',
            style: TextStyle(color: Color.fromRGBO(255, 254, 251, 0.992)),
          ),
          backgroundColor: Color.fromRGBO(68, 60, 104, 1.0),
        ),
        body: Padding(
          padding: EdgeInsets.all(50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: SizedBox(
                      height: 100,
                      width: 200,
                      child: AutoSizeText(
                        'Insert Data',
                        style: TEXT_THEME_DEFAULT.headline1,
                        minFontSize: 10,
                        stepGranularity: 5.0,
                      ),
                    ),
                  )
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  TextField(
                    controller: Title,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.title,
                          color: Color.fromRGBO(68, 60, 104, 1.0)),
                      fillColor: COLOR_GREY,
                      filled: true,
                      hintText: 'Title',
                      hintStyle: TEXT_THEME_SMALL.bodyText2,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                ],
              ),
              addVerticalSpace(30),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  TextField(
                    controller: Description,
                    keyboardType: TextInputType.multiline,
                    maxLines: 5,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.description,
                          color: Color.fromRGBO(68, 60, 104, 1.0)),
                      fillColor: COLOR_GREY,
                      filled: true,
                      hintText: 'Enter the description here...',
                      hintStyle: TEXT_THEME_SMALL.bodyText2,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                ],
              ),
              Row(mainAxisAlignment: MainAxisAlignment.start, children: []),
              addVerticalSpace(50),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Radio(
                    value: 1,
                    groupValue: _selectedOption,
                    onChanged: (value) {
                      setState(() {
                        _selectedOption = 1;
                      });
                    },
                  ),
                  Text('Active', style: TextStyle(color: Colors.white)),
                  SizedBox(
                    width: 50,
                  ),
                  Radio(
                    value: 2,
                    groupValue: _selectedOption,
                    onChanged: (value) {
                      setState(() {
                        _selectedOption = 2;
                      });
                    }, // Make the radio button inactive
                  ),
                  Text('Inactive', style: TextStyle(color: Colors.white)),
                ],
              ),
              addVerticalSpace(50),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  OutlinedButton.icon(
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.white,
                        fixedSize: const Size(120, 50),
                        backgroundColor: Colors.cyan,
                      ),
                      onPressed: () {
                        process();
                        if (inserted == true) {
                          //ID.text = '';
                          Title.text = '';
                          Description.text = '';
                          _selectedOption = 0;
                          showDialog<String>(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              title: const Text('Successfull!'),
                              content: const Text(
                                  'Data inserted with no problems :) !'),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () => Navigator.pop(context, 'OK'),
                                  child: const Text('OK'),
                                ),
                              ],
                            ),
                          );
                        } else {
                          showDialog<String>(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              title: const Text('Error'),
                              content: const Text(
                                  'Input Missing! Please fill all the input boxes'),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () =>
                                      Navigator.pop(context, 'Cancel'),
                                  child: const Text('Cancel'),
                                ),
                                TextButton(
                                  onPressed: () => Navigator.pop(context, 'OK'),
                                  child: const Text('OK'),
                                ),
                              ],
                            ),
                          );
                        }
                      },
                      icon: Icon(
                        Icons.save,
                        color: Colors.white,
                      ),
                      label: Text(
                        'Save',
                        style: TEXT_THEME_DEFAULT.bodyText1,
                      )),
                ],
              ),
            ],
          ),
        ));
  }
}
