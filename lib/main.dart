import 'package:brew_crew/models/my_user.dart';
import 'package:brew_crew/screens/wrapper.dart';
import 'package:brew_crew/services/auth.dart';
import 'package:flutter/material.dart';
// #######################################################
import 'package:firebase_core/firebase_core.dart';
// #######################################################
import 'package:provider/provider.dart';

void main() async{
  // #######################################################
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
        apiKey: 'AIzaSyAOAT1KWVVejk2qKi09KY7wtOMMA1ao9Kg',
        appId: '1:316325650327:android:72ace7ae56878ba22aeed2',
        messagingSenderId: '316325650327',
        projectId: 'michael-brew-crew-42e9e'
    ) ,
  );
  // #######################################################
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<MyUser?>.value(
      value: AuthService().user,
      initialData: null,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Wrapper(),
      ),
    );
  }
}