import 'package:flutter/material.dart';

import '../screens/chat_screen.dart';

class DashboardCard extends StatelessWidget {
  final String title;
  final String imagePath;
  final VoidCallback onTap;
  DashboardCard(this.imagePath, this.title, this.onTap);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(38),
      child: GestureDetector(
        onTap: onTap,
        child: Card(
          elevation: 20,
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  imagePath,
                  height: 100,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(title),
              ],
            ),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  const Color.fromRGBO(169, 220, 241, 1),
                  const Color.fromRGBO(174, 226, 213, 1)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
