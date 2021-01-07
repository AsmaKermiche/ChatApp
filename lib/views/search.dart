import 'package:chatapp/services/database.dart';
import 'package:chatapp/widgets/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  DatabaseMethodes _databaseMethodes = new DatabaseMethodes();
  TextEditingController SearchTextEditingController = new TextEditingController();
  QuerySnapshot SearchSnapshot;

  initiateSearch() {
    _databaseMethodes
        .getUserByUsername(
        SearchTextEditingController.text)
        .then((val) {
          setState(() {
            SearchSnapshot = val;
          });
    });
  }
  SearchList() {
    return SearchSnapshot != null ? ListView.builder(
      shrinkWrap:true,
      itemCount: SearchSnapshot.documents.length,
        itemBuilder: (context, index) {
          return SearchTile(
            userName: SearchSnapshot.documents[index].data["name"],
            email:SearchSnapshot.documents[index].data["email"],
          );
        }) : Container();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBarMain(context),
        body: Container(
          child: Column(
            children: <Widget>[
              Container(
                  color: Color(0x54FFFFFF),
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: TextField(
                          controller: SearchTextEditingController,
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.only(top: 14.0),
                            hintText: 'Search by username',
                            hintStyle: TextStyle(color: Colors.white54),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          _databaseMethodes
                              .getUserByUsername(
                              SearchTextEditingController.text)
                              .then((val) {
                            print(val.toString());
                          });
                        },
                        child: Container(
                            height: 40,
                            width: 40,
                            padding: EdgeInsets.all(12),
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    colors: [
                                      const Color(0x36FFFFFF),
                                      const Color(0x0FFFFFFF)
                                    ],
                                    begin: FractionalOffset.topLeft,
                                    end: FractionalOffset.bottomRight),
                                borderRadius: BorderRadius.circular(40)),
                            child: Image.asset(
                              'assets/search_white.png',
                              height: 25,
                              width: 25,
                            )),
                      ),
                    ],
                  ))
            ],
          ),
        ));
  }
}

class SearchTile extends StatelessWidget {
  final String userName;
  final String email;

  SearchTile({this.userName, this.email});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          Column(
            children: <Widget>[
              Text(
                userName, style: TextStyle(color: Colors.white, fontSize: 16),),
              Text(email, style: TextStyle(color: Colors.white, fontSize: 16),),

            ],
          ),
          Spacer(),
          Container(
            decoration: BoxDecoration(
                color: Colors.teal,
                borderRadius: BorderRadius.circular(30)
            ),
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text("Message"),

          )
        ],
      ),
    );
  }
}

