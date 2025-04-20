import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user.dart';
import 'auth_screen.dart';
import 'dart:convert';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  User? _user;

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  _loadUser() async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = prefs.getString('user');

    if (userJson != null) {
      Map<String, dynamic> userMap = jsonDecode(userJson);
      setState(() {
        _user = User.fromJson(userMap);
      });
      print('User object: $_user');
    }
  }

  _logout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('user');
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const AuthScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => _logout(context),
          ),
        ],
      ),
      body: Center(
        child:
            _user == null
                ? const Text('No user data found.')
                : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Name: ${_user!.name}'),
                    Text('Email: ${_user!.email}'),
                  ],
                ),
      ),
    );
  }
}
