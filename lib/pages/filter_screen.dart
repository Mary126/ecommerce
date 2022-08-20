import 'package:ecommerce/style.dart';
import 'package:ecommerce/constants.dart';
import 'package:flutter/material.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({
    super.key,
    required this.onChanged,
  });

  final ValueChanged<bool> onChanged;

  @override
  State<FilterScreen> createState() => _FilterScreen();
}
class _FilterScreen extends State<FilterScreen> {
  void closeScreen() {
    widget.onChanged(false);
  }
  FilterSelections filterSelections = FilterSelections();
  late FilterSelectionModel currentBrand;
  late FilterSelectionModel currentPrice;
  late FilterSelectionModel currentSize;
  @override
  void initState()
  {
    super.initState();
    currentBrand = filterSelections.brandDropdown[0];
    currentPrice = filterSelections.priceDropdown[0];
    currentSize = filterSelections.sizeDropdown[0];
  }
  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            color: Colors.transparent,
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(15)),
                color: Colors.white,
              ),
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      TextButton(
                        onPressed: () {
                          setState(() {
                            closeScreen();
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(Radius.circular(5)),
                            color: ColorConstant.blueColor,
                          ),
                          child: const Icon(Icons.close, color: Colors.white,),
                        ),
                      ),
                      Text("Filter options", style: TextStyle(color: ColorConstant.blueColor, fontSize: 18),),
                      TextButton(
                          onPressed: () {

                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(Radius.circular(5)),
                              color: ColorConstant.orangeColor,
                            ),
                            padding: const EdgeInsets.only(top: 5, bottom: 5, left: 10, right: 10),
                            child: const Text("Done", style: TextStyle(color: Colors.white, fontSize: 18),),
                          )
                      ),
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.all(30),
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Brand", style: TextStyle(color: ColorConstant.blueColor, fontSize: 18),),
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(Radius.circular(5)),
                            border: Border.all(color: Colors.grey),
                          ),
                          padding: const EdgeInsets.only(left: 5, right: 5),
                          child: DropdownButton<FilterSelectionModel>(
                            value: currentBrand,
                            items: filterSelections.brandDropdown.map((FilterSelectionModel i) {
                              return DropdownMenuItem<FilterSelectionModel>(
                                value: i,
                                child: Text(i.name),
                              );
                            }).toList(),
                            onChanged: (FilterSelectionModel? newValue) {
                              setState(() {
                                currentBrand = newValue!;
                              });
                            },
                            icon: const Icon(Icons.keyboard_arrow_down),
                            isExpanded: true,
                            underline: Container(),
                          ),
                        ),
                        Text("Price", style: TextStyle(color: ColorConstant.blueColor, fontSize: 18)),
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(Radius.circular(5)),
                            border: Border.all(color: Colors.grey),
                          ),
                          padding: const EdgeInsets.only(left: 5, right: 5),
                          child: DropdownButton<FilterSelectionModel>(
                            value: currentPrice,
                            items: filterSelections.priceDropdown.map((FilterSelectionModel i) {
                              return DropdownMenuItem<FilterSelectionModel>(
                                value: i,
                                child: Text(i.name),
                              );
                            }).toList(),
                            onChanged: (FilterSelectionModel? newValue) {
                              setState(() {
                                currentPrice = newValue!;
                              });
                            },
                            icon: const Icon(Icons.keyboard_arrow_down),
                            isExpanded: true,
                            underline: Container(),
                          ),
                        ),
                        Text("Size", style: TextStyle(color: ColorConstant.blueColor, fontSize: 18)),
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(Radius.circular(5)),
                            border: Border.all(color: Colors.grey),
                          ),
                          padding: const EdgeInsets.only(left: 5, right: 5),
                          child: DropdownButton<FilterSelectionModel>(
                            value: currentSize,
                            items: filterSelections.sizeDropdown.map((FilterSelectionModel i) {
                              return DropdownMenuItem<FilterSelectionModel>(
                                value: i,
                                child: Text(i.name),
                              );
                            }).toList(),
                            onChanged: (FilterSelectionModel? newValue) {
                              setState(() {
                                currentSize = newValue!;
                              });
                            },
                            icon: const Icon(Icons.keyboard_arrow_down),
                            isExpanded: true,
                            underline: Container(),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}