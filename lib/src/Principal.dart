import 'package:flutter/material.dart';
import 'tabs/lista_tab.dart';
import 'tabs/cart_tab.dart';
import 'tabs/recibos_tab.dart';
import 'tabs/catalogo_tab.dart';
import 'tabs/user_tab.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Principal extends StatefulWidget {
  final Map<String, dynamic> userData;

  Principal({required this.userData});

  @override
  _PrincipalState createState() => _PrincipalState();
}

class _PrincipalState extends State<Principal> {
  int _selectedIndex = 0;
  final List<Map<String, dynamic>> cartItems = [];
  final List<Map<String, dynamic>> receipts = [];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _addItemToCart(Map<String, dynamic> item) {
    setState(() {
      cartItems.add({
        ...item,
        'modo': 'Pre-Compra',
        'nombreUsuario': widget.userData['Nombre']
      });
    });
  }

  void _clearCart() {
    setState(() {
      cartItems.clear();
    });
  }

  void _removeItemFromCart(Map<String, dynamic> item) {
    setState(() {
      cartItems.removeWhere((cartItem) => cartItem['id'] == item['id']);
    });
  }

  Future<void> _generateReceipt(String mode, double total, String date) async {
    final response = await http.post(
      Uri.parse('http://localhost/mi_tienda/add_receipt.php'),
      body: {
        'correo_electronico': widget.userData['correo_electronico'],
        'mode': mode,
        'total': total.toStringAsFixed(2),
        'date': date,
      },
    );

    if (response.statusCode == 200) {
      setState(() {
        receipts.add({
          'mode': mode,
          'total': total.toStringAsFixed(2),
          'date': date,
          'nombreUsuario': widget.userData['correo_electronico']
        });
      });
    } else {
      // Manejar error
    }
  }

  Future<void> _fetchRecibos() async {
    final response = await http.post(
      Uri.parse('http://localhost/mi_tienda/get_receipts.php'),
      body: {'correo_electronico': widget.userData['correo_electronico']},
    );

    if (response.statusCode == 200) {
      setState(() {
        receipts.addAll(
            List<Map<String, dynamic>>.from(json.decode(response.body)));
      });
    } else {
      // Manejar error
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchRecibos();
  }

  void _checkout() {
    setState(() {
      receipts.addAll(cartItems);
      cartItems.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          'assets/logo.jpg',
          height: 50,
        ),
        backgroundColor: Colors.white,
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          Lista(
            cartItems: cartItems,
            onItemAdded: _addItemToCart,
            onCartCleared: _clearCart,
          ),
          CartTab(
            cartItems: cartItems,
            onItemRemoved: _removeItemFromCart,
            onReceiptGenerated: _generateReceipt,
          ),
          Recibos(receipts: receipts),
          CatalogoTab(),
          UserTab(userData: widget.userData),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.store), label: 'Store'),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart), label: 'Cart'),
          BottomNavigationBarItem(icon: Icon(Icons.receipt), label: 'Recibos'),
          BottomNavigationBarItem(
              icon: Icon(Icons.category), label: 'Catálogo'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'User'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.black,
        selectedIconTheme: IconThemeData(color: Colors.red),
        unselectedIconTheme: IconThemeData(color: Colors.black),
        onTap: _onItemTapped,
      ),
    );
  }
}
