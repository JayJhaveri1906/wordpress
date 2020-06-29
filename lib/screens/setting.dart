import 'package:flutter/cupertino.dart';
import 'package:soledesign/Widgets/switch.dart';
import 'package:flutter/material.dart';
import 'package:soledesign/models/jsonUser.dart';
import 'package:soledesign/screens/membership.dart';
import 'package:soledesign/main.dart';
import 'package:provider/provider.dart';

class SettingPage extends StatefulWidget {
  static const routeName = '/extractSettingArguments';
  final bool status;
  SettingPage({this.status});
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  bool status = false;
  bool notificationStatus = false;
  @override
  Widget build(BuildContext context) {
    ThemeChanger _themeChanger = Provider.of<ThemeChanger>(context);
    final JsonUser args = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: Text(
              'Settings',
              style: Theme.of(context).textTheme.bodyText1.copyWith(
                    fontSize: MediaQuery.of(context).size.height * 0.05,
                    color: Color(0xff68617b),
                  ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.01,
          ),
          Container(
            height: 2,
            color: (status == false) ? Color(0xff68617b) : Colors.white,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.01,
          ),
          ListTile(
            leading: Text(
              'Dark Mode',
              style: Theme.of(context).textTheme.bodyText1.copyWith(
                    // color: (status == false) ? Color(0xff68617b) : Colors.white,
                    color: Colors.grey[700],
                    fontSize: MediaQuery.of(context).size.height * 0.027,
                  ),
            ),
            trailing: CustomSwitch(
              activeColor: Color(0xffd7ddf0),
              value: status,
              onChanged: (value) {
                print("VALUE : $value");
                setState(() {
                  status = value;
                  if (status == false) {
                    _themeChanger.setTheme(
                      ThemeData.light(),
                    );
                  } else {
                    _themeChanger.setTheme(ThemeData.dark());
                  }
                });
              },
            ),
          ),
          ListTile(
            leading: Text(
              'Privacy Look',
              style: Theme.of(context).textTheme.bodyText1.copyWith(
                    // color: (status == false) ? Color(0xff68617b) : Colors.white,
                    color: Colors.grey[700],
                    fontSize: MediaQuery.of(context).size.height * 0.027,
                  ),
            ),
            trailing: Icon(
              Icons.arrow_forward_ios,
              size: MediaQuery.of(context).size.height * 0.03,
            ),
            onTap: () {
              Navigator.pushNamed(context, '/privacy');
            },
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            height: 2,
            color: (status == false) ? Color(0xff68617b) : Colors.white,
          ),
          SizedBox(
            height: 5,
          ),
          ListTile(
            leading: Text(' Notification',
                style: Theme.of(context).textTheme.bodyText1.copyWith(
                      // color: (status == false) ? Color(0xff68617b) : Colors.white,
                      color: Colors.grey[700],
                      fontSize: MediaQuery.of(context).size.height * 0.027,
                    )),
            trailing: CustomSwitch(
              activeColor: Color(0xffd7ddf0),
              value: status,
              onChanged: (value) {
                print("VALUE : $notificationStatus");
                setState(() {
                  notificationStatus = value;
                });
              },
            ),
          ),
          ListTile(
            leading: Text(
              ' App Badge',
              style: Theme.of(context).textTheme.bodyText1.copyWith(
                    // color: (status == false) ? Color(0xff68617b) : Colors.white,
                    color: Colors.grey[700],
                    fontSize: MediaQuery.of(context).size.height * 0.027,
                  ),
            ),
            trailing: Icon(
              Icons.arrow_forward_ios,
              size: MediaQuery.of(context).size.height * 0.03,
            ),
            onTap: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text('App Badge'),
                    content: Text('This is the first Realease'),
                  );
                },
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, top: 5),
            child: Text(
              'Applications',
              style: Theme.of(context).textTheme.bodyText1.copyWith(
                  fontSize: MediaQuery.of(context).size.height * 0.05,
                  color: Color(0xff68617b)),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.01,
          ),
          Container(
            height: 2,
            color: (status == false) ? Color(0xff68617b) : Colors.white,
          ),
          // SizedBox(
          //   height: 5,
          // ),
          ListTile(
            leading: Text(
              'Upgrade to Business Account',
              style: Theme.of(context).textTheme.bodyText1.copyWith(
                    // color: (status == false) ? Color(0xff68617b) : Colors.white,
                    color: Colors.grey[700],
                    fontSize: MediaQuery.of(context).size.height * 0.027,
                  ),
            ),
            trailing: Icon(
              Icons.arrow_forward_ios,
              size: MediaQuery.of(context).size.height * 0.03,
            ),
            onTap: () {
              Navigator.pushReplacementNamed(context, Membership.routeName,
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
            leading: Text(
              'Subscription info',
              style: Theme.of(context).textTheme.bodyText1.copyWith(
                    // color: (status == false) ? Color(0xff68617b) : Colors.white,
                    color: Colors.grey[700],
                    fontSize: MediaQuery.of(context).size.height * 0.027,
                  ),
            ),
            trailing: Icon(
              Icons.arrow_forward_ios,
              size: MediaQuery.of(context).size.height * 0.03,
            ),
            onTap: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text('Subscription info'),
                    content: Text('Business Subscription is free til July'),
                    actions: <Widget>[
                      IconButton(
                        icon: Icon(Icons.touch_app),
                        onPressed: () {
                          Navigator.pushReplacementNamed(
                              context, Membership.routeName,
                              arguments: JsonUser(
                                  avatar: args.avatar,
                                  userDisplayName: args.userDisplayName,
                                  userId: args.userId,
                                  token: args.token,
                                  userEmail: args.userEmail,
                                  userNicename: args.userNicename,
                                  userRole: args.userRole));
                        },
                      )
                    ],
                  );
                },
              );
            },
          ),
          ListTile(
              leading: Text(
                'About App',
                style: Theme.of(context).textTheme.bodyText1.copyWith(
                      color: Colors.grey[700],
                      fontSize: MediaQuery.of(context).size.height * 0.027,
                    ),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                size: MediaQuery.of(context).size.height * 0.03,
              ),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text('About App'),
                      content: Text(
                          'We are a new way of searching for a business or service, a simple and easy directory where small businesses are together under one roof. We are The Sole Entrepreneur! Our goal is to help people search and find different services in their local area. This can include anything from a contracted DiY man, catering companies to make up artists and hair vendors.'),
                    );
                  },
                );
              }),
        ],
      ),
    );
  }
}
