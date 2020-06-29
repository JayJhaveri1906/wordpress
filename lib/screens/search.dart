import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:soledesign/screens/categoryPosts.dart';
import '../API/wp_api.dart';

class SearchPosts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            // color: Color.fromRGBO(124, 116, 146, 1)
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[MyCustomForm(), SearchGridView()],
        ),
      ),
    );
  }
}

class SearchGridView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Container(
              height: MediaQuery.of(context).size.height * 2,
              child: ListView.builder(
                  // gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                  //     crossAxisCount: (MediaQuery.of(context).orientation ==
                  //             Orientation.portrait)
                  //         ? 2
                  //         : 4),
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, index) {
                    Map wppost = snapshot.data[index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SearchByCategory(
                                searchByCategory: wppost['_links']
                                    ['wp:post_type'][0]['href'],
                                categoryName: wppost['name'],
                              ),
                            ),
                          );
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 30,
                              child: Text(wppost['name']),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 1,
                              color: Colors.grey[350],
                            ),
                          ),
                        ]),
                      ),
                    );
                  }),
            );
          }
          return Center(
              child: SpinKitFadingCube(
            color: Colors.grey,
            size: 50.0,
          ));
        },
        future: fetchCategory(),
      ),
    );
  }
}

// Define a custom Form widget.
class MyCustomForm extends StatefulWidget {
  @override
  _MyCustomFormState createState() => _MyCustomFormState();
}

// Define a corresponding State class.
// This class holds the data related to the Form.
class _MyCustomFormState extends State<MyCustomForm> {
  // Create a text controller and use it to retrieve the current value
  // of the TextField.
  final myController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 30.0, right: 20.0, bottom: 40),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(width: 1, color: Color(0xfff0f5fd)),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Color.fromRGBO(124, 116, 146, 0.1),
              blurRadius: 10.0, // has the effect of softening the shadow
              spreadRadius: 5.0, // has the effect of extending the shadow
              offset: Offset(
                0.0, // horizontal, move right 10
                10.0, // vertical, move down 10
              ),
            )
          ],
        ),
        child: Form(
          autovalidate: true,
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.only(left: 40.0),
            child: TextFormField(
              style: TextStyle(color: Colors.black),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Search For Companies',
                labelText: 'Search For Companies',
                suffixIcon: IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PageV(
                              searchText: myController.text,
                            ),
                          ),
                        );
                      }
                    }),
              ),
              keyboardType: TextInputType.text,
              validator: (value) {
                if (value.length < 2) {
                  return 'Name not long enough';
                }
              },
              controller: myController,
            ),
          ),
        ),
      ),
    );
  }
}
