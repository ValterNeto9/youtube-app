import 'package:flutter/material.dart';
import 'package:youtube/model/Video.dart';

import '../Api.dart';

class Inicio extends StatefulWidget {

  String query = "";

  Inicio( this.query );

  @override
  _InicioState createState() => _InicioState();
}

class _InicioState extends State<Inicio> {
  
  _listarVideos( String query ){
    Api api = Api();
    return api.pesquisar( query );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Video>>(
      future: _listarVideos( widget.query ),
      builder: (context, snapshot){
        switch ( snapshot.connectionState ) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            return Center(child: CircularProgressIndicator());
            break;
          case ConnectionState.active:
          case ConnectionState.done:
            if( snapshot.hasData ){

              return ListView.separated(
                  itemBuilder: ( context, index ) {
                    
                    List<Video> videos = snapshot.data;

                    Video video = videos[ index ];

                    return Column(
                      children: <Widget>[
                        Container(
                        // daria para pegat o height da propria imagem
                         height: 180,
                         decoration: BoxDecoration(
                           image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage( video.imagem )
                           ),
                         )
                        ),
                        ListTile(
                          title: Text( video.titulo ),
                          subtitle: Text( video.canal),
                        )
                      ],
                    );
                  },
                  separatorBuilder: ( context, index ) => Divider(
                    height: 3,
                    color: Colors.green,
                  ),
                  itemCount: snapshot.data.length
                );
            } else {
              return Center(
                child: Text("Nenhum dado a ser carregado"),
              );
            }
            break;
        }
      },
    );
  }
}
