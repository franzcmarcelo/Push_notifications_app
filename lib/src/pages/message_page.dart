import 'package:flutter/material.dart';

class MessagePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final arg = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text('Message Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Argumento Nombre:', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.indigoAccent),),
            SizedBox(height: 10.0),
            Text(arg, style: TextStyle(fontSize: 18.0),)
          ],
        ),
      ),
    );
  }
}