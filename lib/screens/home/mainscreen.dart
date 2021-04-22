import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tika/widget/custom_scafold.dart';

import 'homeWidget.dart';


class MainPage extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return DefaultTabController(
      length: 4,
      child: MyScaffold(
        appBar: AppBar(
          title: Text("Test"),
        ),
        bottomNavigationBar: BottomAppBar(

          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              IconButton(icon: Icon(Icons.menu), onPressed: () {},),
              IconButton(icon: Icon(Icons.search), onPressed: () {},),
            ],
          )
        ),
        body: TabBarView(
          children: <Widget>[
            HomeWidget(),
            Container(),
            Container(),
            Container(),
          ],
        ),
      ),
    );
  }

}