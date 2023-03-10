import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../applocal.dart';
import '../fix/appbarfix.dart';
import '../fix/drawerfix.dart';
import '../fix/navigation.dart';
import '../main.dart';

class raport extends StatefulWidget {
  @override
  _raportState createState() => _raportState();
}

class _raportState extends State<raport> {
  final _formKey = GlobalKey<FormState>();
  List posts = [];
  Future getPost() async {
    var url = 'https://banqsang.pythonanywhere.com/rapor/1/';
    var response = await http.get(Uri.parse(url));
    var responsebody = jsonDecode(response.body);
    setState(() {
      posts.addAll(responsebody);
    });
  }

  int nbr = 0;
  int idnb = 0;

  List postsnbr = [];

  Future getnbr() async {
    var url = 'https://banqsang.pythonanywhere.com/rapor/$id/';
    var response = await http.get(Uri.parse(url));
    var responsebody = jsonDecode(response.body);
    setState(() {
      postsnbr.addAll(responsebody);
      nbr = postsnbr.length;
    });
  }

  int nbrn = 0;
  int init = 0;
  List posts2 = [];

  Future getnbr2() async {
    var url = 'https://banqsang.pythonanywhere.com/nbr/$id/';
    var response = await http.get(Uri.parse(url));
    var responsebody = jsonDecode(response.body);
    setState(() {
      nbrn = int.parse(responsebody['nb']);
      init = responsebody['id'];
    });
  }

  @override
  void initState() {
    super.initState();
    getcred();
    getnbr();
    getnbr2();
    getPost();
  }

  void getcred() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      con = pref.getInt("con")!;
      id = pref.getInt("id")!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbarfix(
          title: '${getLang(context, "Raports_Médicaux")} ',
          i: nbr - nbrn,
          idnb: id,
          nb: nbr,
          init: init),
      drawer: drawerfix(),
      bottomNavigationBar: navigation(),
      body: Container(
        padding: EdgeInsets.all(10),
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                itemCount: posts.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            children: [
                              Expanded(
                                  child: Container(
                                child: Divider(
                                  color: Colors.black87,
                                ),
                              )),
                              Text(
                                "${posts[index]['date']}",
                                style: TextStyle(
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                              Expanded(
                                  child: Container(
                                child: Divider(
                                  color: Color.fromARGB(255, 0, 0, 0),
                                ),
                              )),
                            ],
                          ),
                          Text(
                            "${posts[index]['message']}",
                            style: TextStyle(
                              fontSize: 20.0,
                            ),
                          ),
                          SizedBox(
                            height: 5.0,
                          ),
                          InkWell(
                            child: Text(
                              "${posts[index]['pdf_file']}",
                              style: TextStyle(
                                color: Colors.red,
                                decoration: TextDecoration.underline,
                                fontSize: 20.0,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                            onTap: () {},
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
