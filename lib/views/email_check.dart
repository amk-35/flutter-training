import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class EmailVerificationChecker extends StatefulWidget {
  const EmailVerificationChecker({super.key});

  @override
  State<EmailVerificationChecker> createState() => _EmailVerificationCheckerState();
}

class _EmailVerificationCheckerState extends State<EmailVerificationChecker> {
  bool? isVerified;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    // checkVerificationStatus();
  }

  Future<void> checkVerificationStatus() async {
    setState(() => isLoading = true);

    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      await user.reload(); // Refresh user data from Firebase
      user = FirebaseAuth.instance.currentUser; // Get updated user
      setState(() {
        isVerified = user?.emailVerified;
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          isVerified == true
              ? '✅ Email is verified.'
              : '❌ Email is NOT verified.',
          style: const TextStyle(fontSize: 18),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: checkVerificationStatus,
          child: const Text('Check Again'),
        ),
      ],
    );
  }
}
