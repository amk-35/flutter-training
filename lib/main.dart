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
      routes: {
        '/login': (context) => const LoginView(),
        '/register': (context) => const RegisterView(),
        '/verify-email': (context) => const VerifyEamilView(),
        '/': (context) => const Home(),
      },
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
        automaticallyImplyLeading: false,
        title: const Align(
          alignment: Alignment.center,
          child: Text('Stateless vs Stateful'),
        ),
      ),
      body: RegisterView()
    );
    
  }
}

class VerifyEamilView extends StatefulWidget {
  const VerifyEamilView({super.key});

  @override
  State<VerifyEamilView> createState() => _VerifyEamilViewState();
}

class _VerifyEamilViewState extends State<VerifyEamilView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Align(
          alignment: Alignment.center,
          child: Text('Verify Email') ,  
        ),
      ),
      body: Column(
        children: [
          Text(
            'Please verify your email address',
            style: TextStyle(fontSize: 20),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () async {
              // Call the function to send verification email
              await FirebaseAuth.instance.currentUser?.sendEmailVerification();
            },
            child: Text('Send Verification Email'),
          ),
        ],
      ),
    );
  }
}

// 🏠 Home Screen combining both widgets
//i added a line in main.dart
// i added a feature in main.dart by shweeshaung