import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal[100],
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text('Internet Power'),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Icon(Icons.signal_cellular_4_bar),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text('5G'),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Image.asset('assets/logo.jpg'), // Asegúrate de tener una imagen con el logo en la carpeta de assets
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () {},
                  child: Text('PRODUCTOS'),
                  style: ElevatedButton.styleFrom(
                    //primary: Colors.red, // Corregir aquí para establecer el color de fondo
                  ),
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: Text('INSCRIBIRSE'),
                  style: ElevatedButton.styleFrom(
                    //primary: Colors.red, // Corregir aquí para establecer el color de fondo
                  ),
                ),
              ],
            ),
            Expanded(
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text('NOSOTROS', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                    SizedBox(height: 20),
                    Container(
                      width: 200,
                      height: 300,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/logo.jpg'), // Asegúrate de tener una imagen del doctor en los assets
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {},
                      child: Text('LEER MÁS'),
                      style: ElevatedButton.styleFrom(
                        //primary: Colors.red, // Corregir aquí para establecer el color de fondo
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
