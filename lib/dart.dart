import 'dart:convert';
import 'dart:html';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String acessKey = '16de2e618313ed2f258c416f2fdddd1e';
  List test = [];
  Future getdata() async {
    List<User> users = [];
    var response = await http.get(Uri.parse(
        "http://api.aviationstack.com/v1/airports?access_key=$acessKey"));
    var jsonData = jsonDecode(response.body);
    for (var u in jsonData["data"]) {
      User user = User(u['id'], u['gmt'], u['airport_id']);
      users.add(user);
    }

    // for (var i in jsonData['data']) {
    //   test.add(i['airport_name']);
    // }
    print(test);

    // return users;
    return test;
  }

  var selected = "yes";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            child: Card(
              child: FutureBuilder(
                future: getdata(),
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.data == null) {
                    return Container(
                      child: Text('loading...'),
                    );
                  } else
                    return ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, int index) {
                        return ListTile(
                          title: Text(snapshot.data[index].toString()),
                          onTap: () {
                            setState(() {
                              selected = snapshot.data[index].toString();
                            });
                          },
                        );
                      },
                    );
                },
              ),
            ),
          ),
          Text(selected),
        ],
      ),
    );
  }
}

class User {
  final String name, email, username;
  User(this.name, this.email, this.username);
}
