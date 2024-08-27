import 'package:flutter/material.dart';

class SecondScreend extends StatefulWidget {
  const SecondScreend({super.key});

  @override
  State<SecondScreend> createState() => _SecondScreendState();
}

class _SecondScreendState extends State<SecondScreend> {

  bool _isSwitched = false;

  ThemeData _dark = ThemeData(brightness: Brightness.dark);
  ThemeData _light = ThemeData(brightness: Brightness.light);

  @override
  Widget build(BuildContext context) {
    String url = _isSwitched == false ? 'images/dark.jpg' : 'images/light.png';
    return MaterialApp(
      theme: _isSwitched ? _light : _dark,
      home: Scaffold(
          appBar: AppBar(
            title: Text('Example 1.2',
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold)),
            backgroundColor: const Color.fromARGB(255, 39, 135, 213),
          ),
          body: Container(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('Hello World ${_isSwitched ? 'Light' : 'Dark'}',
                    style: TextStyle(
                        color: _isSwitched ? Colors.black : Colors.white,
                        fontSize: 20,
                        fontFamily: 'NerkoOne-Regular')),
                ElevatedButton(
                    onPressed: () {},
                    child: Text('Click me'),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.amber,
                        foregroundColor: Colors.blue,
                        minimumSize: Size(200, 40))),
                Image(
                  image: AssetImage(
                      url),
                  width: 200,
                  height: 200,
                  fit: BoxFit.cover,
                ),
                DialogExample(),
                Switch(
                  value: _isSwitched,
                  onChanged: (bool value) {
                    setState(() {
                      _isSwitched = value;
                    });
                  },
                  activeColor: Colors.green,
                  inactiveThumbColor: Colors.white,
                  activeTrackColor: Colors.green.withOpacity(0.5),
                  inactiveTrackColor: Colors.white.withOpacity(0.5),
                )
              ],
            ),
          )),
    );
  }
}

class DialogExample extends StatelessWidget {
  const DialogExample({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Delete'),
          content: const Text('Do you want to delete this products'),
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
      ),
      child: const Text('Show Dialog'),
    );
  }
}
