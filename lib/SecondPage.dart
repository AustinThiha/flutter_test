import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_weight_calculator/FileUtils.dart';

class SecondPage extends StatefulWidget {
  final String title = 'Second Page';

  SecondPage({Key key, title}) : super(key: key);

  @override
  SecondState createState() => SecondState();
}

class SecondState extends State<SecondPage> {
  String text = 'android dev';
  String getFromEdt;
  final amountEDTListener = TextEditingController();

  @override
  void dispose() {
    amountEDTListener.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '$text',
              style: Theme.of(context).textTheme.display1,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Show Bottom Sheet',
        child: Icon(Icons.add_to_queue),
        onPressed: () {
          _showModalSheet();
          setState(() {
            FileUtils.readFromFile().then((content) {
              setState(() {
                text = content;
              });
            });
          });
        },
      ),
    );
  }

  void _showModalSheet() {
    showModalBottomSheet(
        context: context,
        builder: (builder) {
          return Container(
            child: Column(
              children: <Widget>[
                TextField(
                  controller: amountEDTListener,
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    WhitelistingTextInputFormatter.digitsOnly
                  ],
                  decoration: InputDecoration(hintText: 'Enter amount'),
                ),
                RaisedButton(
                  child: new Text('save'),
                  onPressed: () {
                    setState(() {
                      FileUtils.saveToFile(amountEDTListener.text.toString());
//                      text = amountEDTListener.text.toString();
                      amountEDTListener.text = '';
                    });
                  },
                )
              ],
            ),
            padding: EdgeInsets.all(20.0),
          );
        });
  }
}
