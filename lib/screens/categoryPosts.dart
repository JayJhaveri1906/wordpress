import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:soledesign/Widgets/postDetailArgument.dart';
import 'package:soledesign/models/detailPost.dart';

class PageV extends StatelessWidget {
  final String searchText;
  PageV({this.searchText});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () => Navigator.pop(context)),
        title: Text('You have search for $searchText',
            style: TextStyle(color: Colors.black)),
      ),
      body: Container(
        child: SearchPost(
          searchText: searchText,
        ),
      ),
    );
  }
}

class SearchPost extends StatelessWidget {
  final String searchText;
  SearchPost({this.searchText});

  Future<bool> onLikeButtonTapped(bool isLiked) async {
    /// send your request here
    // final bool success= await sendRequest();

    /// if failed, you can do nothing
    // return success? !isLiked:isLiked;
    print(isLiked);
    return !isLiked;
  }

  @override
  Widget build(BuildContext context) {
    Future<List> searchWpPosts() async {
      final response = await http.get(
          'https://soleentrepreneur.co.uk/wp-json/wp/v2/posts?_fields=fimg_url,featured_media,title.rendered,content.rendered,excerpt.rendered,date,author,author_meta,guid.rendered&search=$searchText',
          headers: {"Accept": "application/json"});
      var convertDatattoJson = jsonDecode(response.body);
      return convertDatattoJson;
    }

    return FutureBuilder(
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.data.length == 0) {
            return Center(child: Text('No Data Found'));
          }
          return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, index) {
                Map wppost = snapshot.data[index];
                return Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: InkWell(
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
                            content: wppost['content']['rendered']),
                      );
                    },
                    child: Card(
                      child: Column(
                        children: <Widget>[
                          ListTile(
                              leading: Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black26,
                                      offset: const Offset(0.0, 10.0),
                                      blurRadius: 10.0,
                                      spreadRadius: 1.0,
                                    ),
                                  ],
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                  // border: Border.all(width: 1),
                                  image: DecorationImage(
                                    image: (wppost['fimg_url']) == false
                                        ? AssetImage('assets/IMG_2382.PNG')
                                        : NetworkImage(wppost['fimg_url']),
                                  ),
                                  // border: Border.all(width: 1),
                                ),
                              ),
                              title: Text(wppost['title']['rendered']),
                              // subtitle: Text(wppost['date']),
                              trailing: IconButton(
                                icon: Icon(Icons.favorite),
                                onPressed: () {},
                              )
                              // onTap: () {},
                              ),
                          Container(
                            height: 200,
                            color: Colors.white,
                            child: Image.network(
                              '${wppost['fimg_url']}',
                              fit: BoxFit.fill,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                // Icon(Icons.location_on),
                                // Text('San Francisco, CA'),
                              ],
                            ),
                          ),
                          // Text(wppost['guid']['rendered']),
                          // Text(wppost['title']['rendered']),
                          // Text(wppost['content']['rendered']),
                        ],
                      ),
                    ),
                  ),
                );
              });
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
              child: SpinKitFadingCube(
            color: Colors.grey,
            size: 50.0,
          ));
        }

        return Text('data is comming');
      },
      future: searchWpPosts(),
    );
  }
}

class SearchByCategory extends StatelessWidget {
  final String searchByCategory;
  final String categoryName;
  SearchByCategory({this.searchByCategory, this.categoryName});

  Future<bool> onLikeButtonTapped(bool isLiked) async {
    /// send your request here
    // final bool success= await sendRequest();

    /// if failed, you can do nothing
    // return success? !isLiked:isLiked;
    print(isLiked);
    return !isLiked;
  }

  @override
  Widget build(BuildContext context) {
    Future<List> searchWpPosts() async {
      final response = await http
          .get('$searchByCategory', headers: {"Accept": "application/json"});
      var convertDatattoJson = jsonDecode(response.body);
      print(convertDatattoJson);
      return convertDatattoJson;
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
            ),
            onPressed: () => Navigator.pop(context)),
        title: Text(
          categoryName,
          style: TextStyle(color: Color(0xff68617b)),
        ),
      ),
      body: Container(
        child: FutureBuilder(
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.data.length == 0) {
                return Center(child: Text('No Data Found'));
              }
              return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, index) {
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
                              content: wppost['content']['rendered']),
                        );
                      },
                      child: Card(
                        child: Column(
                          children: <Widget>[
                            ListTile(
                                leading: Container(
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black26,
                                        offset: const Offset(0.0, 10.0),
                                        blurRadius: 10.0,
                                        spreadRadius: 1.0,
                                      ),
                                    ],
                                    shape: BoxShape.circle,
                                    color: Colors.white,
                                    // border: Border.all(width: 1),
                                    image: DecorationImage(
                                      image: (wppost['fimg_url']) == false
                                        ? AssetImage('assets/IMG_2382.PNG')
                                        : NetworkImage(wppost['fimg_url']),
                                    ),
                                    // border: Border.all(width: 1),
                                  ),
                                ),
                                title: Text(wppost['title']['rendered']),
                                // subtitle: Text(wppost['date']),
                                trailing: IconButton(
                                  icon: Icon(Icons.favorite),
                                  onPressed: () {},
                                )
                                // onTap: () {},
                                ),
                            Container(
                              height: 200,
                              color: Colors.white,
                              child: (wppost['fimg_url'] == false)
                                  ? Image.asset('assets/IMG_2382.PNG')
                                  : Image.network(
                                      '${wppost['fimg_url']}',
                                      fit: BoxFit.fill,
                                    ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  // Icon(Icons.location_on),
                                  // Text('San Francisco, CA'),
                                ],
                              ),
                            ),
                            // Text(wppost['date']),
                            // Text(wppost['guid']['rendered']),
                            // Text(wppost['link']),
                            // Text(wppost['title']['rendered']),
                            // Text(wppost['content']['rendered']),
                            // Text(wppost['excerpt']['rendered']),
                            // Text(wppost['author_meta']['display_name']),
                          ],
                        ),
                      ),
                    );
                  });
            }

            return Center(
                child: SpinKitFadingCube(
              color: Colors.grey,
              size: 50.0,
            ));
          },
          future: searchWpPosts(),
        ),
      ),
    );
  }
}
