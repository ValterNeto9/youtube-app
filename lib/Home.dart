import 'package:flutter/material.dart';
import 'package:youtube/CustomSearchDelegate.dart';
import 'package:youtube/telas/Biblioteca.dart';
import 'package:youtube/telas/EmAlta.dart';
import 'package:youtube/telas/Incricoes.dart';
import 'package:youtube/telas/Inicio.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var _indexSelected = 0;
  String _query = "";
  

  @override
  Widget build(BuildContext context) {
  
    List<Widget> telas = [
      Inicio( _query ),
      EmAlta(),
      Inscricoes(),
      Biblioteca()
    ];

    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white,
          iconTheme: IconThemeData( color: Colors.grey ),
          title: Image.asset(
            "images/youtube.png",
            width: 98,
            height: 22
          ),
          actions: <Widget>[
             IconButton(
                icon: Icon(Icons.search),
                onPressed: () async {
                  var query = await showSearch(context: context, delegate: CustomSearchDelegate());
                  setState(() {
                    _query = query;
                  });
                }),
          ],
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: telas[ _indexSelected ]
      ),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _indexSelected,
          type: BottomNavigationBarType.fixed,
          fixedColor: Colors.red,
          onTap: ( _index ){
            setState(() {
              _indexSelected = _index;
            });
          },
          items: [
            BottomNavigationBarItem(
                title: Text("Início"),
                icon: Icon( Icons.home )
            ),
            BottomNavigationBarItem(
                title: Text("Em Alta"),
                icon: Icon( Icons.whatshot )
            ),
            BottomNavigationBarItem(
                title: Text("Inscrições"),
                icon: Icon( Icons.subscriptions )
            ),
            BottomNavigationBarItem(
                title: Text("Biblioteca"),
                icon: Icon( Icons.video_library )
            ),
          ]
      ),
    );
  }
}
