import 'package:Canny/Screens/Forum/forum_detail_screen.dart';
import 'package:Canny/Screens/Sidebar/sidebar_menu.dart';
import 'package:Canny/Services/Forum/auth_forum.dart';
import 'package:Canny/Shared/colors.dart';
import 'package:Canny/Shared/loading.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

import '../../Services/Forum/add_discussion.dart';

class ForumScreen extends StatefulWidget {
  static final String id = 'forum_screen';

  @override
  _ForumScreenState createState() => _ForumScreenState();
}

class _ForumScreenState extends State<ForumScreen> {
  final String uid = FirebaseAuth.instance.currentUser.uid;
  final AuthForumService _authForum = AuthForumService();
  final dbRef = FirebaseFirestore.instance.collection("Forum");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColour,
      appBar: AppBar(
        backgroundColor: kDeepOrangePrimary,
        title: Text(
          "FORUM",
          style: TextStyle(fontFamily: 'Lato'),
        ),
        actions: <Widget> [
          IconButton(
            icon: Icon(Icons.add_circle_outline_sharp),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AddDiscussion()));
            },
          )
        ],
      ),
      drawer: SideBarMenu(),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            color: kBackgroundColour,
            child: Column(
              children: <Widget>[
                StreamBuilder(
                  stream: dbRef
                      .orderBy("timestamp", descending: true)
                      .snapshots(),
                  builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasData) {
                      return Align(
                        alignment: Alignment.topCenter,
                        child: ListView.builder(
                          padding: EdgeInsets.all(10),
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: snapshot.data.docs.length,
                          itemBuilder: (BuildContext context, int index) {
                            final nameInputController = TextEditingController(text: snapshot.data.docs[index]["name"]);
                            final titleInputController = TextEditingController(text: snapshot.data.docs[index]["title"]);
                            final descriptionInputController = TextEditingController(text: snapshot.data.docs[index]["description"]);
                            int noOfLikes = snapshot.data.docs[index]["likes"];
                            int noOfComments = snapshot.data.docs[index]["comments"];
                            final snapshotData = snapshot.data.docs[index];
                            return Padding(
                              padding: EdgeInsets.only(bottom: 4.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    child: Card(
                                      elevation: 4,
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(Radius.circular(12.0))),
                                      child: Column(
                                        children: <Widget>[
                                          ListTile(
                                              contentPadding: EdgeInsets.all(18.0),
                                              title: Text(
                                                snapshotData["title"],
                                                style: TextStyle(
                                                  fontSize: 20,
                                                ),
                                              ),
                                              subtitle: Text(
                                                  snapshotData["description"].length > 200
                                                      ? snapshotData["description"].substring(0, 200) + "..."
                                                      : snapshotData["description"],
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                  )
                                              ),
                                              leading: CircleAvatar(
                                                backgroundColor: kDeepOrangePrimary,
                                                radius: 30,
                                                child: Text(
                                                  snapshotData["name"][0],
                                                  style: TextStyle(
                                                    fontSize: 23,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              )
                                          ),
                                          Padding(
                                            padding: EdgeInsets.fromLTRB(20.0, 0, 20.0, 10.0),
                                            child: Row(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: <Widget>[
                                                Text("By: ${snapshotData["name"]}",
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.grey[850],
                                                  )
                                                ),
                                                Text(DateFormat("EEEE, d MMMM y")
                                                    .format(DateTime.fromMillisecondsSinceEpoch(
                                                    snapshotData["timestamp"].seconds * 1000)),
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.grey[850],
                                                    )
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(left: 8.0, right: 8.0),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: <Widget>[
                                                Align(
                                                  alignment: Alignment.centerLeft,
                                                  child: Row(
                                                    children: <Widget> [
                                                      IconButton(
                                                        icon: Icon(
                                                            snapshotData["liked_uid"].contains(uid)
                                                                ? Icons.favorite
                                                                : Icons.favorite_border,
                                                            color: snapshotData["liked_uid"].contains(uid)
                                                                ? Colors.red
                                                                : Colors.black),
                                                        onPressed: () {
                                                          if (snapshotData["liked_uid"].contains(uid)) {
                                                            setState(() {
                                                              dbRef.doc(snapshotData.id)
                                                                  .update({
                                                                "likes": noOfLikes -= 1,
                                                                "liked_uid": FieldValue.arrayRemove([uid]),
                                                              }).catchError((error) => print(error));
                                                            });
                                                          } else {
                                                            setState(() {
                                                              dbRef.doc(snapshotData.id)
                                                                  .update({
                                                                "likes": noOfLikes += 1,
                                                                "liked_uid": FieldValue.arrayUnion([uid]),
                                                              }).catchError((error) => print(error));
                                                            });
                                                          }
                                                        },
                                                      ),
                                                      IconButton(
                                                        icon: Icon(Icons.add_comment_outlined),
                                                        onPressed: () {
                                                          Navigator.push(context,
                                                              MaterialPageRoute(builder: (context) =>
                                                                  ForumDetailScreen(inputId: snapshotData.id)));
                                                        },
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Align(
                                                  alignment: Alignment.centerRight,
                                                  child: Row(
                                                      children: <Widget> [
                                                        if (snapshotData["uid"] == uid)
                                                          IconButton(
                                                            icon:
                                                            Icon(FontAwesomeIcons.edit),
                                                            onPressed: () async {
                                                              await _authForum.updateDiscussion(
                                                                  nameInputController,
                                                                  titleInputController,
                                                                  descriptionInputController,
                                                                  context,
                                                                  snapshot,
                                                                  index);
                                                            },
                                                          ),
                                                        SizedBox(width: 8.0),
                                                        if (snapshotData["uid"] == uid)
                                                          IconButton(
                                                            icon: Icon(
                                                                FontAwesomeIcons.trashAlt),
                                                            onPressed: () {
                                                              showDialog(
                                                                context: context,
                                                                builder:
                                                                    (BuildContext context) {
                                                                  return AlertDialog(
                                                                    title: Text("Are you sure you want to delete your discussion"),
                                                                    content: Text("Once your discussion is deleted, you will not be able to retrieve it back."),
                                                                    actions: <Widget>[
                                                                      // usually buttons at the bottom of the dialog
                                                                      TextButton(
                                                                        child: Text("Yes"),
                                                                        onPressed: () async {
                                                                          await _authForum.removeDiscussion(
                                                                            snapshotData.id,
                                                                          );
                                                                          setState(() {
                                                                            snapshot.data.docs.removeAt(index);
                                                                          });
                                                                          Navigator.pop(context);
                                                                        },
                                                                      ),
                                                                      TextButton(
                                                                        child: Text("No"),
                                                                        onPressed: () {
                                                                          Navigator.pop(context);
                                                                        },
                                                                      ),
                                                                    ],
                                                                  );
                                                                },
                                                              );
                                                            },
                                                          ),
                                                      ]
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 8.0),
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children: <Widget> [
                                                  SizedBox(width: 20),
                                                  Text(
                                                    noOfLikes.toString(),
                                                    style: TextStyle(
                                                      fontSize: 15,
                                                    ),
                                                  ),
                                                  SizedBox(width: 40.5),
                                                  Text(
                                                    noOfComments.toString(),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      );
                    }
                    return CircularProgressIndicator();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
