import 'package:flutter/material.dart';
import 'home.dart';
import 'view.dart';

void main() => runApp(Movies());

class Movies extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        initialRoute: Home.id,
        routes: {
        Home.id: (context) => Home(),
        View.id: (context) => View(),
        },
    );
  }
}
