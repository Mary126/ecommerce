import 'package:flutter/material.dart';
import 'package:ecommerce/style.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreen();
}
class _CartScreen extends State<CartScreen> {
  late Future<Map<String, dynamic>> cart;
  @override
  void initState()
  {
    super.initState();
    cart = fetchCart();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          backgroundColor: ColorConstant.grayColor,
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () {
                        setState(() {
                          Navigator.pop(context);
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.only(top: 10, bottom: 10, left: 15, right: 15),
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(Radius.circular(5)),
                          color: ColorConstant.blueColor,
                        ),
                        child: Image.asset("assets/images/arrow_left.png"),
                      ),
                    ),
                    Row(
                      children: [
                        Text("Add address", style: TextStyle(color: ColorConstant.blueColor, fontWeight: FontWeight.w500),),
                        TextButton(
                          onPressed: () {

                          },
                          child: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(Radius.circular(5)),
                              color: ColorConstant.orangeColor,
                            ),
                            child: Image.asset("assets/images/location_white.png"),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.all(30),
                child: Text("My Cart", style: TextStyle(color: ColorConstant.blueColor, fontWeight: FontWeight.w700, fontSize: 35),),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(15)),
                  color: ColorConstant.blueColor,
                ),
                child: Column(
                  children: [
                    FutureBuilder<Map<String, dynamic>>(
                      future: cart,
                      builder: (context, snapshot) {
                        return snapshot.hasData ? Column(
                          children: [
                            for (int i = 0; i < snapshot.data!['basket'].length; i++) Container(
                              margin: const EdgeInsets.all(20),
                              child: Row(
                                children: [
                                  SizedBox(
                                    height: 60,
                                    width: 60,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10.0),
                                      child: Image.network(
                                        snapshot.data!['basket'][i]['images'].toString(),
                                        fit: BoxFit.cover,
                                      ),
                                    )
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(left: 10, right: 10),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(snapshot.data!['basket'][i]['title'], style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w500),),
                                        Text("\$${snapshot.data!['basket'][i]['price'].toString()}", style: TextStyle(color: ColorConstant.orangeColor, fontSize: 20, fontWeight: FontWeight.w500),)
                                      ],
                                    ),
                                  )

                                ],
                              ),
                            )
                          ],
                        ) : Container();
                      }
                    ),
                  ],
                ),
              )
            ],
          ),
        )
    );
  }
  Future<Map<String, dynamic>> fetchCart() async {
    final response = await http
        .get(Uri.parse('https://run.mocky.io/v3/53539a72-3c5f-4f30-bbb1-6ca10d42c149'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load');
    }
  }

}