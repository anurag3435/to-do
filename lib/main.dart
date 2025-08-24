import 'package:flutter/material.dart';
import 'package:to_do/pages/to_do.dart' show ToDO;

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ToDO(),
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        scaffoldBackgroundColor: Colors.grey[100],
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.indigo,
          foregroundColor: Colors.white,
          elevation: 2,
        ),
      ),
    ),
  );
}
