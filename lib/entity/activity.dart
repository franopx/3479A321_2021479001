
class Activity {

  int id;
  String date;
  String name;

  Activity(this.id, this.date, this.name);


  Map<String, Object?> toMap() {
    return {'id': id, 'date': date, 'name': name};
  }
}