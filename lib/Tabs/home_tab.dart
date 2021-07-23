import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:transparent_image/transparent_image.dart';

class HomeTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    Widget _buildBodyBack() => Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [
                Colors.pinkAccent,
                Color.fromARGB(255, 211, 118, 130),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight
          )
      ),
    );

    return Stack(
      children: <Widget>[
        _buildBodyBack(),
        CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              floating: true,
              snap: true,
              backgroundColor: Colors.transparent,
              elevation: 0,
              flexibleSpace: FlexibleSpaceBar(
                title: const Text("Novidades",style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),),
                centerTitle: true,
              ),
            ),

            // imagens que serão carregadas na inicio
            FutureBuilder<QuerySnapshot>(
              future: Firestore.instance.collection("home").orderBy("pos").getDocuments(),
              builder: (context, snapshot){
                if(!snapshot.hasData)
                  return SliverToBoxAdapter(
                    child: Container(
                      height: 200.0,
                      alignment: Alignment.center,
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    ),
                  );
                else
                  return SliverStaggeredGrid.count(
                    crossAxisCount: 2, //numero de blocos
                    crossAxisSpacing: 0,
                    mainAxisSpacing: 0,
                    staggeredTiles: snapshot.data.documents.map(
                            (doc){
                          return StaggeredTile.count(doc.data["x"], doc.data["y"]);
                        }
                    ).toList(),
                    children: snapshot.data.documents.map(
                            (doc){
                          print(doc.data);
                          return FadeInImage.memoryNetwork(
                            placeholder: kTransparentImage,
                            image: doc["image"],
                            fit: BoxFit.cover,
                          );
                        }
                    ).toList(),
                  );
              },
            )
          ],
        )
      ],
    );

  }
}