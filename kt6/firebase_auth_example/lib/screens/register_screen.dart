import 'package:flutter/material.dart';
import 'package:firebase_auth_example/auth_service1.dart';
import 'package:firebase_auth_example/screens/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final AuthService _auth = AuthService();
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Register')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(labelText: 'Email'),
              keyboardType: TextInputType.emailAddress,
              onChanged: (val) {
                setState(() => email = val);
              },
            ),
            const SizedBox(height: 20),
            TextField(
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
              onChanged: (val) {
                setState(() => password = val);
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                setState(() {
                  error = '';
                });
                try {
                  final user = await _auth.register(email, password);
                  if (user == null) {
                    setState(() {
                      error = 'Could not register with those credentials';
                    });
                  } else {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => HomeScreen()),
                    );
                  }
                } on FirebaseAuthException catch (e) {
                  print('Firebase Auth error code: ${e.code}');
                  print('Firebase Auth error message: ${e.message}');
                  setState(() {
                    error = 'Registration failed: ${e.message}';
                  });
                } catch (e) {
                  print('Generic error: $e');
                  setState(() {
                    error = 'An unexpected error occurred: ${e.toString()}';
                  });
                }
              },
              child: const Text('Register'),
            ),
            const SizedBox(height: 10),
            Text(error, style: const TextStyle(color: Colors.red)),
          ],
        ),
      ),
    );
  }
}
