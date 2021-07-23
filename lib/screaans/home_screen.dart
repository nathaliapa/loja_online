import 'package:flutter/material.dart';
import 'package:loja_online/Tabs/home_tab.dart';
import 'package:loja_online/Tabs/products_tab.dart';
import 'package:loja_online/widgets/custom_drawer.dart';

class HomeScreen extends StatelessWidget {

  final _pageController = PageController();

  @override
  Widget build(BuildContext context) {

    return PageView(
      controller: _pageController,
      physics: NeverScrollableScrollPhysics(),
      children: <Widget>[
        Scaffold(
          body: HomeTab(),
          drawer: CustomDrawer(_pageController),
        ),
        Scaffold(
          appBar: AppBar(
            title: Text('Produtos',style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                ),
              ),
            centerTitle: true,
            backgroundColor: Colors.pinkAccent,
          ),
          drawer: CustomDrawer(_pageController),
          body: ProuctsTab(),
        ),
        Container(color: Colors.green,),
        Container(color: Colors.yellow,),
      ],
    );
  }
}
