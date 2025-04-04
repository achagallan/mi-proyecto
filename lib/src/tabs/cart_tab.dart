import 'package:flutter/material.dart';

class CartTab extends StatefulWidget {
  final List<Map<String, dynamic>> cartItems;
  final Function(Map<String, dynamic>) onItemRemoved;
  final Function(String, double, String) onReceiptGenerated;

  CartTab({
    required this.cartItems,
    required this.onItemRemoved,
    required this.onReceiptGenerated,
  });

  @override
  _CartTabState createState() => _CartTabState();
}

class _CartTabState extends State<CartTab> {
  String deliveryMode = 'Pre-Compra'; // Default delivery mode

  double getTotalCost() {
    double total = 0.0;
    for (var item in widget.cartItems) {
      total += item['precio'];
    }
    return total;
  }

  void _removeItem(Map<String, dynamic> item) {
    setState(() {
      widget.cartItems.removeWhere((cartItem) => cartItem['id'] == item['id']);
      widget.onItemRemoved(item);
    });
  }

  void _generateReceipt() {
    double totalCost = getTotalCost();
    widget.onReceiptGenerated(
        deliveryMode, totalCost, DateTime.now().toString());
    setState(() {
      widget.cartItems.clear();
    });
  }

  void _toggleDeliveryMode() {
    setState(() {
      if (deliveryMode == 'Pre-Compra') {
        deliveryMode = 'Delivery';
      } else {
        deliveryMode = 'Pre-Compra';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: widget.cartItems.length,
            itemBuilder: (context, index) {
              final item = widget.cartItems[index];
              return ListTile(
                title: Text(item['nombre']),
                subtitle: Text('Precio: ${item['precio']}'),
                trailing: IconButton(
                  icon: Icon(Icons.remove_shopping_cart),
                  onPressed: () {
                    _removeItem(item);
                  },
                ),
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                onPressed: _toggleDeliveryMode,
                child: Text(deliveryMode),
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      deliveryMode == 'Delivery' ? Colors.green : Colors.blue,
                ),
              ),
              Text(
                'Total: \$${getTotalCost().toStringAsFixed(2)}',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              ElevatedButton(
                onPressed: _generateReceipt,
                child: Text('Pagar'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
