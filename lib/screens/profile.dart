import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:soledesign/Widgets/button.dart';
import 'package:soledesign/Widgets/postDetailArgument.dart';
import 'package:soledesign/models/detailPost.dart';
import 'package:soledesign/models/jsonUser.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:soledesign/screens/membership.dart';
import 'package:soledesign/screens/userAllPost.dart';

class Profile extends StatefulWidget {
  static const routeName = '/extractUserArguments';
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final List<String> _listItem = [
    'assets/IMG_2382.PNG',
    'assets/IMG_2382.PNG',
    'assets/IMG_2382.PNG',
    'assets/IMG_2382.PNG',
    'assets/IMG_2382.PNG',
    'assets/Image.png',
    // 'assets/Image.png',
    // 'assets/Image.png',
    // 'assets/Image.png',
  ];
  @override
  Widget build(BuildContext context) {
    final JsonUser args = ModalRoute.of(context).settings.arguments;
    Future<List> fetchUserPost() async {
      final response = await http.get(
          'https://soleentrepreneur.co.uk/wp-json/wp/v2/posts?author=${args.userId}&_fields=fimg_url,featured_media,title.rendered,content.rendered,excerpt.rendered,date,guid.rendered&per_page=1',
          headers: {"Accept": "application/json"});
      var convertDatattoJson = jsonDecode(response.body);
      return convertDatattoJson;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'User Profile',
          style: TextStyle(color: Color(0xff68617b)),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            // color: Color.fromRGBO(124, 116, 146, 1)
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.search),
              onPressed: () => Navigator.pushNamed(context, '/search'))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,

                      image: DecorationImage(
                        image: NetworkImage(args.avatar),
                      ),
                      // border: Border.all(width: 1),
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromRGBO(124, 116, 146, 0.1),
                          blurRadius:
                              10.0, // has the effect of softening the shadow
                          spreadRadius:
                              5.0, // has the effect of extending the shadow
                          offset: Offset(
                            0.0, // horizontal, move right 10
                            1.0, // vertical, move down 10
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                (args.userRole[0] == "subscriber")
                    ? Container(
                        child: AppButton(
                        buttonTitle: ' +  Upgrade',
                        width: 200,
                        onPressed: () => Navigator.pushNamed(
                            context, Membership.routeName,
                            arguments: JsonUser(
                                avatar: args.avatar,
                                userDisplayName: args.userDisplayName,
                                userId: args.userId,
                                token: args.token,
                                userEmail: args.userEmail,
                                userNicename: args.userNicename,
                                userRole: args.userRole)),
                      ))
                    : Container(
                        child: AppButton(
                        buttonTitle: ' +  Add Business',
                        width: 200,
                        onPressed: () =>
                            Navigator.pushNamed(context, '/addBusiness'),
                      ))
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                args.userDisplayName,
                // style: Theme.of(context)
                //     .textTheme
                //     .headline6
                //     .copyWith(color: Colors.black),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 0.0, left: 10),
              child: Text(args.userRole[0] == 'subscriber'
                  ? 'Customer MemberShip'
                  : 'Business MemberShip'),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Bookmarked Companies',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1
                          .copyWith(fontSize: 16),
                    ),
                    InkWell(
                      child: Text('View All'),
                      onTap: () {},
                    )
                  ]),
            ),
            GridView.count(
              physics: ClampingScrollPhysics(),
              shrinkWrap: true,
              crossAxisCount: 3,
              crossAxisSpacing: 1,
              mainAxisSpacing: 1,
              children: _listItem
                  .map((item) => Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Card(
                          elevation: 3,
                          shape: BeveledRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                image: DecorationImage(
                                    image: AssetImage(item), fit: BoxFit.fill)),
                            child: Transform.translate(
                              offset: Offset(50, -50),
                              child: Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: 65, vertical: 63),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  // color: Colors.white
                                ),
                              ),
                            ),
                          ),
                        ),
                      ))
                  .toList(),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            (args.userRole[0] == 'subscriber')
                ? Container()
                : Container(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'My Posts',
                            style: Theme.of(context).textTheme.subtitle2,
                          ),
                          InkWell(
                            child: Text('View all'),
                            onTap: () {
                              Navigator.pushNamed(
                                  context, UserAllPost.routeName,
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
                    ),
                  ),
            (args.userRole[0] == 'subscriber')
                ? Center(
                    child: Container(
                      child: Text('No Post for User to Display'),
                    ),
                  )
                : Container(
                    height: MediaQuery.of(context).size.height * 0.5,
                    child: FutureBuilder(
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return ListView.builder(
                              physics: ClampingScrollPhysics(),
                              itemBuilder: (context, index) {
                                Map wppost = snapshot.data[index];
                                return InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(
                                      context,
                                      ExtractPostDetailArgument.routeName,
                                      arguments: DetailPostArguments(
                                        title: wppost['title']['rendered'],
                                        link: wppost['guid']['rendered'],
                                        image: (wppost['fimg_url']) == false
                                            ? 'assets/IMG_2382.PNG'
                                            : wppost['fimg_url'],
                                        excerpt: wppost['excerpt']['rendered'],
                                        content: wppost['content']['rendered'],
                                      ),
                                    );
                                  },
                                  child: Card(
                                    child: Column(
                                      children: <Widget>[
                                        ListTile(
                                          leading: CircleAvatar(),
                                          title:
                                              Text(wppost['title']['rendered']),
                                          // subtitle: Text(wppost['date']),
                                          trailing: IconButton(
                                              icon: Icon(Icons.favorite),
                                              onPressed: () {}),
                                          // onTap: () {},
                                        ),
                                        Container(
                                          height: 200,
                                          // color: Colors.white,
                                          child: Image.network(
                                            '${wppost['fimg_url']}',
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(20.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: <Widget>[
                                            ],
                                          ),
                                        ),
                                        // Text(wppost['guid']['rendered']),
                                        // Text(wppost['title']['rendered']),
                                        // Text(wppost['content']['rendered']),
                                      ],
                                    ),
                                  ),
                                );
                              },
                              itemCount: snapshot.data.length);
                        }
                        return SpinKitRing(
                          color: Colors.blue,
                          duration: Duration(milliseconds: 900),
                          lineWidth: 5,
                        );
                      },
                      future: fetchUserPost(),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
