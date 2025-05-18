import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:testt/views/login_view.dart';
import 'package:testt/views/register_view.dart';

FirebaseAnalytics analytics = FirebaseAnalytics.instance;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // this initializes Firebase
  runApp(MyApp());
}

// 🌟 Root of the app
class MyApp extends StatelessWidget {
  const MyApp({super.key}); 

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorObservers: [
        FirebaseAnalyticsObserver(analytics: analytics),
      ],
      title: 'Stateless vs Stateful',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Home(),
    );
  }
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {

          print(FirebaseAuth.instance.currentUser);

    return Scaffold(
       appBar: AppBar(
        title: const Align(
          alignment: Alignment.center,
          child: Text('Stateless vs Stateful'),
        ),
      ),
      body: Center(child: Text("test")),
    );
    
  }
}



// 🏠 Home Screen combining both widgets
