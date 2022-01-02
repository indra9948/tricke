import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'dart:math';

import 'package:tricke/main.dart';

dynamic selected = '?';
var randomnumber;
int startnum = 0;
int endnum = 0;
var exceptnum = [];
TextEditingController _controller = TextEditingController();
List<int> selectednum = [1, 2, 3, 4, 5, 6, 7, 8, 9];
int temp = 0;
bool _isButtonDisabled = false;

void trickseatmain() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Generated App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: const Color(0xFF2196f3),
        accentColor: const Color(0xFF2196f3),
        canvasColor: const Color(0xFFfafafa),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.all(10),
                      width: 400,
                      child: TextField(
                        controller: _controller,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: '제외 번호',
                          hintText: '뽑기에서 뺄 번호를 넣으세요.',
                        ),
                        textAlign: TextAlign.center,
                        onEditingComplete: exceptNum,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(10),
                      width: 100,
                      child: TextField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: '끝 번호',
                          ),
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          onChanged: (Var) => endnum = int.parse(Var)),
                    ),
                    /*FlatButton(
                        key: null,
                        onPressed: ,
                        child: Text(
                          '입력 완료',
                          style: TextStyle(
                              fontSize: 12.0,
                              color: const Color(0xFF000000),
                              fontWeight: FontWeight.w200,
                              fontFamily: "Roboto"),
                        )),*/
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('제외된 번호: $exceptnum 번 / '),
                  Text('끝 번호: $endnum 번'),
                ],
              ),
              Text(
                '누가 뽑힐까?',
                style: TextStyle(
                    fontSize: 96.0,
                    color: const Color(0xFF000000),
                    fontWeight: FontWeight.w200,
                    fontFamily: "Roboto"),
              ),
              Text(
                '$selected',
                style: TextStyle(
                    fontSize: 136.0,
                    color: const Color(0xFF000000),
                    fontWeight: FontWeight.w200,
                    fontFamily: "Roboto"),
              ),
              FlatButton(
                key: null,
                color: Color.fromARGB(0, 0, 0, 0),
                child: Text(
                  '뽑기',
                  style: TextStyle(
                      fontSize: 48.0,
                      color: const Color(0xFF000000),
                      fontWeight: FontWeight.w200,
                      fontFamily: "Roboto"),
                ),
                onPressed: buttonPressed,
                //_isButtonDisabled ? buttonPressed : null,
                onLongPress: selectedPressed,
              ),
            ]),
        padding: const EdgeInsets.all(0.0),
      ),
    );
  }

  void exceptNum() {
    setState(() {
      exceptnum.clear();
        var tempnum = _controller.text.trim();
        var exceptlist = tempnum.split(",");
        for (var i = 0; exceptlist.length != i; i++) {
          exceptnum.add(int.parse(exceptlist[i]));
        }

    });
    //_isButtonDisabled = true;
  }

  void buttonPressed() {
    if (endnum == 0) {
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('AlertDialog Title'),
          content: const Text('AlertDialog description'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'Cancel'),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, 'OK'),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    } else {
      var tempselected;
      if (_controller.text != '') {
        exceptNum();
        do {
          tempselected = Random().nextInt(endnum) + 1;
        } while (exceptnum.contains(tempselected));
      } else {
        exceptnum.clear();
        tempselected = Random().nextInt(endnum) + 1;
      }
      setState(() {
        selected = tempselected;
      });
    }

  }

  void insertPressed() {
    setState(() {
      selected = Random().nextInt(endnum) + 1;
    });
  }

  void selectedPressed() {
    setState(() {
      selected = selectednum[temp];
      if (selectednum.length > temp + 1) {
        temp++;
      } else {
        temp = 0;
      }
    });
  }
}
