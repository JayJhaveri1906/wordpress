import 'package:flutter/material.dart';
import 'package:soledesign/Widgets/button.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Testing'),
      // ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Image.asset('assets/IMG_2382.PNG'),
          Column(
            children: <Widget>[
              AppButton(
                width: 170,
                buttonTitle: 'Log In',
                onPressed: () => Navigator.pushNamed(context, '/second'),
              ),
              SizedBox(height: 20,),
              AppButton(
                buttonTitle: 'Register',
                onPressed: () => Navigator.pushNamed(context, '/register'),width: 170,
              ),
            ],
          )
        ],
      ),
    );
  }
}
