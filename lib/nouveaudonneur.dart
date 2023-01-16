import 'package:flutter/material.dart';
import 'package:mongo_dart/mongo_dart.dart' as dart_mongo;

class AddUserPage extends StatefulWidget {
  @override
  _AddUserPageState createState() => _AddUserPageState();
}

class _AddUserPageState extends State<AddUserPage> {
  final _formKey = GlobalKey<FormState>();
  String _name = "";
  String _phone = "";
  String _email = "";
  String _location = "";
  String _bloodType = "A+";
  String _errorMessage = "";
  String _lastDonation = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Ajouter un Donneur"),
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
                      hintText: "Nom",
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Veuillez entrer un nom";
                      }
                      return null;
                    },
                    onChanged: (value) {
                      setState(() {
                        _name = value;
                      });
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: "Téléphone",
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Veuillez entrer un numéro de téléphone";
                      }
                      return null;
                    },
                    onChanged: (value) {
                      setState(() {
                        _phone = value;
                      });
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: "Email",
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Veuillez entrer un email";
                      }
                      return null;
                    },
                    onChanged: (value) {
                      setState(() {
                        _email = value;
                      });
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: "Wilaya",
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Veuillez entrer une wilaya";
                      }
                      return null;
                    },
                    onChanged: (value) {
                      setState(() {
                        _location = value;
                      });
                    },
                  ),
                  DropdownButton(
                    value: _bloodType,
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
                        _bloodType = value!;
                      });
                    },
                  ),
                  TextField(
                    decoration: InputDecoration(
                      hintText: "Localisation",
                    ),
                    onChanged: (value) {
                      setState(() {
                        _location = value;
                      });
                    },
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          child: Text("Enregistrer"),
                          onPressed: () async {
                            if (_name.isEmpty ||
                                _bloodType.isEmpty ||
                                _lastDonation.isEmpty ||
                                _location.isEmpty) {
                              setState(() {
                                _errorMessage =
                                    "Veuillez remplir tous les champs";
                              });
                            } else {
                              // Enregistrer les informations de l'utilisateur dans MongoDB
                              var db = dart_mongo.Db(
                                  "mongodb://username:password@localhost/donors");
                              await db.open();
                              await db.collection("donors").insert({
                                "name": _name,
                                "tel": _phone,
                                "email": _email,
                                "lastDonation": _lastDonation,
                                "bloodType": _bloodType,
                                "location": _location
                              });
                              await db.close();
                              Navigator.pop(context);
                            }
                          },
                        ),
                        ElevatedButton(
                          child: Text("Anuler"),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
