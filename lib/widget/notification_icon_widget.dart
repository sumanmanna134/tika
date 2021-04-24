import 'package:flutter/material.dart';

class NamedIcon extends StatelessWidget {
  final IconData iconData;
  final VoidCallback onTap;
  final int notificationCount;
  final iconSize;

  const NamedIcon({
    Key key,
    this.onTap,
    @required this.iconData,
    this.notificationCount, this.iconSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 72,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(iconData , color: Colors.white,size: iconSize==null?30:iconSize,),
              ],
            ),
            notificationCount==0 || notificationCount == null ? SizedBox.shrink() : Positioned(
              top: 0,
              right: 0,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.red),
                alignment: Alignment.center,
                child: Text('$notificationCount' , style: TextStyle(color: Colors.white),),
              ),
            )
          ],
        ),
      ),
    );
  }
}