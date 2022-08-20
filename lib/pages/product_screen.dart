import 'package:carousel_slider/carousel_slider.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:ecommerce/style.dart';
import 'package:http/http.dart' as http;
import 'package:ecommerce/constants.dart';


class ProductScreen extends StatefulWidget {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  State<ProductScreen> createState() => _ProductScreen();
}
class _ProductScreen extends State<ProductScreen> {
  late Future<Map<String, dynamic>> productItem;
  List<bool> colorSelected = [];
  List<bool> memorySelected = [];
  List<ProductInfo> productInfoCategories = [
    ProductInfo("Shop", true),
    ProductInfo("Details", false),
    ProductInfo("Features", false),
  ];
  changeInfoCategory(int number) {
    for (ProductInfo i in productInfoCategories) {
      setState(() {
        i.isSelected = false;
      });
    }
    setState(() {
      productInfoCategories[number].isSelected = true;
    });
  }

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
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      color: Colors.white,
                    ),
                    padding: const EdgeInsets.all(25),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          child: Row(
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
                        ),
                        Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          child: StarRating(5, snapshot.data!['rating'], const Color.fromRGBO(255, 184, 0, 1), ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              for (int i = 0; i < productInfoCategories.length; i++)
                                GestureDetector(
                                  child: Container(
                                    decoration: productInfoCategories[i].isSelected ? BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(width: 5, color: ColorConstant.orangeColor)
                                        )
                                    ) : const BoxDecoration(),
                                    child: Text(productInfoCategories[i].name, style: productInfoCategories[i].isSelected ? TextStyle(
                                        color: ColorConstant.blueColor,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 20
                                    ) : const TextStyle(
                                        color: Colors.grey,
                                        fontSize: 20
                                    ),),
                                  ),
                                  onTap: () {
                                    changeInfoCategory(i);
                                  },
                                )
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(bottom: 10, top: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                  children: [
                                    Image.asset("assets/images/processor.png"),
                                    Text(snapshot.data!['CPU'].toString(), style: TextStyle(color: ColorConstant.grayColor2, fontSize: 11))
                                  ]
                              ),
                              Column(
                                children: [
                                  Image.asset("assets/images/camera.png"),
                                  Text(snapshot.data!['camera'].toString(), style: TextStyle(color: ColorConstant.grayColor2, fontSize: 11),)
                                ],
                              ),
                              Column(
                                children: [
                                  Image.asset("assets/images/ram.png"),
                                  Text(snapshot.data!['ssd'].toString(), style: TextStyle(color: ColorConstant.grayColor2, fontSize: 11),)
                                ],
                              ),
                              Column(
                                children: [
                                  Image.asset("assets/images/memory.png"),
                                  Text(snapshot.data!['sd'].toString(), style: TextStyle(color: ColorConstant.grayColor2, fontSize: 11),)
                                ],
                              ),
                            ],
                          )
                        ),
                        Container(
                          margin: const EdgeInsets.only(bottom: 10, top: 10),
                          child: Text("Select color and capacity", style: TextStyle(color: ColorConstant.blueColor, fontSize: 16),),
                        ),
                        Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  for (int i = 0; i < snapshot.data!['color'].length; i++) TextButton(
                                    onPressed: () {
                                      for (int j = 0; j < colorSelected.length; j++) {
                                        setState(() {
                                          colorSelected[j] = false;
                                        });
                                      }
                                      setState(() {
                                        colorSelected[i] = true;
                                      });
                                    },
                                    style: TextButton.styleFrom(
                                      minimumSize: Size.zero,
                                      padding: const EdgeInsets.all(5),
                                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                    ),
                                    child: Container(
                                        height: 40,
                                        width: 40,
                                        decoration: BoxDecoration(
                                          color: Color(snapshot.data!['color'][i]),
                                          shape: BoxShape.circle,
                                        ),
                                        child: colorSelected[i] ? const Icon(Icons.check, color: Colors.white,) : Container()
                                    ),
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  for (int i = 0; i < snapshot.data!['capacity'].length; i++) TextButton(
                                    onPressed: () {
                                      for (int j = 0; j < memorySelected.length; j++) {
                                        setState(() {
                                          memorySelected[j] = false;
                                        });
                                      }
                                      setState(() {
                                        memorySelected[i] = true;
                                      });
                                    },
                                    style: TextButton.styleFrom(
                                      minimumSize: Size.zero,
                                      padding: EdgeInsets.zero,
                                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                    ),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: memorySelected[i] ? ColorConstant.orangeColor : Colors.white,
                                        borderRadius: const BorderRadius.all(Radius.circular(5)),
                                      ),
                                      padding: const EdgeInsets.only(top: 5, bottom: 5, right: 10, left: 10),
                                      child: Text(snapshot.data!['capacity'][i] + ' gb', style: TextStyle(
                                          color: memorySelected[i] ? Colors.white : Colors.grey
                                      ),),
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),

                        TextButton(
                          onPressed: () {

                          },
                          style: TextButton.styleFrom(
                            minimumSize: Size.zero,
                            padding: EdgeInsets.zero,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              color: ColorConstant.orangeColor,
                              borderRadius: const BorderRadius.all(Radius.circular(5)),
                            ),
                            padding: EdgeInsets.all(15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                const Text("Add to Cart", style: TextStyle(color: Colors.white, fontSize: 20),),
                                Text("\$${snapshot.data!["price"]}", style: const TextStyle(color: Colors.white, fontSize: 20),)
                              ],
                            )
                          ),
                        )

                      ],
                    ),
                  ): Container();
                },
              ),

            ],
          )
        )
    );
  }
  Future<Map<String, dynamic>> fetchProduct() async {
    final response = await http
        .get(Uri.parse('https://run.mocky.io/v3/6c14c560-15c6-4248-b9d2-b4508df7d4f5'));
    if (response.statusCode == 200) {
      Map<String, dynamic> res = jsonDecode(response.body);
      for (int i = 0; i < res['color'].length; i++) {
        final buffer = StringBuffer();
        if (res['color'][i].length == 6 || res['color'][i].length == 7) buffer.write('ff');
        buffer.write(res['color'][i].replaceFirst('#', ''));
        res['color'][i] = int.parse(buffer.toString(), radix: 16);
        colorSelected.add(false);
      }
      colorSelected[0] = true;
      for (int i = 0; i < res['capacity'].length; i++) {
        memorySelected.add(false);
      }
      memorySelected[0] = true;
      return res;
    } else {
      throw Exception('Failed to load');
    }
  }
}

class StarRating extends StatelessWidget {
  final int starCount;
  final double rating;
  final Color color;

  const StarRating(this.starCount, this.rating, this.color);

  Widget buildStar(BuildContext context, int index) {
    Icon icon;
    if (index >= rating) {
      icon = Icon(
        Icons.star_border,
        color: color,
      );
    }
    else if (index > rating - 1 && index < rating) {
      icon = Icon(
        Icons.star_half,
        color: color,
      );
    } else {
      icon = Icon(
        Icons.star,
        color: color,
      );
    }
    return InkResponse(
      child: icon,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(children: List.generate(starCount, (index) => buildStar(context, index)));
  }
}