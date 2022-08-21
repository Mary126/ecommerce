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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    SizedBox(
                      height: 350,
                      child: SingleChildScrollView(
                        child: FutureBuilder<Map<String, dynamic>>(
                            future: cart,
                            builder: (context, snapshot) {
                              return snapshot.hasData ? Column(
                                children: [
                                  for (int i = 0; i < snapshot.data!['basket'].length; i++)
                                    cartItem(
                                        snapshot.data!['basket'][i]['images'].toString(),
                                        snapshot.data!['basket'][i]['title'],
                                        snapshot.data!['basket'][i]['price'].toString()
                                    )
                                ],
                              ) : Container();
                            }
                        ),
                      )
                    ),
                    const Divider(color: Colors.white,),
                    FutureBuilder<Map<String, dynamic>>(
                        future: cart,
                        builder: (context, snapshot) {
                          return snapshot.hasData ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Padding(
                                    padding: EdgeInsets.only(top:10, bottom: 10),
                                    child: Text("Total", style: TextStyle(color: Colors.white, fontSize: 15),),
                                  ),
                                  Text("Delivery", style: TextStyle(color: Colors.white, fontSize: 15),),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const  EdgeInsets.only(top:10, bottom: 10),
                                    child: Text("\$${snapshot.data!['total'].toString()} us", style: const TextStyle(color: Colors.white, fontSize: 15),),
                                  ),
                                  Text(snapshot.data!['delivery'].toString(), style: const TextStyle(color: Colors.white, fontSize: 15),)
                                ],
                              )
                            ],
                          ) : Container();
                        }
                    ),
                    const Divider(color: Colors.white),
                    Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
                      child: ElevatedButton(
                        onPressed: () {

                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(ColorConstant.orangeColor),
                          minimumSize: MaterialStateProperty.all(const Size(double.infinity, 40)),
                        ),
                        child: const Text(
                          "Checkout",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        )
    );
  }
  Container cartItem(String imageUrl, String title, String price) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              SizedBox(
                  height: 60,
                  width: 60,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Image.network(
                      imageUrl,
                      fit: BoxFit.cover,
                    ),
                  )
              ),
              Container(
                margin: const EdgeInsets.only(left: 10, right: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w400),),
                    Text("\$$price", style: TextStyle(color: ColorConstant.orangeColor, fontSize: 20, fontWeight: FontWeight.w400),)
                  ],
                ),
              ),
            ],
          ),
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: const Color.fromRGBO(40, 40, 67, 1)
                ),
                margin: const EdgeInsets.only(right: 10),
                padding: const EdgeInsets.all(5),
                child: Column(
                  children: const[
                    Icon(Icons.remove, color: Colors.white, size: 15),
                    Text("2", style: TextStyle(color: Colors.white),),
                    Icon(Icons.add, color: Colors.white, size: 15,),
                  ],
                ),
              ),
              Image.asset("assets/images/bin.png")
            ],
          )
        ],
      ),
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