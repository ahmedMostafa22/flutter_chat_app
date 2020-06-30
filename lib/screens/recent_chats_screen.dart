import 'package:chatmaxapp/providers/auth_privider.dart';
import 'package:chatmaxapp/widgets/recent_chats_list_item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RecentChats extends StatefulWidget {
  @override
  _RecentChatsState createState() => _RecentChatsState();
}

class _RecentChatsState extends State<RecentChats> {
  @override
  Widget build(BuildContext context) {
    Auth auth = Provider.of<Auth>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.exit_to_app),
                onPressed: () {
                  auth.logout();
                }),
          ],
          title: Text('Recent Chats'),
          backgroundColor: Theme.of(context).primaryColor),
      body: Center(
        child: Container(
          child: Column(
            children: <Widget>[
              StreamBuilder(
                stream: Firestore.instance
                    .collection('recentMessages')
                    .orderBy('timeStamp')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(child: CircularProgressIndicator());
                  }
                  final recentChats = snapshot.data.documents.reversed;
                  List<RecentChatsListitem> recentChatWidgets = [];
                  for (var chat in recentChats) {
                    final message = chat.data['message'];
                    final userEmail = chat.data['userEmail'];
                    final seen = chat.data['seen'];
                    final timeStamp = chat.data['timeStamp'];
                    final toEmail = chat.data['toEmail'];
                    final fromImage = chat.data['fromImage'];
                    final toImage = chat.data['toImage'];
                    if(toEmail==auth.email||userEmail==auth.email)
                      recentChatWidgets.add(RecentChatsListitem(
                        message: message,
                        userEmail: userEmail,
                        seen: seen,
                        timeStamp: timeStamp,
                        toEmail: toEmail,
                        fromImage: fromImage,
                        toImage: toImage,
                      ));
                    }
                  return Expanded(
                      child: ListView(children: recentChatWidgets));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
