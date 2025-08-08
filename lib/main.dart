import 'package:flutter/material.dart';

void main() {
  runApp(const OrderingPizza());
}

class OrderingPizza extends StatefulWidget {
  const OrderingPizza({super.key});

  @override
  State<OrderingPizza> createState() => _OrderingPizzaState();
}

class _OrderingPizzaState extends State<OrderingPizza> {
  final List<String> toppings = [
    'Cheese',
    'Pepperoni',
    'Mushrooms',
    'Olives',
    'Onions',
    'Bacon'
  ];
  final Set<String> selected = {};

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.yellow.shade700,
          brightness: Brightness.light,
        ),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Welcome to Dart Pizza'),
          backgroundColor: Colors.yellow.shade700,
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: toppings.map((topping){
              return CheckboxListTile(
                title: Text(topping),
                value: selected.contains(topping),
                onChanged: (bool? value) {
                  setState(() {
                    if (value == true) {
                      selected.add(topping);
                    } else {
                      selected.remove(topping);
                    }
                  });
                },
              );
            }).toList(),
          ),
        ),
        floatingActionButton: Builder(
          builder: (BuildContext context) {
            return FloatingActionButton(
              backgroundColor: Colors.yellow.shade700,
              onPressed: () {
                final text = selected.isEmpty
                  ? 'No toppings selected.'
                  : 'Toppings: ${selected.join(', ')}';
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
              },
              child: const Icon(Icons.check),
            );
          },
        ),


      ),
    );
  }
}