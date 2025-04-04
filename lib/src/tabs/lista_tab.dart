import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Lista extends StatefulWidget {
  final List<Map<String, dynamic>> cartItems;
  final Function(Map<String, dynamic>) onItemAdded;
  final Function onCartCleared;

  Lista({
    required this.cartItems,
    required this.onItemAdded,
    required this.onCartCleared,
  });

  @override
  _ListaState createState() => _ListaState();
}

class _ListaState extends State<Lista> {
  List<Map<String, dynamic>> _items = [];
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _fetchItems();
  }

  void _fetchItems() async {
    try {
      final response =
          await http.get(Uri.parse('http://localhost/mi_tienda/get_stock.php'));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        setState(() {
          _items = data
              .map((item) => {
                    'id': item['id'],
                    'nombre': item['nombre'],
                    'precio': double.parse(item['precio'].toString()),
                  })
              .toList();
          _isLoading = false;
        });
      } else {
        setState(() {
          _isLoading = false;
          _error = 'Error: ${response.statusCode}';
        });
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
        _error = 'Error: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Center(child: CircularProgressIndicator());
    }

    if (_error != null) {
      return Center(child: Text(_error!));
    }

    return Column(
      children: [
        ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
          ),
          onPressed: () {
            setState(() {
              widget.cartItems.clear();
              widget.onCartCleared();
            });

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Carrito vaciado'),
                duration: Duration(seconds: 2),
              ),
            );
          },
          child: Text('Vaciar Carrito'),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: _items.length,
            itemBuilder: (context, index) {
              final item = _items[index];
              return Container(
                margin: EdgeInsets.all(8.0),
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Colors.blue.shade100,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: ListTile(
                  title: Text(item['nombre']),
                  subtitle: Text('Precio: ${item['precio']}'),
                  trailing: IconButton(
                    icon: Icon(Icons.add_shopping_cart),
                    color: Colors.blue,
                    onPressed: () {
                      widget.onItemAdded(item);
                    },
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
