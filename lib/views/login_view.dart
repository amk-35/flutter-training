import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isLoading = false;               // 🔄 Loading state
  String _statusMessage = '';            // ℹ️ Message to show at bottom

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    setState(() {
      _isLoading = true;
      _statusMessage = '';
    });

    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _usernameController.text.trim(),
        password: _passwordController.text.trim(),
      );
      credential.user?.sendEmailVerification();
      setState(() {
        _statusMessage = '✅ Logged in: ${credential.user?.email ?? 'No email'}';
      });
    } catch (error, stackTrace) {
      print('Error: $error\nStackTrace: $stackTrace');
      setState(() {
        _statusMessage = '❌ Error: ${error.toString()}';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Align(
          alignment: Alignment.center,
          child: Text('Login'),
        ),
      ),
      body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const StaticQuote(),
              const SizedBox(height: 20),
              const CounterWidget(),
              const SizedBox(height: 30),
      
              TextField(
                controller: _usernameController,
                decoration: const InputDecoration(
                  labelText: "Username",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _passwordController,
                decoration: const InputDecoration(
                  labelText: "Password",
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
              ),
              const SizedBox(height: 20),
      
              _isLoading
                  ? const CircularProgressIndicator()
                  : TextButton(
                      onPressed: _login,
                      child: const Text("Login"),
                    ),
      
            TextButton(onPressed: () { 
                Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);

              },
            child: const Text("Not registered?")),
      
      
              /// Show status/info at bottom
              // Text(
              //   _statusMessage,
              //   style: TextStyle(
              //     color: _statusMessage.startsWith('✅')
              //         ? Colors.green
              //         : Colors.red,
              //     fontSize: 16,
              //   ),
              // ),
      
              // EmailVerificationChecker()
            ],
          ),
        ),
    );
  }
}


// 📘 StatelessWidget - Static quote
class StaticQuote extends StatelessWidget {
  const StaticQuote({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      '"Learning never exhausts the mind." – Leonardo da Vinci',
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 20, fontStyle: FontStyle.italic),
    );
  }
}

// 🔢 StatefulWidget - Counter with button
class CounterWidget extends StatefulWidget {
  const CounterWidget({super.key});

  @override
  State<CounterWidget> createState() => _CounterWidgetState();
}

class _CounterWidgetState extends State<CounterWidget> {
  int count = 0;

  void increment() {
    setState(() {
      count++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Button pressed $count times',
          style: const TextStyle(fontSize: 18),
        ),
        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: increment,
          child: const Text("Press Me"),
        ),
      
      ],
    );
  }
}
