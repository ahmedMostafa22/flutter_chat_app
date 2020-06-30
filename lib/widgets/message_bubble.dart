import 'package:chatmaxapp/providers/auth_privider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MessageBubble extends StatelessWidget {
  final message;
  final sender;
  final seen;
  final timeStamp;
  final Color color;

  const MessageBubble(
      {this.message, this.sender, this.color, this.seen, this.timeStamp});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(6.0),
        child: Row(
          children: <Widget>[
            Visibility(
                visible:
                    sender == Provider.of<Auth>(context, listen: false).email,
                child: Expanded(child: SizedBox())),
            Expanded(
                          child: Material(
                elevation: 2.0,
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                color: color,
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(3.0),
                        child: Text(
                          message,
                          style: TextStyle(
                            color: color == Theme.of(context).primaryColor
                                ? Colors.white
                                : Colors.black,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Row(
                          children: <Widget>[
                            Text(
                              timeStamp.toString().substring(11, 16),
                              style: TextStyle(
                                  color: color == Colors.white
                                      ? Colors.black
                                      : Colors.white),
                            ),
                            Expanded(
                                                          child: SizedBox(
                                width: 20,
                              ),
                            ),
                            Icon(
                                seen == '0'
                                    ? Icons.check_circle_outline
                                    : Icons.check_circle,
                                color: Colors.white,
                                size: 15)
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Visibility(
                visible:
                    sender != Provider.of<Auth>(context, listen: false).email,
                child: Expanded(child: SizedBox())),
          ],
        ));
  }
}
