import 'package:flutter/material.dart';
import 'package:machinetest_3/pages/model.dart';

class ProductDetails extends StatelessWidget {
  
  final product products;
  const ProductDetails({Key? key, required this.products}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Center(child: Text('Product Details')),
      ),
      body: Column(
        children: [
          Text(products.title),
          Text(products.category),
          Image.network(products.image,
          
          ),
        const  Text('price'),
          ElevatedButton(onPressed: (){}, child:const Text('Buy now'))
          

        ],
      ),
    );
  }
}