import 'package:chatmaxapp/providers/auth_privider.dart';
import 'package:chatmaxapp/screens/chat_room.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RecentChatsListitem extends StatelessWidget {
  final fromImage;
  final message;
  final seen;
  final timeStamp;
  final toEmail;
  final toImage;
  final userEmail;

  const RecentChatsListitem(
      {this.fromImage,
      this.message,
      this.seen,
      this.timeStamp,
      this.toEmail,
      this.toImage,
      this.userEmail});
  @override
  Widget build(BuildContext context) {
    Auth auth = Provider.of<Auth>(context, listen: false);
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ChatRoom(
                    recieverEmail:
                        auth.email == userEmail ? toEmail : userEmail,
                    image: toImage == auth.imagePath ? fromImage : toImage, fullName:
                        auth.email == userEmail ? toEmail : userEmail,)));
      },
      child: Container(
        height: 85,
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: CircleAvatar(
                    backgroundColor: Theme.of(context).primaryColor,
                    backgroundImage: NetworkImage(
                        auth.imagePath == toImage ? fromImage : toImage),
                    radius: 30,
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      auth.email == toEmail ? userEmail : toEmail,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    SizedBox(height: 7),
                    SizedBox(
                      width: MediaQuery.of(context).size.width*0.45,
                      child: Text(
                        message,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 14),
                      ),
                    )
                  ],
                ),
                Expanded(child: SizedBox()),
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Text(
                          timeStamp.toString().substring(0, 10) ,
                          style: TextStyle(fontSize: 14),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(timeStamp.toString().substring(12, 16),style: TextStyle(fontSize: 14))
                      ]),
                )
              ],
            ),
            Divider()
          ],
        ),
      ),
    );
  }
}
