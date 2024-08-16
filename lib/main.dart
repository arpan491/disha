import 'package:disha/screens/book_screen.dart';
import 'package:disha/screens/chat_screen.dart';
import 'package:disha/screens/account_settings_screen.dart';
import 'package:disha/screens/confirm_email_screen.dart';
import 'package:disha/screens/expert_list.dart';
import 'package:disha/screens/expert_search_screen.dart';
import 'package:disha/screens/language_screen.dart';
import 'package:disha/screens/profile_settings_screen.dart';
import 'package:disha/screens/report_issue_screen.dart';
import 'package:disha/screens/verify_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:splashscreen/splashscreen.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import './screens/auth_screen.dart';
import './screens/home_screen.dart';
import './screens/forum_screen.dart';
import './LanguageChangeProvider.dart';
import 'generated/l10n.dart';

// const AndroidNotificationChannel channel = AndroidNotificationChannel(
//     'high_importance_channel', // id
//     'High Importance Notifications', // title // description
//     importance: Importance.high,
//     playSound: true);

// final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//     FlutterLocalNotificationsPlugin();

// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   await Firebase.initializeApp();
//   print('A bg message just showed up :  ${message.messageId}');
// }

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Future<FirebaseApp> _initialization = Firebase.initializeApp();
    return FutureBuilder(
        future: _initialization,
        builder: (context, appSnapshot) {
          return appSnapshot.connectionState != ConnectionState.done
              ? const Center(child: CircularProgressIndicator())
              : ChangeNotifierProvider<LanguageChangeProvider>(
                  create: (context) => LanguageChangeProvider(),
                  child: Builder(builder: (context) {
                    return MaterialApp(
                      locale: Provider.of<LanguageChangeProvider>(context,
                              listen: true)
                          .currentLocale,
                      localizationsDelegates: [
                        S.delegate,
                        GlobalMaterialLocalizations.delegate,
                        GlobalWidgetsLocalizations.delegate,
                        GlobalCupertinoLocalizations.delegate,
                      ],
                      supportedLocales: S.delegate.supportedLocales,
                      theme: ThemeData(
                        buttonColor: const Color.fromRGBO(30, 174, 152, 1),
                        backgroundColor: Color.fromRGBO(35, 62, 139, 1),
                        secondaryHeaderColor:
                            const Color.fromRGBO(169, 220, 241, 1),
                        primaryColor: Colors.white,
                      ),
                      home: StreamBuilder(
                        stream: FirebaseAuth.instance.authStateChanges(),
                        builder: (ctx, userSnapshot) {
                          if (userSnapshot.hasData) {
                            return HomeScreen();
                          } else {
                            return AuthScreen();
                          }
                        },
                      ),
                      routes: {
                        AuthScreen.routeName: (ctx) => AuthScreen(),
                        ChatScreen.routeName: (ctx) => ChatScreen(),
                        ConfirmEmailScreen.routeName: (ctx) =>
                            ConfirmEmailScreen(),
                        AccountSettingsScreen.routeName: (ctx) =>
                            AccountSettingsScreen(),
                        ProfileSettingsScreen.routeName: (ctx) =>
                            ProfileSettingsScreen(),
                        LanguageScreen.routeName: (ctx) => LanguageScreen(),
                        ReportIssueScreen.routeName: (ctx) =>
                            ReportIssueScreen(),
                        ForumScreen.routeName: (ctx) => ForumScreen(),
                        ExpertSearchScreen.routeName: (ctx)=>ExpertSearchScreen(),
                        ExpertListScreen.routeName: (ctx)=>ExpertListScreen(),
                        
                      },
                    );
                  }),
                );
        });
  }
}
