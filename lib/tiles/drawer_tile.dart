import 'package:flutter/material.dart';
class DrawerTile extends StatelessWidget {

  final IconData icons;
  final String text;
  final PageController controller;
  final int page;

  DrawerTile(this.icons,this.text,this.controller,this.page);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: (){
          Navigator.of(context).pop();
          controller.jumpToPage(page);
        },
        child: Container(
          height: 60.0,
          child: Row(
            children: <Widget>[
              Icon(
                icons,
              size: 32.0,
              color: controller.page.round() == page ?
                Colors.black : Colors.white,
              ),
              SizedBox(
                width: 32.0,
              ),
              Text(
                text,
                style: TextStyle(
                  fontSize: 16.0,
                  color: controller.page.round() == page ?
                  Colors.black : Colors.white,
                  fontWeight: FontWeight.bold
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
