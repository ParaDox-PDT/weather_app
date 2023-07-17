import 'package:flutter/material.dart';



class RegionsSearchView extends SearchDelegate {
  RegionsSearchView({required this.regions});

  final List<String> regions;

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = "";
          },
          icon: const Icon(Icons.close))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, query);
        },
        icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    return Center(
      child: Text(
        query,
        style: const TextStyle(
          fontSize: 64,
        ),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> currentRegions = regions.where((searchResult) {
      final result = searchResult.toLowerCase();
      final input = query.toLowerCase();
      return result.contains(input);
    }).toList();
    return Padding(
      padding: const EdgeInsets.all(20),
      child: ListView(
        children: List.generate(
            regions.length,
                (index) => ListTile(
              title: Text(
                regions[index],
                overflow: TextOverflow.ellipsis,
              ),
              titleTextStyle: const TextStyle(
                  fontSize: 16,
                  fontFamily: "Roboto",
                  fontWeight: FontWeight.w600,
                  color: Colors.black),
              onTap: (){
                query=regions[index];
                close(context, query);
              },
            )),
      ),
    );
  }
}