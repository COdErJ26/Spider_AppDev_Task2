import 'package:flutter/material.dart';
// class Home extends StatefulWidget {
//   const Home({Key? key}) : super(key: key);

//   @override
//   State<Home> createState() => _HomeState();
// }

// class _HomeState extends State<Home> {
//   String acessKey = '51004e258869bca39f6cbaf3501bec39';
//   List test = [];
//   List<Map> users = [];
//   Future getdata() async {
//     var response = await http.get(Uri.parse(
//         "http://api.aviationstack.com/v1/airports?access_key=$acessKey"));
//     var jsonData = jsonDecode(response.body);
//     for (var u in jsonData["data"]) {
//       User user = User(u['id'], u['gmt'], u['airport_id']);

//       // print(user.id);
//       // print(user.email);
//       // print(user.username);
//       users.add({
//         "id1": " ${user.id}",
//         "gmt": "${user.email}",
//         "airport": "${user.username}"
//       });
//       // print(users);
//       print(users[0]['id1']);
//     }
//     print('helloxs');
//     return {users[0]["id1"]};
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         child: Card(
//           child: FutureBuilder(
//             future: getdata(),
//             builder: (context, AsyncSnapshot snapshot) {
//               if (snapshot.data == null) {
//                 return Container(
//                   child: Text('loading...'),
//                 );
//               } else
//                 return ListView.builder(
//                   itemCount: snapshot.data.length,
//                   itemBuilder: (context, int index) {
//                     return ListTile(
//                       title: Text(snapshot.data[index]["id1"].toString()),
//                     );
//                   },
//                 );
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }

// class User {
//   final String id, email, username;
//   User(this.id, this.email, this.username);
// }
// class Home extends StatefulWidget {
//   const Home({Key? key}) : super(key: key);

//   @override
//   State<Home> createState() => _HomeState();
// }

// class _HomeState extends State<Home> {
//   String dropdownvalue = "str1";
//   var ArrayForDropDown = ["str1", "str2", "str3"];
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Flight Overview'),
//         backgroundColor: Colors.blue[600],
//       ),
//       body: Container(
//         child: Column(children: [
//           Row(
//             children: [
//               DropdownButton(

//                   // Initial Value
//                   value: dropdownvalue,

//                   // Down Arrow Icon
//                   icon: const Icon(Icons.keyboard_arrow_down),

//                   // Array list of items
//                   items: ArrayForDropDown.map((String items) {
//                     return DropdownMenuItem(
//                       value: items,
//                       child: Text(items),
//                     );
//                   }).toList(),
//                   // After selecting the desired option,it will
//                   // change button value to selected value
//                   onChanged: (String? newValue) {
//                     setState(() {
//                       dropdownvalue = newValue!;
//                     });
//                   }),
//               DropdownButton(

//                   // Initial Value
//                   value: dropdownvalue,

//                   // Down Arrow Icon
//                   icon: const Icon(Icons.keyboard_arrow_down),

//                   // Array list of items
//                   items: ArrayForDropDown.map((String items) {
//                     return DropdownMenuItem(
//                       value: items,
//                       child: Text(items),
//                     );
//                   }).toList(),
//                   // After selecting the desired option,it will
//                   // change button value to selected value
//                   onChanged: (String? newValue) {
//                     setState(() {
//                       dropdownvalue = newValue!;
//                     });
//                   })
//             ],
//           ),
//         ]),
//       ),
//     );
//   }
// }
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(
    MaterialApp(
      title: 'Named Routes Demo',
      initialRoute: '/',
      routes: {
        '/': (context) => Home(),
        // '/home': (context) => Home(name: ,),
        // '/check': (context) => CheckScreen(),
      },
    ),
  );
}

// class FirstPage extends StatefulWidget {
//   const FirstPage({Key? key}) : super(key: key);

//   @override
//   State<FirstPage> createState() => _FirstPageState();
// }

// class _FirstPageState extends State<FirstPage> {
//   var name = "abhishek";
//   var integer = "abhi";
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Flight overview')),
//       body: ElevatedButton(
//         child: Text('clickm'),
//         onPressed: () {
//           Navigator.pushNamed(context, "/home",
//               arguments: {"name": name, "rollNo": integer});
//         },
//       ),
//     );
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
  String acessKey = '51004e258869bca39f6cbaf3501bec39';
  var test = [];
  // Future getdata() async {
  //   // List<User> users = [];
  //   var response = await http.get(Uri.parse(
  //       "http://api.aviationstack.com/v1/airports?access_key=$acessKey"));
  //   var jsonData = jsonDecode(response.body);
  //   // for (var u in jsonData["data"]) {
  //   //   User user = User(u['id'], u['gmt'], u['airport_id']);
  //   //   users.add(user);
  //   //   print(user.name);
  //   // }
  //   // print(users[0].name);
  //   for (var i in jsonData['data']) {
  //     test.add(i['airport_name']);
  //     // print(i["airport_name"]);
  //   }
  //   // print(test);

  //   // return users;
  //   return test;
  // }
  List? statesList;
  String? _myState;

  String stateInfoUrl =
      'http://api.aviationstack.com/v1/airports?access_key=51004e258869bca39f6cbaf3501bec39';
  Future<String> getData() async {
    await http.post(Uri.parse(stateInfoUrl)).then((response) {
      var data = json.decode(response.body);
      setState(() {
        statesList = data['data'];
      });
    });
    throw {print("error occured")};
  }

  var selectedAirport1 = "yes";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Flight overview')),
      body: Card(
        child: FutureBuilder(
          future: getData(),
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
                        selectedAirport1 = snapshot.data[index].toString();
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
    );
  }
}
