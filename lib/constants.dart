class Category {
  String name = "";
  String assetPath = "";
  bool isSelected = false;
  Category(this.name, this.assetPath, this.isSelected);
}
class HotSale {
  int id = 0;
  String title = "";
  String subtitle = "";
  String picture = "";
  HotSale(this.id, this.title, this.subtitle, this.picture);
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