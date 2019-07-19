import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  runApp(MaterialApp(
    title: "SharedPrefs",
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var _enterFieldController = TextEditingController();
  String _savedData = "";
  @override
  void initState() {
    super.initState();
    _loadSavedData();
  }

  _loadSavedData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      if (preferences.get('data') != null && preferences.getString('data').isNotEmpty){
        _savedData = preferences.getString('data');
      } else {
        _savedData = "Empty";
      }
    });
  }

  _saveMessage(String message) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('data', message);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Shared Prefs"),
        centerTitle: true,
        backgroundColor: Colors.greenAccent,
      ),
      body: Container(
        padding: const EdgeInsets.all(13.3),
        alignment: Alignment.topCenter,
        child: ListTile(
          title: TextField(
            controller: _enterFieldController,
            decoration: InputDecoration(
              labelText: "Enter something",
            ),
          ),
          subtitle: Padding(
            padding: const EdgeInsets.all(13.0),
            child: FlatButton(
                onPressed: () {
                    _saveMessage(_enterFieldController.text);
                },
                child: Column(
                  children: <Widget>[
                    Text(
                      "Save data",
                      style: TextStyle(
                        color: Colors.redAccent,
                        fontSize: 17.9,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(14.5),
                    ),
                    Text(
                      _savedData,
                    ),
                  ],
                )),
          ),
        ),
      ),
    );
  }
}
