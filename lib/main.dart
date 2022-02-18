import 'package:flutter/material.dart';

import 'package:products_app/pages/pages.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      debugShowCheckedModeBanner: false,
      initialRoute: LoginPage.routerName,
      routes: {
        HomePage.routerName  : ( _ ) => const HomePage(),
        LoginPage.routerName : ( _ ) => const LoginPage()
      },
      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: Colors.grey[300]
      ),
    );
  }
}