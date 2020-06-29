import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:share/share.dart';
import 'package:social_share/social_share.dart';

class StackWidget extends StatelessWidget {
  void share(BuildContext ctx) {
    Share.share('This is the Example App Check it out');
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      overflow: Overflow.visible,
      children: <Widget>[
        Container(
          height: 250,
          width: MediaQuery.of(context).size.width * 0.8,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.white),
            boxShadow: [
              BoxShadow(
                color: Color.fromRGBO(124, 116, 146, 0.4),
                blurRadius: 10.0, // has the effect of softening the shadow
                spreadRadius: 1.0, // has the effect of extending the shadow
                offset: Offset(
                  0.0, // horizontal, move right 10
                  10.0, // vertical, move down 10
                ),
              )
            ],
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(10),
              bottomRight: Radius.circular(10),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 40.0, right: 70, top: 40),
            child: Text(
              'Company Name',
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ),
        ),
        Positioned(
          top: 100,
          child: Row(children: <Widget>[
            IconButton(
              icon: Icon(SimpleLineIcons.social_twitter),
              onPressed: () async {
                SocialShare.shareTwitter("This is Social Share twitter example",
                        hashtags: ["hello", "world", "foo", "bar"],
                        url: "https://google.com/#/hello",
                        trailingText: "\nhello")
                    .then((data) {
                  print(data);
                });
              },
            ),
            IconButton(
              icon: Icon(FontAwesome.whatsapp),
              onPressed: () async {
                SocialShare.shareWhatsapp("Hello World \n https://google.com")
                    .then((data) {
                  print(data);
                });
              },
            ),
            IconButton(
                icon: Icon(Feather.message_circle),
                onPressed: () async {
                  SocialShare.shareSms("This is Social Share Sms example",
                          url: "\nhttps://google.com/", trailingText: "\nhello")
                      .then((data) {
                    print(data);
                  });
                }),
            IconButton(
              icon: Icon(SimpleLineIcons.share),
              onPressed: () => share(context),
            ),
          ]),
        ),
        Positioned(
          left: 0.0,
          bottom: 0.0,
          child: Container(
            height: 100,
            width: MediaQuery.of(context).size.width * 0.8,
            decoration: BoxDecoration(
              color: Color.fromRGBO(251, 251, 251, 1),
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(10),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 40.0, right: 70, top: 20),
              child: ListTile(
                leading: Icon(Icons.location_on),
                title: Text('Location'),
              ),
            ),
          ),
        ),
        Positioned(
          left: MediaQuery.of(context).size.width * 0.6,
          top: 40,
          child: Container(
            height: 190,
            width: 160,
            decoration: BoxDecoration(
              color: Colors.yellow,
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                  image: AssetImage('assets/company.png'), fit: BoxFit.fill),
            ),
          ),
        ),
      ],
    );
  }
}
