import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CatalogoTab extends StatefulWidget {
  @override
  _CatalogoTabState createState() => _CatalogoTabState();
}

class _CatalogoTabState extends State<CatalogoTab> {
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
      final response = await http
          .get(Uri.parse('http://localhost/mi_tienda/get_medicamentos.php'));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        setState(() {
          _items = data.cast<Map<String, dynamic>>();
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

    return ListView.builder(
      itemCount: _items.length,
      itemBuilder: (context, index) {
        final item = _items[index];
        String imageName =
            'product${index + 1}.jpg'; // Assuming images are named product1.jpg, product2.jpg, etc.

        return Container(
          margin: EdgeInsets.all(8.0),
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Colors.blue.shade100,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: ListTile(
            leading: Image.asset('assets/$imageName'),
            title: Text(item['nombre']),
            subtitle: Text('Precio: ${item['precio']}'),
          ),
        );
      },
    );
  }
}
