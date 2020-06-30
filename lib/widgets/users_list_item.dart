import 'package:chatmaxapp/providers/auth_privider.dart';
import 'package:chatmaxapp/screens/chat_room.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UsersListItem extends StatelessWidget {
  final imagePath ; 
  final fullName ; 
  final email ;
 UsersListItem({this.imagePath, this.fullName, this.email}); 
  
  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: email!=Provider.of<Auth>(context).email,
          child: GestureDetector(
            onTap: (){
              Navigator.push(context,MaterialPageRoute(builder: (context)=>ChatRoom(recieverEmail: email, image:imagePath,fullName:fullName))) ;
            },
            child: Container(
              child: Column(
          children: <Widget>[
              Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircleAvatar(
                      backgroundColor: Theme.of(context).primaryColor,
                      backgroundImage: NetworkImage(imagePath),
                      radius: 25,
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        fullName,
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      Text(
                        email,
                        style: TextStyle( fontSize: 16),
                      ),
                    ],
                  ),
                  Expanded(child: SizedBox()),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Icon(Icons.message,
                    color: Theme.of(context).primaryColor,),
                  )
                ],
              ),
              Divider()
          ],
        ),
            ),
      ),
    );
  }
}
