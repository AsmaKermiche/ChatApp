import 'package:chatapp/views/search.dart';
import 'package:chatapp/widgets/widgets.dart';
import 'package:flutter/material.dart';
class ChatRoom extends StatefulWidget {
  @override
  _ChatRoomState createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset('assets/logo.png',
          height:40,),
        elevation:0,
        centerTitle:false,
        actions: <Widget>[
          Container(padding: EdgeInsets.only(right: 16),child:Icon(Icons.exit_to_app)),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.search),
        onPressed:(){Navigator.push(context, MaterialPageRoute(builder: (context) => SearchScreen()));} ,

      ),
    );
  }
}
