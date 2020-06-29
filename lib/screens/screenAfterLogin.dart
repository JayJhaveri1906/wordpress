import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:soledesign/Widgets/featuredPost.dart';
import 'package:soledesign/Widgets/pickForYou.dart';
import 'package:soledesign/Widgets/trendingPost.dart';
import 'package:soledesign/models/jsonUser.dart';
import 'package:soledesign/screens/membership.dart';
import 'package:soledesign/screens/profile.dart';
import 'package:soledesign/screens/setting.dart';

class ScreenAfterLogin extends StatefulWidget {
  static const routeName = '/extractLoginArguments';

  @override
  _ScreenAfterLoginState createState() => _ScreenAfterLoginState();
}

class _ScreenAfterLoginState extends State<ScreenAfterLogin> {
  SharedPreferences sharedPreferences;
  String avatar;

  @override
  void initState() {
    super.initState();
    checkLoginStatus();
  }

  checkLoginStatus() async {
    sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.getString("token") == null) {
      Navigator.of(context)
          .pushNamedAndRemoveUntil('/second', (Route<dynamic> route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final JsonUser args = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      drawer: Theme(
        data: Theme.of(context).copyWith(
            // canvasColor:
            //     Colors.white, //This will change the drawer background to blue.
            //other styles
            ),
        child: Drawer(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                DrawerHeader(
                  decoration: BoxDecoration(color: Colors.white),
                  child: Image.asset(
                    'assets/IMG_2382.PNG',
                  ),
                ),
                Column(
                  children: <Widget>[
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 1 / 10,
                    ),
                    ListTile(
                      leading: Icon(Icons.dashboard),
                      title: Text('Dashbord'),
                      trailing: Icon(Icons.arrow_forward_ios),
                      onTap: () {
                        Navigator.pushNamed(context, ScreenAfterLogin.routeName,
                            arguments: JsonUser(
                                avatar: args.avatar,
                                userDisplayName: args.userDisplayName,
                                userId: args.userId,
                                token: args.token,
                                userEmail: args.userEmail,
                                userNicename: args.userNicename,
                                userRole: args.userRole));
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.comment),
                      title: Text('Categories'),
                      trailing: Icon(Icons.arrow_forward_ios),
                      onTap: () {
                        Navigator.of(context).pushNamed('/search');
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.category),
                      title: Text('About us'),
                      trailing: Icon(Icons.arrow_forward_ios),
                      onTap: () {
                        Navigator.of(context).pushNamed('/about');
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.favorite),
                      title: Text('Favourite'),
                      trailing: Icon(Icons.arrow_forward_ios),
                      onTap: () {
                        Navigator.of(context).pushNamed('/favourite');
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.shopping_basket),
                      title: Text('Membership'),
                      trailing: Icon(Icons.arrow_forward_ios),
                      onTap: () {
                        Navigator.pushNamed(context, Membership.routeName,
                            arguments: JsonUser(
                                avatar: args.avatar,
                                userDisplayName: args.userDisplayName,
                                userId: args.userId,
                                token: args.token,
                                userEmail: args.userEmail,
                                userNicename: args.userNicename,
                                userRole: args.userRole));
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.person),
                      title: Text('My Profile'),
                      trailing: Icon(Icons.arrow_forward_ios),
                      onTap: () {
                        Navigator.pushNamed(context, Profile.routeName,
                            arguments: JsonUser(
                                avatar: args.avatar,
                                userDisplayName: args.userDisplayName,
                                userId: args.userId,
                                token: args.token,
                                userEmail: args.userEmail,
                                userNicename: args.userNicename,
                                userRole: args.userRole));
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.exit_to_app),
                      title: Text('Log Out'),
                      trailing: Icon(Icons.arrow_forward_ios),
                      onTap: () {
                        sharedPreferences.clear();

                        Navigator.of(context).pushNamedAndRemoveUntil(
                            '/', (Route<dynamic> route) => false);
                      },
                    )
                  ],
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(color: Colors.grey[200], width: 1),
                    ),
                  ),
                  height: 50,
                  child: ListTile(
                    leading: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,

                        image: DecorationImage(
                          image: NetworkImage(args.avatar),
                        ),
                        // border: Border.all(width: 1),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            offset: const Offset(0.0, 10.0),
                            blurRadius: 10.0,
                            spreadRadius: 1.0,
                          ),
                        ],
                      ),
                    ),
                    title: Text(args.userDisplayName),
                    trailing: Icon(Icons.more_horiz),
                    onTap: () {
                      Navigator.pushNamed(context, Profile.routeName,
                          arguments: JsonUser(
                              avatar: args.avatar,
                              userDisplayName: args.userDisplayName,
                              userId: args.userId,
                              token: args.token,
                              userEmail: args.userEmail,
                              userNicename: args.userNicename,
                              userRole: args.userRole));
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      appBar: AppBar(
        
        title: InkWell(
          child: Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,

              image: DecorationImage(
                image: NetworkImage(args.avatar),
              ),
              // border: Border.all(width: 1),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  offset: const Offset(0.0, 5.0),
                  blurRadius: 10.0,
                  spreadRadius: 0.0,
                ),
              ],
            ),
          ),
          onTap: () {
            Navigator.pushNamed(context, Profile.routeName,
                arguments: JsonUser(
                    avatar: args.avatar,
                    userDisplayName: args.userDisplayName,
                    userId: args.userId,
                    token: args.token,
                    userEmail: args.userEmail,
                    userNicename: args.userNicename,
                    userRole: args.userRole));
          },
        ),
        actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.search,
                // color: Color(0xffaab2b7),
              ),
              onPressed: () => Navigator.of(context).pushNamed('/search')),
          IconButton(
            icon: Icon(
              Icons.settings,
              // color: Color(0xffaab2b7),
            ),
            onPressed: () {
              Navigator.pushNamed(context, SettingPage.routeName,
                  arguments: JsonUser(
                      avatar: args.avatar,
                      userDisplayName: args.userDisplayName,
                      userId: args.userId,
                      token: args.token,
                      userEmail: args.userEmail,
                      userNicename: args.userNicename,
                      userRole: args.userRole));
            },
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 10,
              ),
              Text(
                'Featured Posts',
                style: Theme.of(context)
                    .textTheme
                    .bodyText1
                    .copyWith(fontSize: 20),
              ),
              SizedBox(
                height: 20,
              ),
              Center(child: FeaturedPosts()),
              SizedBox(
                height: 20,
              ),
              Text(
                'Trending Posts',
                style: Theme.of(context)
                    .textTheme
                    .bodyText1
                    .copyWith(fontSize: 20),
              ),
              SizedBox(
                height: 20,
              ),
              TrendiingPosts(),
              SizedBox(
                height: 20,
              ),
              Text(
                'Picks For You',
                style: Theme.of(context)
                    .textTheme
                    .bodyText1
                    .copyWith(fontSize: 20),
              ),
              Container(
                child: Container(
                  height: 800,
                  child: PickForYou(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
