import 'package:chatmaxapp/providers/auth_privider.dart';
import 'package:chatmaxapp/widgets/message_bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants.dart';

class ChatRoom extends StatefulWidget {
  final recieverEmail;
  final image ; 
  final fullName;
  ChatRoom({this.recieverEmail, this.image, this.fullName});
  @override
  _ChatRoomState createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  String message;
  String chatId;
  var textFieldController = new TextEditingController();
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Auth auth = Provider.of<Auth>(context, listen: false);
    widget.recieverEmail.toString().compareTo(auth.email.toString()) > 0
        ? chatId = widget.recieverEmail + auth.email
        : chatId = auth.email + widget.recieverEmail;
  }

  @override
  Widget build(BuildContext context) {
    Auth auth = Provider.of<Auth>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
          title: Row(children: <Widget>[
        Container(
            margin: EdgeInsets.all(10),
            child: CircleAvatar(
              backgroundImage: NetworkImage(widget.image),
            )),
        Text(widget.fullName)
      ])),
      body: Container(
        child: Column(
          children: <Widget>[
            StreamBuilder(
              stream: Firestore.instance
                  .collection('chats/$chatId/messages')
                  .orderBy('timeStamp')
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                }
                final messages = snapshot.data.documents.reversed;
                List<MessageBubble> messageWidgets = [];
                for (var message in messages) {
                  final text = message.data['message'];
                  final sender = message.data['userEmail'];
                  final seen = message.data['seen'];
                  final timeStamp = message.data['timeStamp'];
                  if (sender == auth.email) {
                    messageWidgets.add(MessageBubble(
                      message: text,
                      sender: sender,
                      timeStamp: timeStamp,
                      seen: seen,
                      color: Theme.of(context).primaryColor,
                    ));
                  } else {
                    print(timeStamp);
                    messageWidgets.add(MessageBubble(
                        message: text,
                        sender: sender,
                        timeStamp: timeStamp,
                        seen: '1',
                        color: Colors.white));
                    Firestore.instance
                        .collection("chats/$chatId/messages")
                        .document(timeStamp)
                        .updateData({'seen': '1'});
                  }
                }
                return Expanded(
                    child: ListView(reverse: true, children: messageWidgets));
              },
            ),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: textFieldController,
                      onChanged: (value) {
                        message = value;
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  FlatButton(
                    onPressed: () {
                      textFieldController.clear();
                      String time = new DateTime.now().toIso8601String();
                      Firestore.instance
                          .collection("chats/$chatId/messages")
                          .document(time)
                          .setData({
                        'message': message,
                        'userEmail': auth.email,
                        'toEmail': widget.recieverEmail,
                        'timeStamp': time,
                        'seen': '0'
                      });
                      Firestore.instance
                          .collection("recentMessages").document(chatId)
                          .setData({
                        'message': message,
                        'userEmail': auth.email,
                        'toEmail': widget.recieverEmail,
                        'toImage':widget.image,
                        'fromImage':auth.imagePath,
                        'timeStamp': time,
                        'seen': '0'
                      });
                    },
                    child: Icon(
                      Icons.send,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
