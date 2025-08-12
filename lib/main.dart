import 'package:flutter/material.dart';

void main() {
  runApp(const OrderingPizza());
}

class OrderingPizza extends StatelessWidget {
  const OrderingPizza({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pizza Topping Chooser',
      debugShowCheckedModeBanner: false,
      home: const PizzaPage(),
    );
  }
}

class PizzaPage extends StatefulWidget {
  const PizzaPage({super.key});

  @override
  State<PizzaPage> createState() => _PizzaPageState();
}

class _PizzaPageState extends State<PizzaPage> {
  double basePrice = 5.0;

  Map<String, double> toppings = {
    'Cheese': 1.5,
    'Pepperoni': 2.0,
    'Mushrooms': 1.0,
    'Olives': 1.0,
    'Onions': 0.75,
    'Bacon': 2.5
  };
  
  List<String> selectedToppings = [];

  double get totalPrice {
    double toppingsTotal = 0.0;
    for (String topping in selectedToppings) {
      toppingsTotal += toppings[topping]!;
    }
    return basePrice + toppingsTotal;
  }

  void showOrderSummary() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Order Summary'),
        content: Column(
          children: [
            const Text('Base Pizza: \$5.00'),
            const SizedBox(height: 10),
            const Text('Toppings:'),
            for (String topping in selectedToppings)
              Text('- $topping: \$${toppings[topping]!.toStringAsFixed(2)}'),
            const SizedBox(height: 10),
            Text(
              'Total Price: \$${totalPrice.toStringAsFixed(2)}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            )
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          )
        ],
      ),
    );
  }

  void toggleTopping(String topping) {
    setState(() {
      if (selectedToppings.contains(topping)) {
        selectedToppings.remove(topping);
      } else {
        selectedToppings.add(topping);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow.shade100,
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: const Text('Welcome to Dart Pizza'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Choose your toppings:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView(
                children: toppings.keys.map((topping) {
                  return CheckboxListTile(
                    title: Text(
                      '$topping (\$${toppings[topping]!.toStringAsFixed(2)})',
                    ),
                    value: selectedToppings.contains(topping),
                    onChanged: (value) => toggleTopping(topping),
                    activeColor: Colors.amber,
                  );
                }).toList(),
              ),
            ),
            Text(
              'Total: \$${totalPrice.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.amber,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
                onPressed: showOrderSummary, 
                child: const Text(
                  'Finish Order',
                ),
              ),
            )
          ],
        ),
        ),
    );
  }
}
/// Add Price calculation
/// refactor widget structure like explained