import 'package:chatmaxapp/providers/auth_privider.dart';
import 'package:chatmaxapp/screens/recent_chats_screen.dart';
import 'package:chatmaxapp/screens/users_screen.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  final controller = PageController();
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int index = 0;
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero).then((value){
      Provider.of<Auth>(context,listen:false).isAuth();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: ConvexAppBar(
        style: TabStyle.flip,
        color: Colors.white70,
        backgroundColor: Theme.of(context).primaryColor,
        items: [
          TabItem(icon: Icons.chat, title: "Chats"),
          TabItem(icon: Icons.people, title: "People"),
        ],
        initialActiveIndex: index,
        onTap: (int i) => setState(() {
          index = i;
          widget.controller.jumpToPage(i);
        }),
      ),
      body: PageView(
        onPageChanged: (ind) {
          setState(() {
            index = ind;
          });
        },
        controller: widget.controller,
        children: <Widget>[RecentChats(), UsersScreen()],
      ),
    );
  }
}
