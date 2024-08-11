import 'package:flutter/material.dart';

class BasketPage extends StatelessWidget {
  final List<String> basket;
  final Function(String) onRemove;
  final Function onCheckAvailability;

  const BasketPage({
    Key? key,
    required this.basket,
    required this.onRemove,
    required this.onCheckAvailability,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Basket'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: basket.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(basket[index]),
                  trailing: IconButton(
                    icon: Icon(Icons.remove_circle, color: Colors.red),
                    onPressed: () {
                      onRemove(basket[index]);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('${basket[index]} removed from basket')),
                      );
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BasketPage(
                            basket: basket,
                            onRemove: onRemove,
                            onCheckAvailability: onCheckAvailability,
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                onCheckAvailability(context);
              },
              child: Text('Check Availability'),
            ),
          ),
        ],
      ),
    );
  }
}

