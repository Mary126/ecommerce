class Category {
  String name = "";
  String assetPath = "";
  bool isSelected = false;
  Category(this.name, this.assetPath, this.isSelected);
}
class ProductInfo {
  String name = "";
  bool isSelected = false;
  ProductInfo(this.name, this.isSelected);
}
class FilterSelectionModel {
  String name = "";
  FilterSelectionModel(this.name);
}
class FilterSelections {
  List<FilterSelectionModel> brandDropdown = [
    FilterSelectionModel("Samsung"),
    FilterSelectionModel("Apple"),
  ];
  List<FilterSelectionModel> priceDropdown = [
    FilterSelectionModel("\$0 - \$500"),
    FilterSelectionModel("\$500 - \$10000")
  ];
  List<FilterSelectionModel> sizeDropdown = [
    FilterSelectionModel("4.5 to 5.5 inches"),
    FilterSelectionModel("5.5 to 5.9 inches")
  ];
}