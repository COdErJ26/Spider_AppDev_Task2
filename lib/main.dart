import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(
    MaterialApp(
      title: 'Named Routes Demo',
      initialRoute: '/home',
      routes: {
        // '/display': (context) => FirstPage(Current: ,),
        '/home': (context) => Home(),
      },
    ),
  );
}

// class FirstPage extends StatefulWidget {
//   String Current = '';
//  String destination = '';
//  FirstPage({required this.Current, required this.destination});
//   @override
//   State<FirstPage> createState() => _FirstPageState();
// }

// class _FirstPageState extends State<FirstPage> {

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Flight overview')),
//       body:  );
//   }
// }

class Home extends StatefulWidget {
  // final String? name;
  // final String? rollNo;

  // const Home({Key? key, required this.name, required this.rollNo})
  //     : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String acessKey = '37f963e6b905cf2e36fb6f898cc0d165';
  var test = [];
  Future getdata() async {
    // List<User> users = [];
    var response = await http.get(Uri.parse(
        "http://api.aviationstack.com/v1/airports?access_key=$acessKey"));
    var jsonData = jsonDecode(response.body);
    // for (var u in jsonData["data"]) {
    //   User user = User(u['id'], u['gmt'], u['airport_id']);
    //   users.add(user);
    //   print(user.name);
    // }
    // print(users[0].name);
    for (var i in jsonData['data']) {
      test.add(i['airport_name']);
      // print(i["airport_name"]);
    }
    // print(test);

    // return users;
    return test;
  }

  bool selectAirport1 = true;
  bool selectAirport2 = false;
  var selectedAirport1 = "Current Location";
  var selectedAirport2 = "Destination";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Flight overview')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                    onPressed: () {
                      setState(() {
                        selectAirport1 = true;
                      });
                    },
                    child: Text("Current location")),
                ElevatedButton(
                    onPressed: () {
                      selectAirport2 = true;
                    },
                    child: Text("Destination"))
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(selectedAirport1),
                const Text("to"),
                Text(selectedAirport2)
              ],
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, "/", arguments: {
                    "current": selectedAirport1,
                    "destination": selectAirport2
                  });
                },
                child: Text("Submit")),
            Card(
              child: FutureBuilder(
                future: getdata(),
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.data == null) {
                    return Container(
                      child: const Text('loading...'),
                    );
                  } else {
                    return ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, int index) {
                        return ListTile(
                          title: Text(snapshot.data[index].toString()),
                          onTap: () {
                            print("pressed");
                            setState(() {
                              if (selectAirport1) {
                                selectedAirport1 =
                                    snapshot.data[index].toString();
                                selectAirport1 = false;
                              }
                              if (selectAirport2) {
                                selectedAirport2 =
                                    snapshot.data[index].toString();
                                selectAirport1 = false;
                                selectAirport2 = false;
                              }

                              print(selectedAirport1);
                            });
                          },
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// class User {
//   final String name, email, username;
//   User(this.name, this.email, this.username);
// }
