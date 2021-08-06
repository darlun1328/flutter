// ignore_for_file: must_be_immutable, prefer_const_constructors

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:trii_api/models/character.dart';
import 'package:trii_api/services/api_service.dart';
import 'detailscreen.dart';

class ListScreen extends StatefulWidget {
  const ListScreen() : super();

  @override
  ListScreenState createState() => ListScreenState();
}

class Debouncer {
  final int milliseconds;
  late VoidCallback action;
  Timer? _timer;

  Debouncer({required this.milliseconds});

  run(VoidCallback action) {
    if (null != _timer) {
      _timer!.cancel();
    }
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }
}

class ListScreenState extends State<ListScreen> {
  final _debouncer = Debouncer(milliseconds: 500);
  late List<Character> c;
  List<Character> filter = [];

  @override
  void initState() {
    super.initState();
    ApiService.getCharacters().then((lista) {
      setState(() {
        c = lista;
        filter = c;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('The Rick and Morty API'),
      ),
      body: Column(
        children: <Widget>[
          TextField(
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(15.0),
              hintText: 'Buscar',
            ),
            onChanged: (string) {
              _debouncer.run(() {
                setState(() {
                  filter = c
                      .where((u) =>
                          (u.name.toLowerCase().contains(string.toLowerCase())))
                      .toList();
                });
              });
            },
          ),
          Expanded(
            child: ListView.builder(
                padding: const EdgeInsets.all(10.0),
                itemCount: filter.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      DetailScreen(filter[index])),
                            );
                          },
                          child: ListTile(
                            leading: Icon(Icons.person),
                            title: Text(filter[index].name),
                          ),
                        )),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
