import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:http/http.dart' as http;
import 'login.dart';
import 'dart:convert';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

bool _obscureText = true;

class _RegisterState extends State<Register> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _surnameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _ageController = TextEditingController();
  bool _gender = true; // true para masculino, false para femenino

  String? _emailError;

  void registrar(String nombre, String apellidos, String correo, String clave,
      String direccion, int edad, bool sexo) async {
    try {
      final response = await http.post(
        Uri.parse('http://localhost/mi_tienda/register.php'),
        body: {
          'nombre': nombre,
          'apellidos': apellidos,
          'correo_electronico': correo,
          'contraseña': clave,
          'direccion': direccion,
          'edad': edad.toString(),
          'sexo': sexo ? '1' : '0',
        },
      );

      final responseData = json.decode(response.body);

      if (responseData["status"] == "success") {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Login()),
        );
      } else {
        setState(() {
          _emailError = responseData["message"];
        });
      }
    } catch (error) {
      setState(() {
        _emailError = 'Error de conexión: $error';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 50),
            Image.asset(
              'assets/logo.jpg',
              width: 180,
              height: 150,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Text(
                      "Registro",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                    SizedBox(height: 50),
                    TextFormField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        hintText: "Nombre",
                        prefixIcon: Icon(Icons.person),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Por favor ingresa un nombre';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      controller: _surnameController,
                      decoration: InputDecoration(
                        hintText: "Apellidos",
                        prefixIcon: Icon(Icons.person_outline),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Por favor ingresa los apellidos';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        hintText: "Correo Electrónico",
                        errorText: _emailError,
                        prefixIcon: Icon(Icons.email),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Por favor ingresa un correo electrónico';
                        } else if (!EmailValidator.validate(value)) {
                          return 'Por favor ingresa un correo electrónico válido';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      controller: _passwordController,
                      obscureText: _obscureText,
                      decoration: InputDecoration(
                        hintText: "Contraseña",
                        prefixIcon: Icon(Icons.lock),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscureText
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: Colors.grey,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscureText = !_obscureText;
                            });
                          },
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Por favor ingresa una contraseña';
                        } else if (value.length < 8) {
                          return 'La contraseña debe tener al menos 8 caracteres';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      controller: _addressController,
                      decoration: InputDecoration(
                        hintText: "Dirección",
                        prefixIcon: Icon(Icons.home),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Por favor ingresa una dirección';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      controller: _ageController,
                      decoration: InputDecoration(
                        hintText: "Edad",
                        prefixIcon: Icon(Icons.cake),
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Por favor ingresa la edad';
                        } else if (int.tryParse(value) == null) {
                          return 'Por favor ingresa un número válido';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 10),
                    DropdownButtonFormField<bool>(
                      value: _gender,
                      decoration: InputDecoration(
                        hintText: "Sexo",
                        prefixIcon: Icon(Icons.person),
                      ),
                      items: [
                        DropdownMenuItem(
                          child: Text("Masculino"),
                          value: true,
                        ),
                        DropdownMenuItem(
                          child: Text("Femenino"),
                          value: false,
                        ),
                      ],
                      onChanged: (value) {
                        setState(() {
                          _gender = value!;
                        });
                      },
                      validator: (value) {
                        if (value == null) {
                          return 'Por favor selecciona el sexo';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  registrar(
                    _nameController.text.toString(),
                    _surnameController.text.toString(),
                    _emailController.text.toString(),
                    _passwordController.text.toString(),
                    _addressController.text.toString(),
                    int.parse(_ageController.text.toString()),
                    _gender,
                  );
                }
              },
              child: Text("Registrarse"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => Login()),
                );
              },
              child: Text("Cancelar"),
            ),
          ],
        ),
      ),
    );
  }
}
