import 'package:disha/widgets/carousel_window.dart';
import 'package:flutter/material.dart';

import '../widgets/app_drawer.dart';
import '../widgets/bottom_nav_bar.dart';
import '../widgets/dashboard_grid.dart';

class HomeScreen extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Disha', style: TextStyle(fontFamily: 'Amita'),),
        backgroundColor: Theme.of(context).backgroundColor,
      ),
      drawer: AppDrawer(),
      body: Column(
        children: [
          CarouselWindow(),
          DashboardGrid(),
        ],
      ),
      bottomNavigationBar: BottomNavBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(child: Icon(Icons.question_mark),onPressed: (){},),
    );
  }
}
