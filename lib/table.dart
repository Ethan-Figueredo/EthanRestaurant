import 'menu.dart';

class Table1 {
  int seats;
  List<Menu> foodBill = [];
  bool clean;
  int name;
  Table1(int name, int seats) {
    this.seats = seats;
    this.clean = true;
    this.name = name;
  }
  int getSeats() {
    return seats;
  }

  bool getClean() {
    return clean;
  }
}
