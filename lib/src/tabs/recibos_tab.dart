import 'package:flutter/material.dart';

class Recibos extends StatefulWidget {
  final List<Map<String, dynamic>> receipts;

  Recibos({required this.receipts});

  @override
  _RecibosState createState() => _RecibosState();
}

class _RecibosState extends State<Recibos> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.receipts.length,
      itemBuilder: (context, index) {
        final receipt = widget.receipts[index];
        return Container(
          margin: EdgeInsets.all(8.0),
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.red),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: ListTile(
            title: Text('Recibo ${index + 1}'),
            subtitle: Text(
              'Fecha: ${receipt['date']}\nModo de entrega: ${receipt['mode']}\nTotal: \$${receipt['total']}\nUsuario: ${receipt['correo_electronico']}',
            ),
          ),
        );
      },
    );
  }
}
