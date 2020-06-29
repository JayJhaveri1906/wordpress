import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'package:soledesign/Widgets/detailPostScreen.dart';
import 'package:soledesign/Widgets/postDetailArgument.dart';
import 'package:soledesign/screens/about.dart';
import 'package:soledesign/screens/addBusiness.dart';

import 'package:soledesign/screens/favourite.dart';
import 'package:soledesign/screens/membership.dart';
import 'package:soledesign/screens/privacy.dart';
import 'package:soledesign/screens/register.dart';
import 'package:soledesign/screens/search.dart';
import 'package:soledesign/mainScreen.dart';
import 'package:soledesign/screens/logIn.dart';
import 'package:soledesign/screens/profile.dart';
import 'package:soledesign/screens/screenAfterLogin.dart';
import 'package:soledesign/screens/setting.dart';
import 'package:soledesign/screens/userAllPost.dart';

void main() {
  runApp(MyApp());
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.white, statusBarIconBrightness: Brightness.dark));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ThemeChanger>(
      builder: (_) => ThemeChanger(ThemeData.light()),
      child: new MaterialAppWithTheme(),
    );
  }
}

class MaterialAppWithTheme extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeChanger>(context);
    return MaterialApp(
        title: 'Flutter Demo',
        theme: theme.getTheme(),
        debugShowCheckedModeBanner: false,
        // Start the app with the "/" named route. In this case, the app starts
        // on the FirstScreen widget.
        initialRoute: '/',
        routes: {
          '/': (context) => MainScreen(),
          // When navigating to the "/second" route, build the SecondScreen widget.
          '/second': (context) => LogIn(),
          '/register': (context) => RegisterForm(),
          //After Successful Login
          '/sucess': (context) => ScreenAfterLogin(),
          '/profile': (context) => Profile(),
          '/search': (context) => SearchPosts(),
          '/addBusiness': (context) => AddBusiness(),
          '/settingPage': (context) => SettingPage(),

          '/about': (context) => AboutPage(),
          '/favourite': (context) => Favourite(),
          '/membership': (context) => Membership(),
          '/detailPostPage': (context) => DetailPostScreen(),
          '/privacy': (context) => PrivacyPolicy(),
          '/userPost': (context) => UserAllPost(),
//Pass Argument to Next Screen
          ExtractPostDetailArgument.routeName: (context) =>
              ExtractPostDetailArgument(),
//Pass Argument to Next Screen For Profile
          ScreenAfterLogin.routeName: (context) => ScreenAfterLogin(),
//Pass Argument to Profile Screen
          Profile.routeName: (context) => Profile(),

//Pass Argument to MemberShip Screen
          Membership.routeName: (context) => Membership(),
//Pass Argument to All User Post
          UserAllPost.routeName: (context) => UserAllPost(),
          //Pass Argument to Setting Page
          SettingPage.routeName: (context) => SettingPage(),
          //
        });
  }
}

class ThemeChanger with ChangeNotifier {
  ThemeData _themeData;

  ThemeChanger(this._themeData);

  getTheme() => _themeData;
  setTheme(ThemeData theme) {
    _themeData = theme;

    notifyListeners();
  }
}
