import 'package:flutter/material.dart';
import 'package:login/daftar.dart';
import 'package:login/isi.dart';
import 'package:login/login.dart';
import 'package:login/Animation/FadeAnimation.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      routes: <String, WidgetBuilder>{
        '/tambah': (BuildContext context) => new Isi(),
        '/login': (BuildContext context) => new Login(),
        '/daftar': (BuildContext context) => new Daftar(),
        '/mainPage': (BuildContext context) => new MyApp(),
        // '/detailPage': (BuildContext context) => new DetailHomePage(),
        // '/pesanWorkspace': (BuildContext context) => new PesanWorkspace(),
        // '/editProfile': (BuildContext context) => new EditProfile()
      },
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: MyHomePage(
        title: 'Daftar Jadwal',
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  final List<Tab> tabs = <Tab>[
    Tab(
      icon: Icon(Icons.date_range),
    ),
    Tab(
      icon: Icon(Icons.star),
    ),
  ];

  TabController _tabController;

  @override
  void initState() {
    super.initState();
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
        title: Text(widget.title),
        backgroundColor: Colors.blueGrey,
        bottom: TabBar(
          controller: _tabController,
          tabs: tabs,
        ),
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
              child: new CustomListTile(
                Icons.assignment_late,
                'Terlambat',
                () => {},
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            new CustomListTile(Icons.help, 'Bantuan', () => {}),
            Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Colors.grey.shade400),
                ),
              ),
              child: new CustomListTile(
                Icons.share,
                'Bagikan',
                () => {},
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            new CustomListTile(Icons.settings, 'Pengaturan', () => {}),
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
                  Navigator.pushNamed(context, '/login');
                },
                padding: const EdgeInsets.only(left: 1.0),
              ),
            ),
          ],
        ),
      ),
      body: TabBarView(
        children: [
          Center(
            child: ListView(
              children: <Widget>[
                Container(
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
                FlatButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/tambah');
                  },
                  child: Container(
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
                              "Pertemuan 1",
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
                              "07/15/2020",
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
                              "06.20",
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
                            SizedBox(
                              width: 30.0,
                            ),
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
              ],
            ),
          ),
          Text('DATA'),
        ],
        controller: _tabController,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/tambah');
        },
        tooltip: 'Tekan',
        child: Icon(Icons.add),
        backgroundColor: Colors.blueGrey,
      ),
    );
  }
}

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
