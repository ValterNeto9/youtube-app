import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

class CustomSearchDelegate extends SearchDelegate<String> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon( Icons.clear ),
        onPressed: (){
          query = "";
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: Icon( Icons.arrow_back ),
        onPressed: (){
          close(context, "");
        },
      );
  }

  @override
  Widget buildResults(BuildContext context) {
    close(context, query);
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {

    List<String> sugestoes = List();

    if( query.isNotEmpty ){
      sugestoes = ["Android", "Android Q", "IOS", "Jogos", "Flutter"]
                  .where((item) => item.toLowerCase().startsWith(query.toLowerCase()) ).toList();

      return ListView.builder(
          itemCount: sugestoes.length,
          itemBuilder: ( context, index ){
            return ListTile(
              onTap: (){
                close(context, sugestoes[index] );
              },
              title: Text( sugestoes[index] ),
            );
          }
        );
    }

    return Container();

  }
  
}