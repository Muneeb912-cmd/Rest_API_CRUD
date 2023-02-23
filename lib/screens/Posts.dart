import 'package:api1/screens/Edit.dart';
import 'package:api1/screens/Insert.dart';
import 'package:api1/services/remort_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../Models/post_model.dart';
import '../utils/widgets_function.dart';

class Posts extends StatefulWidget {
  const Posts({super.key});

  @override
  State<Posts> createState() => _PostsState();
}

class _PostsState extends State<Posts> {
  List<PostModel>? posts;
  var isLoaded = false;
  String id = '';

  //bool isDeleted = false;

  @override
  void initState() {
    super.initState();
    //fetching data
    getdata();
  }

  getdata() async {
    posts = await remort_services().getPosts();
    //print(posts?.length);
    if (posts != null) {
      setState(() {
        isLoaded = true;
      });
    }
  }

  deleteData(String id) {
    remort_services().deletePosts(id);
  }

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    initState();
    _refreshController.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    ScrollController scollBarController = ScrollController();
    return Scaffold(
      backgroundColor: Color.fromRGBO(99, 89, 133, 1.0),
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.add,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Insert()),
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
      body: Scrollbar(
        controller: scollBarController,
        child: Visibility(
          visible: isLoaded,
          replacement: const Center(
            child: CircularProgressIndicator(),
          ),
          child: ListView.builder(
              controller: scollBarController,
              itemCount: posts?.length,
              itemBuilder: (context, index) {
                // print(index);
                // print(posts![1]);
                const Text('Swipe right to Access Delete method');

                return Slidable(
                  // Specify a key if the Slidable is dismissible.
                  key: Key(posts![index].id),

                  // The start action pane is the one at the left or the top side.
                  startActionPane: ActionPane(
                    // A motion is a widget used to control how the pane animates.
                    motion: const ScrollMotion(),

                    // A pane can dismiss the Slidable.
                    dismissible: DismissiblePane(
                      key: Key(posts![index].id),
                      onDismissed: () {
                        deleteData(posts![index].id);
                        setState(() {
                          posts!.removeAt(index);
                        });

                        // Then show a snackbar.
                        ScaffoldMessenger.of(context)
                            .showSnackBar(SnackBar(content: Text('dismissed')));
                      },
                    ),

                    // All actions are defined in the children parameter.
                    children: const [
                      // A SlidableAction can have an icon and/or a label.
                      SlidableAction(
                        onPressed: null,
                        backgroundColor: Color.fromRGBO(99, 89, 133, 1.0),
                        foregroundColor: Colors.white,
                        icon: Icons.delete,
                        label: 'Swipe Right to Delete',
                      ),
                    ],
                  ),

                  // The end action pane is the one at the right or the bottom side.
                  endActionPane: ActionPane(
                    motion: ScrollMotion(),
                    children: [
                      SlidableAction(
                        // An action can be bigger than the others.
                        flex: 2,
                        onPressed: (context) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Edit(
                                      id: posts![index].id,
                                      title: posts![index].title,
                                      description: posts![index].description,
                                      status: posts![index].status,
                                    )),
                          );
                        },
                        backgroundColor: Color.fromRGBO(99, 89, 133, 1.0),
                        foregroundColor: Colors.white,
                        icon: Icons.edit,
                        label: 'Edit',
                      ),
                    ],
                  ),

                  // The child of the Slidable is what the user sees when the
                  // component is not dragged.

                  child: Container(
                    width: 10000,
                    height: 100,
                    child: GestureDetector(
                      onTap: () {
                        print('card tapped');
                      },
                      child: Card(
                        margin: EdgeInsets.all(10),
                        color: Color.fromRGBO(57, 48, 83, 1.0),
                        shadowColor: Colors.blueGrey,
                        elevation: 10,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              //crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(left: 25),
                                  child: RichText(
                                      text: TextSpan(
                                          style: const TextStyle(
                                            fontSize: 14.0,
                                            color: Color.fromRGBO(
                                                255, 251, 235, 3.0),
                                          ),
                                          children: <TextSpan>[
                                        const TextSpan(
                                            text: 'ID : ',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Color.fromRGBO(
                                                    248, 203, 166, 1.0))),
                                        TextSpan(
                                          text: posts?[index].id,
                                        ),
                                      ])),
                                ),
                              ],
                            ),
                            addHorizontalSpace(20),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      width: 170,
                                      child: RichText(
                                        text: TextSpan(
                                            style: const TextStyle(
                                              fontSize: 14.0,
                                              color: Color.fromRGBO(
                                                  255, 251, 235, 3.0),
                                            ),
                                            children: <TextSpan>[
                                              const TextSpan(
                                                  text: 'Title : ',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Color.fromRGBO(
                                                          248, 203, 166, 1.0))),
                                              TextSpan(
                                                  text: posts?[index].title),
                                              const TextSpan(
                                                  text: '\nDescription: ',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Color.fromRGBO(
                                                          248, 203, 166, 1.0))),
                                              TextSpan(
                                                  text: posts?[index]
                                                      .description),
                                            ]),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            addHorizontalSpace(10),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                SizedBox(
                                  width: 70,
                                  child: RichText(
                                      text: TextSpan(
                                          style: const TextStyle(
                                            fontSize: 14.0,
                                            color: Color.fromRGBO(
                                                255, 251, 235, 3.0),
                                          ),
                                          children: <TextSpan>[
                                        const TextSpan(
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Color.fromRGBO(
                                                    248, 203, 166, 1.0))),
                                        TextSpan(
                                            text: posts?[index].status,
                                            style: TextStyle(
                                                color: Color.fromRGBO(
                                                    248, 203, 166, 1.0))),
                                      ])),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }),
        ),
      ),
    );
  }
}
