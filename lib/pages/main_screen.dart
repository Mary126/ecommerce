import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:ecommerce/style.dart';
import 'package:http/http.dart' as http;
import 'package:ecommerce/constants.dart';
import 'package:ecommerce/pages/filter_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);
  @override
  State<MainScreen> createState() => MainScreenState();
}

class MainScreenState extends State<MainScreen> {
  late Future<List> hotSales;
  late Future<List> bestSeller;
  int currentHotSale = 0;
  bool showFilters = false;
  void _handleFilterScreen(bool newValue) {
    setState(() {
      showFilters = newValue;
    });
  }
  @override
  void initState()
  {
    super.initState();
    hotSales = fetchHotSales();
    bestSeller = fetchBestSeller();
  }
  List<Category> categories = [
    Category("Phones", "assets/images/phone.png", true),
    Category("Computer", "assets/images/computer.png", false),
    Category("Health", "assets/images/health.png", false),
    Category("Books", "assets/images/books.png", false),
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorConstant.mainBackground,
        body: Stack(
          children: [
            CustomScrollView(
                slivers: <Widget>[
                  SliverToBoxAdapter(
                    child: Container(
                      margin: const EdgeInsets.only(top: 10, bottom: 10),
                      child: Row(
                        children: [
                          const Spacer(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset('assets/images/location.png'),
                              Container(
                                margin: const EdgeInsets.only(left: 10, right: 10),
                                child: const Text("Zihuatanejo, Gro", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
                              ),
                              Image.asset('assets/images/arrow_down.png')
                            ],
                          ),
                          const Spacer(),
                          TextButton(
                            onPressed: () {
                              setState(() {
                                showFilters = true;
                              });
                            },
                            style: TextButton.styleFrom(
                              minimumSize: Size.zero,
                              padding: EdgeInsets.zero,
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            child: Container(
                              margin: const EdgeInsets.only(right: 10),
                              child: Image.asset('assets/images/filter.png'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Container(
                      margin: const EdgeInsets.only(left: 15, right: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Select Category", style: TextStyles.heavyMarkPro),
                          TextButton(
                              onPressed: () {

                              },
                              child: Text(
                                "view all",
                                style: TextStyle(color: ColorConstant.orangeColor),
                              )
                          )
                        ],
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        for (int i = 0; i < categories.length; i++)
                          TextButton(
                              onPressed: () {
                                changeCategory(i);
                              },
                              child: Column(
                                children: [
                                  Stack(
                                    children: [
                                      Container(
                                        width: 80,
                                        height: 80,
                                        decoration: BoxDecoration(
                                          color: categories[i].isSelected ? ColorConstant.orangeColor : Colors.white,
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                      Positioned.fill(
                                          child: Align(
                                            alignment: Alignment.center,
                                            child: Image.asset(
                                              categories[i].assetPath,
                                            ),
                                          )
                                      )
                                    ],
                                  ),
                                  Text(categories[i].name, style: TextStyle(
                                      color: categories[i].isSelected ? ColorConstant.orangeColor : Colors.black
                                  ),),
                                ],
                              )
                          ),
                      ],
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Container(
                      margin: const EdgeInsets.only(left: 15, right: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Hot Sales", style: TextStyles.heavyMarkPro),
                          TextButton(
                              onPressed: () {

                              },
                              child: Text(
                                "see more",
                                style: TextStyle(color: ColorConstant.orangeColor),
                              )
                          )
                        ],
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Container(
                        margin: const EdgeInsets.only(left: 15, right: 15),
                        height: 200,
                        child: FutureBuilder<List>(
                            future: hotSales,
                            builder: (context, snapshot) {
                              return snapshot.hasData ? PageView.builder(
                                  itemCount: snapshot.data?.length,
                                  pageSnapping: true,
                                  onPageChanged: (page) {
                                    setState(() {
                                      currentHotSale = page;
                                    });
                                  },
                                  itemBuilder: (context, pagePosition) {
                                    return Container(
                                        decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.all(Radius.circular(10)),
                                          image: DecorationImage(
                                            image: NetworkImage(snapshot.data![pagePosition]['picture']),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        child: Container(
                                          padding: const EdgeInsets.only(left: 20),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                                            children: [
                                              (snapshot.data![pagePosition]['is_new'] != null && snapshot.data![pagePosition]['is_new'] == true) ? Container(
                                                  width: 40,
                                                  height: 40,
                                                  decoration: BoxDecoration(
                                                    color: ColorConstant.orangeColor,
                                                    shape: BoxShape.circle,
                                                  ),
                                                  child: Container(
                                                    alignment: Alignment.center,
                                                    child: const Text(
                                                      "New", style: TextStyle(color: Colors.white),
                                                    ),
                                                  )
                                              ) : Container(),
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(snapshot.data![pagePosition]['title'], style: const TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.w700),),
                                                  Text(snapshot.data![pagePosition]['subtitle'], style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w400),)
                                                ],
                                              ),
                                              TextButton(
                                                  onPressed: () {

                                                  },
                                                  child: Container(
                                                      width: 120,
                                                      height: 30,
                                                      decoration: const BoxDecoration(
                                                        borderRadius: BorderRadius.all(Radius.circular(5)),
                                                        color: Colors.white,
                                                      ),
                                                      child: Container(
                                                        alignment: Alignment.center,
                                                        child: const Text("Buy now!", style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700),),
                                                      )
                                                  )
                                              ),

                                            ],
                                          ),
                                        )
                                    );
                                  }
                              ) : Container();
                            }
                        )
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Container(
                      margin: const EdgeInsets.only(left: 15, right: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Best Seller", style: TextStyles.heavyMarkPro),
                          TextButton(
                              onPressed: () {

                              },
                              child: Text(
                                "see more",
                                style: TextStyle(color: ColorConstant.orangeColor),
                              )
                          )
                        ],
                      ),
                    ),
                  ),
                  SliverPadding(
                    padding: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
                    sliver: FutureBuilder<List>(
                      future: bestSeller,
                      builder: (context, snapshot) {
                        return snapshot.hasData ? SliverGrid(
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 1.0,
                            ),
                            delegate: SliverChildBuilderDelegate((context, index) {
                              return Container(
                                  margin: const EdgeInsets.all(5),
                                  decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(15)),
                                    color: Colors.white,
                                  ),
                                  child: Stack(
                                    children: [
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Expanded(
                                            child: Image.network(snapshot.data![index]['picture'], fit: BoxFit.fitHeight,),
                                          ),
                                          Container(
                                            margin: const EdgeInsets.only(left: 15, right: 15, bottom: 10),
                                            child:  Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    Text("\$${snapshot.data![index]['price_without_discount']}", style: TextStyles.heavyMarkPro,),
                                                    Text("\$${snapshot.data![index]['discount_price']}", style: TextStyle(
                                                        color: ColorConstant.grayColor, fontWeight: FontWeight.w500, decoration: TextDecoration.lineThrough
                                                    ),)
                                                  ],
                                                ),
                                                Text(snapshot.data![index]['title'].toString(), style: const TextStyle(fontSize: 10),),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                      Positioned.fill(
                                          child: Align(
                                              alignment: Alignment.topRight,
                                              child: TextButton(
                                                  onPressed: () {
                                                  },
                                                  child: Stack(
                                                    children: [
                                                      Container(
                                                        width: 30,
                                                        height: 30,
                                                        decoration: const BoxDecoration(
                                                          color: Colors.white,
                                                          shape: BoxShape.circle,
                                                        ),
                                                      ),
                                                      Positioned.fill(
                                                          child: Image.asset(snapshot.data![index]['is_favorites'] ? 'assets/images/heart_filled.png' : 'assets/images/heart.png',)
                                                      ),
                                                    ],
                                                  )
                                              )
                                          )
                                      )
                                    ],
                                  )
                              );
                            },
                              childCount: snapshot.data!.length,
                            )
                        ) : SliverToBoxAdapter(
                          child: Container(),
                        );
                      },
                    ),
                  ),
                ]
            ),
            showFilters ? FilterScreen(onChanged: _handleFilterScreen) : Container(),
          ],
        )
      )
    );
  }
  changeCategory(int number) {
    for (Category i in categories) {
      setState(() {
        i.isSelected = false;
      });
    }
    setState(() {
      categories[number].isSelected = true;
    });
  }
  Future<List> fetchHotSales() async {
    final response = await http
        .get(Uri.parse('https://run.mocky.io/v3/654bd15e-b121-49ba-a588-960956b15175'));
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return jsonDecode(response.body)['home_store'];
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load');
    }
  }
  Future<List> fetchBestSeller() async {
    final response = await http
        .get(Uri.parse('https://run.mocky.io/v3/654bd15e-b121-49ba-a588-960956b15175'));
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return jsonDecode(response.body)['best_seller'];
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load');
    }
  }
}
