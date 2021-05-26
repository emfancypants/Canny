import 'package:Canny/Services/auth_forum.dart';
import 'package:Canny/Shared/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AddDiscussion extends StatefulWidget {

  @override
  _AddDiscussionState createState() => _AddDiscussionState();
}

class _AddDiscussionState extends State<AddDiscussion> {
  String uid = FirebaseAuth.instance.currentUser.uid;
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final dbRef = FirebaseFirestore.instance.collection("Forum");
  final AuthForumService _authForum = AuthForumService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColour,
      body: Center(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget> [
                Text(
                  'Discuss in the Forum!',
                  style: TextStyle(fontSize: 23.0,
                    fontFamily: 'Lato',
                    fontWeight: FontWeight.bold,
                    color: kDeepOrange,
                  ),
                ),
                SizedBox(height: 15.0),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: TextFormField(
                    controller: nameController,
                    decoration: InputDecoration(
                      labelText: "Enter your Name",
                      prefixIcon: Icon(Icons.person),
                      filled: true,
                      fillColor: Colors.white,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(color: Colors.blue),
                      ),
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Enter your Name';
                      }
                      return null;
                      },
                  ),
                ),
                SizedBox(height: 15),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: TextFormField(
                    controller: titleController,
                    decoration: InputDecoration(
                      labelText: "Enter your Discussion Title",
                      prefixIcon: Icon(Icons.title),
                      filled: true,
                      fillColor: Colors.white,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(color: Colors.blue),
                      ),
                    ),
                    // The validator receives the text that the user has entered.
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Enter your Discussion Title';
                      }
                      return null;
                      },
                  ),
                ),
                SizedBox(height: 15),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: TextFormField(
                    controller: descriptionController,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    decoration: InputDecoration(
                      labelText: "Enter your Discussion Description",
                      prefixIcon: Icon(Icons.description_outlined),
                      filled: true,
                      fillColor: Colors.white,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(color: Colors.blue),
                      ),
                    ),
                    // The validator receives the text that the user has entered.
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Enter your Discussion Description';
                      }
                      return null;
                      },
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      ElevatedButton(
                        onPressed: () async {
                          await _authForum.addDiscussion(
                            nameController,
                            titleController,
                            descriptionController,
                            context,
                            _formKey,
                          );
                        },
                        child: Text('Submit'),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(kDeepOrangeLight),
                        )
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('Return To Homepage'),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(Colors.grey),
                        )
                      ),

                    ],
                  ),
                ),
                SizedBox(height: 10),
                Hero(
                  tag: 'picture',
                  child: Container(
                    width: 500.0,
                    height: 205.0,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(
                              'styles/images/add-discussion-illustration.png'),
                          fit: BoxFit.fill),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    titleController.dispose();
    nameController.dispose();
    descriptionController.dispose();
  }
}