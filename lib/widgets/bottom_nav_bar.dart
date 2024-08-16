import 'package:flutter/material.dart';
 
class BottomNavBar extends StatelessWidget {
  @override
    Widget build(BuildContext context) {
      return BottomNavigationBar(
        // fixedColor: Colors.black54,
        backgroundColor: Theme.of(context).primaryColor,
        // currentIndex: 1,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.black54,
        unselectedItemColor: Colors.black54,
        unselectedLabelStyle: TextStyle(color: Colors.black54),
        items: [
          const BottomNavigationBarItem(
            icon: Icon(Icons.home,),
            label: '',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.people),
            
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Container(),
            label: '',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble),
            
            label: '',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: '',
          ),
        ],
 
      );
    }
  }