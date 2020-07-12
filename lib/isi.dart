import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'main.dart';
import 'services/api.dart';

class Isi extends StatefulWidget {
  final String token;

  const Isi({Key key, this.token}) : super(key: key);

  @override
  _IsiState createState() => _IsiState();
}

class _IsiState extends State<Isi> {
  ApiService apiService = ApiService();

  TextEditingController nama = TextEditingController();
  String waktu;

  final format = DateFormat("yyyy-MM-dd HH:mm");

  final dateFormat = DateFormat("EEEE, MMMM d, yyyy 'at' h:mma");
  final timeFormat = DateFormat("h:mm a");
  DateTime date;
  TimeOfDay time;

  bool proses = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Isi Jadwal'),
        backgroundColor: Colors.blueGrey,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: <Widget>[
            TextField(
              controller: nama,
              decoration: InputDecoration(hintText: 'Nama Jadwal'),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.mic),
                  SizedBox(
                    width: 20.0,
                  ),
                  Icon(Icons.call),
                  SizedBox(
                    width: 20.0,
                  ),
                  Icon(Icons.contact_phone),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Colors.grey),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(5),
              child: Column(
                children: <Widget>[
                  // Text('Pilih Waktu yang ingin anda gunakan'),
                  DateTimeField(
                    onChanged: (value) {
                      setState(() {
                        waktu = value.toString();
                      });
                    },
                    decoration: InputDecoration(
                      icon: Icon(Icons.date_range),
                      hintText: 'Pilih Waktu yang anda inginkan',
                    ),
                    format: format,
                    onShowPicker: (context, currentValue) async {
                      final date = await showDatePicker(
                          context: context,
                          firstDate: DateTime(1900),
                          initialDate: currentValue ?? DateTime.now(),
                          lastDate: DateTime(2100));
                      if (date != null) {
                        final time = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.fromDateTime(
                              currentValue ?? DateTime.now()),
                        );
                        return DateTimeField.combine(date, time);
                      } else {
                        return currentValue;
                      }
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: RaisedButton(
                child: proses
                    ? CircularProgressIndicator(
                        backgroundColor: Colors.white,
                      )
                    : Text(
                        'Simpan',
                        style: TextStyle(color: Colors.white),
                      ),
                color: Colors.blueGrey[300],
                splashColor: Colors.lightBlue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                onPressed: () {
                  setState(() {
                    proses = true;
                  });
                  apiService
                      .buatJadwal(widget.token, nama.text, waktu)
                      .then((value) {
                    setState(() {
                      proses = false;
                    });
                    if (value["error"]) {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text("Opps"),
                          content: SingleChildScrollView(
                            child: ListBody(
                              children: <Widget>[
                                Text(value["message"] + ", periksa data!"),
                              ],
                            ),
                          ),
                        ),
                      );
                    } else {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (ctx) => MyHomePage(
                                    token: widget.token,
                                  )));
                    }
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
