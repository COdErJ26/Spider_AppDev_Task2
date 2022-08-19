import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(
    MaterialApp(
      title: 'Named Routes Demo',
      initialRoute: '/home',
      routes: {
        '/display': (context) => FirstPage(),
        '/home': (context) => Home(),
      },
    ),
  );
}

class FirstPage extends StatefulWidget {
  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  Map data = {};
  var test = [];
  Future getdata() async {
    String acessKey = '37f963e6b905cf2e36fb6f898cc0d165';

    var response = await http.get(Uri.parse(
        "http://api.aviationstack.com/v1/flights?access_key=2dd277952dbc18466d11d39d4f76b648"));
    var jsonData = jsonDecode(response.body);
    for (var i in jsonData['data']) {
      // Couldn't access more info through API, so commenting out if condition for displaying some results
      // if (i["departure"]["airport"] == data["current"] &&
      //     i["arrival"]["airport"] == data["destination"]) {
      test.add({
        "flightDate": i['flight_date'],
        "number": i["flight"]["number"],
        "iataCode": i["flight"]["iata"]
      });
    }

    // return users;
    return test;
  }

  Set<String> savedWords = Set<String>();

  var iconcolorTF = false;
  var iconColor = Colors.grey;
  var FavItem = [];
  int? selectedIndex;
  List? selectedIndexList;
  String? flightNumber;
  _onSelected(String flightNumber) {
    setState(() {
      selectedIndexList?.add(flightNumber);
    });
  }

  @override
  Widget build(BuildContext context) {
    data = ModalRoute.of(context)?.settings.arguments as Map;
    print(data);
    return Scaffold(
        appBar: AppBar(title: Text('Flights Available')),
        body: Card(
            child: FutureBuilder(
          future: getdata(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.data == null) {
              return Container(
                child: const Text('No such Flights Found..'),
              );
            } else {
              return ListView.separated(
                  separatorBuilder: ((context, index) => const Divider()),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, int index) {
                    return ListTile(
                      title: Text(
                          "FlightNumber: ${snapshot.data[index]["number"].toString()}, Flight_Date: ${snapshot.data[index]["flightDate"].toString()} , Iata_Code: ${snapshot.data[index]["iataCode"].toString()} "),
                      trailing: IconButton(
                        icon: const Icon(Icons.favorite),
                        color: selectedIndex != null && selectedIndex == index
                            ? Colors.redAccent
                            : Colors.grey,
                        onPressed: () {
                          print(selectedIndexList);
                          setState(() {
                            _onSelected(
                                snapshot.data[index]["number"].toString());
                            if (iconcolorTF == false) {
                              FavItem.add(
                                  snapshot.data[index]["number"].toString());
                              iconColor = Colors.red;
                              iconcolorTF = true;
                            } else {
                              iconColor = Colors.grey;
                              iconcolorTF = false;
                            }
                          });
                        },
                      ),
                    );
                  });
            }
          },
        )));
  }
}

class Home extends StatefulWidget {
  // final String? name;
  // final String? rollNo;

  // const Home({Key? key, required this.name, required this.rollNo})
  //     : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String acessKey = '2dd277952dbc18466d11d39d4f76b648';
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
      appBar: AppBar(
        title: Text('Flight overview'),
        backgroundColor: Colors.blue[500],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 20.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: Colors.purple),
                    onPressed: () {
                      setState(() {
                        selectAirport1 = true;
                      });
                    },
                    child: Text("Current location")),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: Colors.purple),
                    onPressed: () {
                      selectAirport2 = true;
                    },
                    child: Text("Destination"))
              ],
            ),
            SizedBox(
              height: 20.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(selectedAirport1),
                const Text("to"),
                Text(selectedAirport2)
              ],
            ),
            SizedBox(
              height: 20.0,
            ),
            ElevatedButton(
                onPressed: () {
                  if (!(selectedAirport1 == "Current Loction" &&
                      selectedAirport2 == "Destination")) {
                    Navigator.pushNamed(context, "/display", arguments: {
                      "current": selectedAirport1,
                      "destination": selectedAirport2
                    });
                  } else {
                    print("press");
                  }
                },
                style: ElevatedButton.styleFrom(primary: Colors.purple),
                child: Text("Submit")),
            SizedBox(
              height: 20.0,
            ),
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

// class FavPage extends StatefulWidget {
//   const FavPage({Key? key}) : super(key: key);

//   @override
//   State<FavPage> createState() => _FavPageState();
// }

// class _FavPageState extends State<FavPage> {
//   @override
//   Widget build(BuildContext context) {}
// }
