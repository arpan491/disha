import 'package:flutter/material.dart';

import '../screens/book_screen.dart';

class ExpertCard extends StatelessWidget {
  String expertId;
  String userId;
  String userEmail;
  String userName;
  String expertEmail;
  String expertName;
  ExpertCard({
    required this.userId,
    required this.userName,
    required this.expertEmail,
    required this.expertId,
    required this.expertName,
    required this.userEmail,
  });
  @override
  Widget build(BuildContext context) {
    return Card(
        margin: EdgeInsets.all(16),
        elevation: 10,
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Image.asset(
                    'assets/images/user_expert.png',
                    height: 120,
                    width: 120,
                    fit: BoxFit.cover,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        expertName,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Mathematics, Physics',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black54,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Row(
                        children: [
                          Container(
                            child: Row(
                              children: [
                                Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                                Text(
                                  '4.5',
                                  style: TextStyle(
                                    color: Color.fromRGBO(35, 62, 139, 1),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            child: Row(
                              children: [
                                Icon(
                                  Icons.person,
                                  color: Colors.amber,
                                ),
                                Text(
                                  'Rated by 127 users',
                                  style: TextStyle(
                                    color: Color.fromRGBO(35, 62, 139, 1),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
                    ],
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Color.fromRGBO(35, 62, 139, 1),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.people,
                        ),
                        Text(
                          'Book offline consult',
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    onPressed: () {},
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Color.fromRGBO(169, 220, 241, 1),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.video_call_sharp,
                          color: Colors.black,
                        ),
                        Text(
                          'Book online consult',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (ctx) => BookScreen(
                            expertEmail: expertEmail,
                            expertName: expertName,
                            expertId: expertId,
                            userEmail: userEmail,
                            userName: userName,
                            userId: userId,
                          ),
                        ),
                      );
                    },
                  )
                ],
              )
            ],
          ),
        ));
  }
}
