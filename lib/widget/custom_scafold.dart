import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:tika/Utils/appconfig.dart';

import 'no_internet.dart';


class MyScaffold extends StatelessWidget {
  final Widget body;
  final PreferredSizeWidget appBar;
  final Widget drawer;
  final Color backgroundColor;
  final Widget bottomNavigationBar;
  final bool resizeToAvoidBottomInset;

  const MyScaffold(
      {Key key,
        this.body,
        this.appBar,
        this.drawer,
        this.backgroundColor,
        this.bottomNavigationBar, this.resizeToAvoidBottomInset})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return (Scaffold(
      appBar: appBar,
      drawer: drawer,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      backgroundColor: backgroundColor,
      body:Builder(
        builder: (BuildContext context){
          return OfflineBuilder(
            connectivityBuilder: (BuildContext context, ConnectivityResult connectivity, Widget child ){
              final bool connected = connectivity != ConnectivityResult.none;

              return Stack(
                fit: StackFit.expand,
                children: [
                  child,
                  Positioned(
                    left:0.0,
                    right:0.0,
                    height: 24.0,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      color: connected? null : AppColor.colorRed,
                      child: connected? null : NoInternet(),
                    ),
                  )
                ],
              );

            },
            child: body,
          );
        },
      )
    ));
  }
}
