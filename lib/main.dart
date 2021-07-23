import 'package:flutter/material.dart';
import 'package:loja_online/models/user_models.dart';
import 'package:loja_online/screaans/home_screen.dart';
import 'package:loja_online/screaans/login_screen.dart';
import 'package:loja_online/screaans/singup_screen.dart';
import 'package:scoped_model/scoped_model.dart';


void main() async {

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScopedModel<UserModel>(
        model: UserModel(),
        child: MaterialApp(
          title: 'Flutter ',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            primaryColor: Colors.pinkAccent,
          ),
          debugShowCheckedModeBanner: false,
          home: HomeScreen(),
        ));
  }
}
