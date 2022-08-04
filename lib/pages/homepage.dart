

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';
import 'package:machinetest_3/pages/model.dart';
import 'package:machinetest_3/pages/product%20detailes.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future getdata()async{
    var res = await http.get(Uri.parse('https://fakestoreapi.com/products'));
    var jsonresponse =jsonDecode(res.body);
    List<product>products = [];
    for(var data in jsonresponse){
      product prod = product(title: data["title"], price: data["price"], category: data["category"], description: data["description"], image: data["image"]);
      products.add(prod);
    }
    return products;
    
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Product List'),
        ),
        body: Card(
          child: FutureBuilder(
            future: getdata(),
            builder: (context,AsyncSnapshot snapshot) {
            if(snapshot.data!=null){
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(snapshot.data[index].image),
                    ),
                    title: Text(snapshot.data[index].title),
                    subtitle: Column(
                      children: [
                        Text(snapshot.data[index].description),
                        Text(snapshot.data[index].category),
                        
                      ],
                    ),
                    trailing: Text('${snapshot.data[index].price}'),
                    onTap: () {
                      Navigator.push( context, MaterialPageRoute(builder: (context) {
                        return ProductDetails(products:product(title: snapshot.data[index].title,
                         category: snapshot.data[index].category,
                          description: snapshot.data[index].description,
                           image: snapshot.data[index].image,) );
                          
                      },));
                    }
    
                  );
                },
                
                );
            } else{
              return const Center(
                
                  child: Text('loding...........................................'),
                  
                    // child: Lottie.asset('assets/lottie/114099-loading-animator-flutter.json'),
                  
                );
              
            }
          },),
        ),
      ),
    );
  }
}