import 'package:e_shop/provider/state.provider.dart';
import 'package:e_shop/respository/api.repository.dart';
import 'package:e_shop/screen/home.screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<StateProvider>(create: (ctx) => 
        StateProvider(ApiRepository()))
      ],
      child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
           
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: HomeScreen(),
        ),
    );
  }
}
