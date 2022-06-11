import 'package:biblioteca_de_fanfic/models/user_model.dart';
import 'package:biblioteca_de_fanfic/screens/home/home_page.dart';
import 'package:biblioteca_de_fanfic/screens/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModel<UserModel>(
      model: UserModel(),
      child: ScopedModelDescendant<UserModel>(builder: (context, child, model) {
        return MaterialApp(
          theme: ThemeData(
              primarySwatch: Colors.blue, primaryColor: Color(0xfff27bac)),
          debugShowCheckedModeBanner: false,
          home: model.isLoggedIn() ? HomePage() : LoginScreen(),
        );
      }),
    );
  }
}
