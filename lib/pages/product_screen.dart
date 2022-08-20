import 'package:carousel_slider/carousel_slider.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:ecommerce/style.dart';
import 'package:http/http.dart' as http;


class ProductScreen extends StatefulWidget {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  State<ProductScreen> createState() => _ProductScreen();
}
class _ProductScreen extends State<ProductScreen> {
  late Future<Map<String, dynamic>> productItem;
  @override
  void initState()
  {
    super.initState();
    productItem = fetchProduct();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          backgroundColor: ColorConstant.grayColor,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton(
                    onPressed: () {
                      setState(() {
                        Navigator.pop(context);
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(Radius.circular(5)),
                        color: ColorConstant.blueColor,
                      ),
                      child: const Icon(Icons.arrow_back_ios, color: Colors.white,),
                    ),
                  ),
                  Text("Product Detailes", style: TextStyle(color: ColorConstant.blueColor, fontSize: 18),),
                  TextButton(
                      onPressed: () {
                        
                      },
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(Radius.circular(5)),
                        color: ColorConstant.orangeColor,
                      ),
                      child: Image.asset("assets/images/cart.png"),
                    ),
                  ),
                ],
              ),
              FutureBuilder<Map<String, dynamic>>(
                future: productItem,
                builder: (context, snapshot) {
                  return snapshot.hasData ? Column(
                    children: [
                      CarouselSlider(
                        options: CarouselOptions(
                          height: 300,
                          autoPlay: false,
                          enlargeCenterPage: true,
                          viewportFraction: 0.6,
                        ),
                        items: snapshot.data!['images'].map<Widget>((item) =>
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10.0),
                              child: Image.network(
                                item.toString(),
                                fit: BoxFit.cover,
                              ),
                            )
                        ).toList(),
                      )
                    ],
                  ) : Container();
                },
              ),
              FutureBuilder<Map<String, dynamic>>(
                future: productItem,
                builder: (context, snapshot) {
                  return snapshot.hasData ? Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      color: Colors.white,
                    ),
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(snapshot.data!['title'], style: TextStyle(fontWeight: FontWeight.w500, color: ColorConstant.blueColor, fontSize: 24),),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(Radius.circular(5)),
                                color: ColorConstant.blueColor,
                              ),
                              padding: const EdgeInsets.all(5),
                              child: Image.asset("assets/images/heart_white.png"),
                            )
                          ],
                        ),

                      ],
                    ),
                  ): Container();
                },
              )
            ],
          )
        )
    );
  }
  Future<Map<String, dynamic>> fetchProduct() async {
    final response = await http
        .get(Uri.parse('https://run.mocky.io/v3/6c14c560-15c6-4248-b9d2-b4508df7d4f5'));
    if (response.statusCode == 200) {

      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load');
    }
  }
}