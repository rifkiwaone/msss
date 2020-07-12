import 'package:flutter/material.dart';
import 'package:login/daftar.dart';
import 'package:login/isi.dart';
import 'package:login/login.dart';
import 'package:login/services/api.dart';
import 'dart:core';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      routes: <String, WidgetBuilder>{
        '/login': (BuildContext context) => new Login(),
        '/daftar': (BuildContext context) => new Daftar(),
      },
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: Login(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.token}) : super(key: key);

  final String token;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  ApiService apiService = ApiService();

  final List<Tab> tabs = <Tab>[
    Tab(
      icon: Icon(Icons.date_range),
    ),
    Tab(
      icon: Icon(Icons.star),
    ),
  ];

  TabController _tabController;

  List jadwal;

  @override
  void initState() {
    super.initState();
    apiService.jadwal(widget.token).then((value) {
      if (value["error"]) {
      } else {
        setState(() {
          jadwal = value["jadwal"];
        });
      }
    });
    _tabController = TabController(length: tabs.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Daftar Jadwal"),
        backgroundColor: Colors.blueGrey,
        // bottom: TabBar(
        //   controller: _tabController,
        //   tabs: tabs,
        // ),
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: <Color>[
                    Colors.blueGrey,
                    Colors.blueAccent[100],
                  ],
                ),
              ),
              child: Container(
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Icon(
                        Icons.date_range,
                        size: 50.0,
                      ),
                    ),
                    Text('Management Schedule')
                  ],
                ),
              ),
            ),
            new CustomListTile(Icons.today, 'Hari ini', () => {}),
            Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Colors.grey.shade400),
                ),
              ),
              child: RaisedButton(
                child: new CustomListTile(Icons.archive, 'Keluar', () => {}),
                color: Colors.white,
                splashColor: Colors.lightBlue,
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/login');
                },
                padding: const EdgeInsets.only(left: 1.0),
              ),
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Container(
              height: 20,
              margin: EdgeInsets.all(10.0),
              child: Row(
                children: <Widget>[
                  Icon(
                    Icons.today,
                  ),
                  SizedBox(
                    width: 5.0,
                  ),
                  Text(
                    "Hari Ini",
                    style: TextStyle(fontSize: 16.0),
                  )
                ],
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height - 120,
              child: ListView.builder(
                itemCount: jadwal.length,
                itemBuilder: (context, index) => FlatButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (ctx) => Isi(
                          token: widget.token,
                        ),
                      ),
                    );
                  },
                  child: Container(
                    margin: EdgeInsets.only(bottom: 8),
                    decoration: BoxDecoration(
                      color: Colors.blueGrey[100],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: EdgeInsets.all(10.0),
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              jadwal[index]["nama"],
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16.0,
                              ),
                            ),
                            Icon(
                              Icons.filter_list,
                              color: Colors.black,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Icon(Icons.date_range, color: Colors.black),
                            SizedBox(
                              width: 5.0,
                            ),
                            Text(
                              jadwal[index]["waktu"].substring(0, 10),
                              style: TextStyle(color: Colors.black),
                            ),
                            SizedBox(
                              width: 5.0,
                            ),
                            Icon(Icons.timelapse, color: Colors.black),
                            SizedBox(
                              width: 5.0,
                            ),
                            Text(
                              jadwal[index]["waktu"].substring(11, 16),
                              style: TextStyle(color: Colors.black),
                            ),
                            SizedBox(
                              width: 5.0,
                            ),
                            Icon(Icons.alarm, color: Colors.black),
                            SizedBox(
                              width: 5.0,
                            ),
                            Text(
                              "Alarm",
                              style: TextStyle(color: Colors.black),
                            ),
                            Icon(Icons.alarm, color: Colors.black),
                            Icon(
                              Icons.star,
                              color: Colors.black,
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (ctx) => Isi(
                token: widget.token,
              ),
            ),
          );
        },
        tooltip: 'Tekan',
        child: Icon(Icons.add),
        backgroundColor: Colors.blueGrey,
      ),
    );
  }
}

// ignore: must_be_immutable
class CustomListTile extends StatelessWidget {
  IconData icon;
  String text;
  Function onTap;

  CustomListTile(this.icon, this.text, this.onTap);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20.0, 0, 20.0, 0),
      child: Container(
        child: InkWell(
          splashColor: Colors.blueGrey,
          //onTap: onTap,
          child: Container(
            height: 50.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Icon(icon),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        text,
                        style: TextStyle(
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
