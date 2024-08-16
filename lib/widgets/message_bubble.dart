import 'dart:math';

import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final String message;
  final bool isMe;
  final Key key;

  MessageBubble(this.message, this.isMe, {required this.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 5),
      child: Row(
        mainAxisAlignment:
        isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(8),
            margin: EdgeInsets.all(10),
            
            width: min((message.length*6.0 + 50.0), 250.0),

            decoration: BoxDecoration(
              color: isMe?Theme.of(context).backgroundColor:Colors.grey,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
                bottomLeft: isMe?Radius.circular(12):Radius.circular(0),
                bottomRight: isMe?Radius.circular(0):Radius.circular(12),
              ),
            ),
            child: Text(message,
                style: TextStyle(
                  color: Colors.white,
                )),
          ),
        ],
      ),
    );
  }
}
