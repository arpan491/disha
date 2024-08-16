import 'package:flutter/material.dart';
 
class ReportIssueScreen extends StatelessWidget {

  static const routeName = '/report-issue';
  @override
    Widget build(BuildContext context) {
      return Scaffold(  
        appBar: AppBar(title: Text('Report An Issue'),),
        body: ListView(children: [
          ListTile(
            leading: Text('Report issue related to app'),
            trailing: IconButton(icon: Icon(Icons.chevron_right), onPressed: (){
              // Navigator.of(context).pushNamed(ReportAppIssue.routeName);
            }),
          ),
          ListTile(
            leading: Text('Report issue related to expert'),
            trailing: IconButton(icon: Icon(Icons.chevron_right), onPressed: (){
              // Navigator.of(context).pushNamed(ReportExpertIssue.routeName);
            }),
          ),
        ]),
      );
    }
  }