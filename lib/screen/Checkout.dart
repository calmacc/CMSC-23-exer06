import 'package:flutter/material.dart';
import '../model/Item.dart';
import "package:provider/provider.dart";
import "../provider/shoppingcart_provider.dart";

class Checkout extends StatelessWidget {
  const Checkout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Checkout")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          getItems(context),
        ],
      ),
    );
  }

  Widget getItems(BuildContext context) {
    List<Item> products = context.watch<ShoppingCart>().cart;
    return products.isEmpty
        ? const Flexible(
            child: Column(
              children: [
                Text("Item Details"),
                Divider(height: 2, color: Colors.black),
                Text('No items to checkout!'),
              ],
            ) 
          )
        : Expanded(
            child: Column(
            children: [
              const Text("Item Details"),
              const Divider(height: 2, color: Colors.black),
              Flexible(
                child: ListView.builder(
                itemCount: products.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text(products[index].name),
                    trailing: Text("${products[index].price}"),
                  );
                },
              )),
              computeCost(),
              Flexible(
                child: Center(
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                  ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, "/products");
                        context.read<ShoppingCart>().removeAll();
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text("Payment Successful!"),
                          duration: Duration(seconds: 1, milliseconds: 100),
                        ));
                      },
                      child: const Text("Pay Now!")),
              ]))),
              ],
          ));
  }

  Widget computeCost() {
    return Consumer<ShoppingCart>(builder: (context, cart, child) {
       return Text("Total Cost to Pay: ${cart.cartTotal}");
    });
  }

}