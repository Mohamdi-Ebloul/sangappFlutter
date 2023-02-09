import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:demna/api/api.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../HomePage.dart';
import 'Profile.dart';

class Ajoutedonneur extends StatefulWidget {
  const Ajoutedonneur({super.key});

  @override
  _AjoutedonneurState createState() => _AjoutedonneurState();
}

class _AjoutedonneurState extends State<Ajoutedonneur> {
  List posts = [];
  Future getPost() async {
    var url = 'https://banqsang.pythonanywhere.com/donor-list';
    var response = await http.get(Uri.parse(url));
    var responsebody = jsonDecode(response.body);
    setState(() {
      posts.addAll(responsebody);
    });
    print(posts);
  }

  @override
  void initState() {
    getPost();
    super.initState();
  }

  final _formKey = GlobalKey<FormState>();
  String Nom = '';
  String mobile = '';
  String date_naissance = '';
  String bloodgroup = 'A+';
  String address = 'Nouakchott';
  String password = "";
  late int id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Inscripter"),
          backgroundColor: Color.fromARGB(255, 199, 13, 0),
        ),
        bottomNavigationBar: CurvedNavigationBar(
          color: Color.fromARGB(255, 199, 13, 0),
          backgroundColor: Colors.blueAccent,
          items: <Widget>[
            Icon(Icons.home, size: 30),
          ],
          onTap: (index) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => HomePage(),
              ),
            );
          },
        ),
        body: Center(
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: "Nom",
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Veuillez entrer un nom";
                      }
                      return null;
                    },
                    onChanged: (value) {
                      setState(() {
                        Nom = value;
                      });
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: "Téléphone",
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Veuillez entrer un numéro de téléphone";
                      }
                      return null;
                    },
                    onChanged: (value) {
                      setState(() {
                        mobile = value;
                      });
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: "Date naissance",
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Veuillez entrer votre date_naissance";
                      }
                      return null;
                    },
                    onChanged: (value) {
                      setState(() {
                        date_naissance = value;
                      });
                    },
                  ),
                  TextFormField(
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: "Password",
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Veuillez entrer votre password";
                      }
                      return null;
                    },
                    onChanged: (value) {
                      setState(() {
                        password = value;
                      });
                    },
                  ),
                  Row(
                    children: [
                      DropdownButton(
                        value: bloodgroup,
                        items: [
                          DropdownMenuItem(
                            child: Text("A+"),
                            value: "A+",
                          ),
                          DropdownMenuItem(
                            child: Text("A-"),
                            value: "A-",
                          ),
                          DropdownMenuItem(
                            child: Text("B+"),
                            value: "B+",
                          ),
                          DropdownMenuItem(
                            child: Text("B-"),
                            value: "B-",
                          ),
                          DropdownMenuItem(
                            child: Text("O+"),
                            value: "O+",
                          ),
                          DropdownMenuItem(
                            child: Text("O-"),
                            value: "O-",
                          ),
                          DropdownMenuItem(
                            child: Text("AB+"),
                            value: "AB+",
                          ),
                          DropdownMenuItem(
                            child: Text("AB-"),
                            value: "AB-",
                          ),
                          // Ajouter les autres options de groupe sanguin ici
                        ],
                        onChanged: (value) {
                          setState(() {
                            bloodgroup = value!;
                          });
                        },
                      ),
                      Spacer(),
                      DropdownButton(
                        value: address,
                        items: [
                          DropdownMenuItem(
                            child: Text("Nouakchott"),
                            value: "Nouakchott",
                          ),
                          DropdownMenuItem(
                            child: Text("Hodh Ech Chargui"),
                            value: "Hodh Ech Chargui",
                          ),
                          DropdownMenuItem(
                            child: Text("Gorgol"),
                            value: "Gorgol",
                          ),
                          DropdownMenuItem(
                            child: Text("Assaba"),
                            value: "Assaba",
                          ),
                          DropdownMenuItem(
                            child: Text("Brakna"),
                            value: "Brakna",
                          ),
                          DropdownMenuItem(
                            child: Text("Hodh El Gharbi "),
                            value: "Hodh El Gharbi ",
                          ),
                          DropdownMenuItem(
                            child: Text("Trarza"),
                            value: "Trarza",
                          ),
                          DropdownMenuItem(
                            child: Text("Guidimaka"),
                            value: "Guidimaka",
                          ),
                          DropdownMenuItem(
                            child: Text("Nouadhibou"),
                            value: "Nouadhibou",
                          ),
                          DropdownMenuItem(
                            child: Text("Tagant"),
                            value: "Tagant",
                          ),
                          DropdownMenuItem(
                            child: Text("Adrar"),
                            value: "Adrar",
                          ),
                          DropdownMenuItem(
                            child: Text("Tiris Zemmour "),
                            value: "Tiris Zemmour ",
                          ),
                          DropdownMenuItem(
                            child: Text("Inchiri"),
                            value: "Inchiri",
                          ),

                          // Ajouter les autres options de groupe sanguin ici
                        ],
                        onChanged: (value) {
                          setState(() {
                            address = value!;
                          });
                        },
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromARGB(255, 199, 13, 0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                            ),
                          ),
                          child: Text(
                            'Enregistrer ',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                            ),
                          ),
                          onPressed: () async {
                            int index = 0;
                            String a = 'false';
                            while (index <= posts.length - 1) {
                              if (posts[index]['date_naissance'] ==
                                      date_naissance &&
                                  posts[index]['bloodgroup'] == bloodgroup) {
                                API.activedonor(posts[index]['id']);
                                API.Ajouter(
                                    Nom,
                                    mobile,
                                    address,
                                    bloodgroup,
                                    date_naissance,
                                    password,
                                    "${posts[index]['id']}");

                                pageRoue(
                                    "${posts[index]['Nom']}",
                                    "${posts[index]['mobile']}",
                                    "${posts[index]['date_naissance']}",
                                    "${posts[index]['bloodgroup']}",
                                    "${posts[index]['address']}",
                                    "${posts[index]['status']}",
                                    "${posts[index]['date']}");

                                a = 'true';

                                break;
                              }
                              index = index + 1;
                            }
                            if (a == 'false') {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text('Inscription ne pas valid'),
                                    content:
                                        Text('Ces Information ne pas correct'),
                                    actions: <Widget>[
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              Color.fromARGB(255, 199, 13, 0),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(18.0),
                                          ),
                                        ),
                                        child: Center(
                                          child: Text(
                                            'Ok ',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20.0,
                                            ),
                                          ),
                                        ),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }

  void pageRoue(
      String token,
      String mobile,
      String date_naissance,
      String bloodgroup,
      String address,
      String status,
      String lastdonat) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString("login", token);
    await pref.setString("mobile", mobile);
    await pref.setString("date_naissance", date_naissance);
    await pref.setString("bloodgroup", bloodgroup);
    await pref.setString("address", address);
    await pref.setString("status", status);
    await pref.setString("lastdonat", lastdonat);
    await pref.setInt("con", 1);
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => ProfilePage()),
        (route) => false);
  }
}

//profile
