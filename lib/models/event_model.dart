class EventModel{
  String draw;
  int recordsTotal;
  int recordsFiltered;
  List<dynamic> data;

  EventModel();

  EventModel.fromSnapshot( Map<dynamic,dynamic> snapshot)
      : draw = snapshot["draw"],
        recordsTotal = snapshot["recordsTotal"],
        recordsFiltered = snapshot["recordsFiltered"],
        data = snapshot["data"];

  toJson() {
    return {
      "draw": draw,
      "recordsTotal": recordsTotal,
      "recordsFiltered": recordsFiltered,
      "data": data,
    };
  }
}