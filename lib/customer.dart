class Customer {
  String name;
  int partySize;

  int getPartySize() {
    return partySize;
  }

  String getName() {
    return name;
  }

  Customer(String name, int partySize) {
    this.name = name;
    this.partySize = partySize;
  }
}
