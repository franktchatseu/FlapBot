import 'package:firebase_auth/firebase_auth.dart';
import 'package:flap_bot/View_Model/home_view_model.dart';
import 'package:flap_bot/View_Model/sign_in_view_model.dart';
import 'package:flap_bot/utils/locator.dart';
import 'package:flap_bot/utils/prefer.dart';
import 'package:flap_bot/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';



void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Prefs.init();
  setLocator();
  runApp(MultiProvider(child: MyApp(), providers: [
    ChangeNotifierProvider<HomeViewModel>(
      create: (_) => HomeViewModel(),
    ),
  ],));}


class MyApp extends StatefulWidget{
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale locale;
  bool localeLoaded = false;

  @override
  void initState() {
    super.initState();
    print('initState()');

    //MyApp.setLocale(context, locale);
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.grey[400],
//        statusBarColor: Styles.blueColor,
        statusBarIconBrightness:
        Brightness.light //or set color with: Color(0xFF0000FF)
    ));
    return ChangeNotifierProvider<SignInViewModel>(
      create: (_) => SignInViewModel(),
      child: Center(
        child: MaterialApp(
          initialRoute: '/',
          debugShowCheckedModeBanner: false,
          onGenerateRoute: Routes.onGenerateRoute,

          theme: ThemeData(
            primaryColor: Color(0xFF37474f),
            indicatorColor: Colors.white,
            primaryColorDark: Color(0xFFff9800),
            accentColor: Color(0xFFffd95b),
            primaryIconTheme: IconThemeData(
              color: Colors.white,
            ),
            textTheme: TextTheme(
              title: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
