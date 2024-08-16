import 'package:disha/screens/expert_list.dart';
import 'package:disha/screens/expert_search_screen.dart';
import 'package:disha/screens/forum_screen.dart';
import 'package:disha/widgets/new_forum_screen.dart';
import 'package:flutter/material.dart';

import '../screens/book_screen.dart';
import '../screens/chat_screen.dart';
import './dashboard_card.dart';

class DashboardGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView(
        children: [
          DashboardCard('assets/images/ask_query.png', 'Ask a query', () {
            Navigator.of(context).pushNamed(ExpertSearchScreen.routeName);
          }),
          DashboardCard('assets/images/talk_to_expert.png', 'Talk to Expert',
              () {
            Navigator.of(context).pushNamed(ChatScreen.routeName);
          }),
          DashboardCard('assets/images/connect_offline.png', 'Connect Offline',
              () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (ctx) => ExpertListScreen(),
              ),
            );
          }),
          DashboardCard('assets/images/app_guide.png', 'Chat Forum', () {
            Navigator.of(context).pushNamed(ForumScreen.routeName);
          }),
        ],
        padding: const EdgeInsets.symmetric(
          vertical: 50,
          horizontal: 30,
        ),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1 / 1,
          crossAxisSpacing: 30,
          mainAxisSpacing: 30,
        ),
      ),
    );
  }
}
