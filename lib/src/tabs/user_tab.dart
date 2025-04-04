import 'package:flutter/material.dart';

class UserTab extends StatelessWidget {
  final Map<String, dynamic> userData;

  UserTab({required this.userData});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.person,
            size: 100,
            color: Colors.grey,
          ),
          Container(
            padding: EdgeInsets.all(16.0),
            margin: EdgeInsets.symmetric(horizontal: 40.0),
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Nombre: ${userData['Nombre'] ?? 'N/A'}',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                Text(
                  'Apellidos: ${userData['Apellidos'] ?? 'N/A'}',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                Text(
                  'Correo Electrónico: ${userData['correo_electronico'] ?? 'N/A'}',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                Text(
                  'Dirección: ${userData['direccion'] ?? 'N/A'}',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                Text(
                  'Edad: ${userData['edad'] ?? 'N/A'}',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                Text(
                  'Sexo: ${userData['sexo'] == true ? 'Masculino' : 'Femenino'}',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
