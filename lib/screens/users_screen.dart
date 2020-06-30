import 'package:chatmaxapp/providers/auth_privider.dart';
import 'package:chatmaxapp/providers/users_provider.dart';
import 'package:chatmaxapp/widgets/users_list_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UsersScreen extends StatefulWidget {
  @override
  _UsersScreenState createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  @override
  Widget build(BuildContext context) {
    Auth auth = Provider.of<Auth>(context, listen: false);
    Users users = Provider.of<Users>(context, listen: false);
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
            title: Text('People'),
            backgroundColor: Theme.of(context).primaryColor),
        body: FutureBuilder(
            future: users.fetchAllUsers(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting)
                return Center(child: CircularProgressIndicator());
              else
                return ListView.builder(
                    itemCount: users.users.length,
                    itemBuilder: (context, i) {
                        return UsersListItem(
                          fullName: users.users[i].fullName,
                          email: users.users[i].email,
                          imagePath: users.users[i].image,
                        );
                    });
            }));
  }
}
