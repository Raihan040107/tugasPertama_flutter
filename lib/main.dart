import 'package:flutter/material.dart';
import 'user_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> jsonResponse = {
      'name': 'Budi Santoso',
      'age': 22,
    };
    final UserModel user = UserModel.fromJson(jsonResponse);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: const Text('Pertemuan 1')),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Nama     : ${user.name}', style: const TextStyle(fontSize: 20)),
              Text('ID       : "${user.id}"', style: const TextStyle(fontSize: 20)),
              Text('Email    : ${user.email}', style: const TextStyle(fontSize: 20)),
              Text('Age      : ${user.age}', style: const TextStyle(fontSize: 20)),
              Text('IsActive : ${user.isActive}', style: const TextStyle(fontSize: 20)),
              const Divider(height: 30),
              Text('toJson(): ${user.toJson()}', style: const TextStyle(fontSize: 14)),
            ],
          ),
        ),
      ),
    );
  }
}