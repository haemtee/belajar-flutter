// import 'package:anmovie/application_color.dart';

import 'package:anmovie/balance.dart';
import 'package:anmovie/cart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:provider/provider.dart';

void main() {
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider<Money>(
            create: (context) => Money(),
          ),
          ChangeNotifierProvider<Cart>(
            create: (context) => Cart(),
          ),
        ],
        child: Scaffold(
          floatingActionButton: Consumer<Money>(
            builder: (context, money, child) => Consumer<Cart>(
              builder: (context, cart, child) => FloatingActionButton(
                onPressed: (() {
                  if (money.balance >= 500) {
                    cart.quantity++;
                    money.balance = money.balance - 500;
                  }
                }),
                child: const Icon(Icons.shopping_cart),
              ),
            ),
          ),
          appBar: AppBar(
            title: const Text('Multi Provider State Management'),
            backgroundColor: Colors.pink.shade300,
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Balance',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Container(
                      margin: const EdgeInsets.all(5),
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.pink.shade100,
                          border: Border.all(
                              color: Colors.pink,
                              style: BorderStyle.solid,
                              width: 2)),
                      width: 100,
                      height: 30,
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Consumer<Money>(
                          builder: (context, money, child) {
                            return Text(money.balance.toString(),
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold));
                          },
                        ),
                      ),
                    )
                  ],
                ),
                Container(
                  margin: const EdgeInsets.all(5),
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                          color: Colors.black,
                          style: BorderStyle.solid,
                          width: 2)),
                  width: 300,
                  height: 30,
                  child: Consumer<Cart>(
                    builder: (context, cart, child) => Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Apple 500 x ${cart.quantity}',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            (cart.quantity * 500).toString(),
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ]),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
