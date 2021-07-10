class ContactModel {
  int phoneNumber;
  String name;
  String designation;
  bool isStore;
  bool isPeople;
  int id;
  ContactModel(
      {required this.designation,
      required this.name,
      required this.phoneNumber,
      required this.isStore,
      required this.isPeople,
      required this.id});
}
