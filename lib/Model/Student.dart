// ignore_for_file: public_member_api_docs, sort_constructors_first
class Student {
  String? profile;
  String name;
  int classname;
  String address;
  String work;
  String? notes;
  int points;
  int? id;
  int phone;
  int ringnum;
  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'classname': classname,
        'phone': phone,
        'address': address,
        'ringnum': ringnum,
        'work': work,
        'notes': notes,
        'points': points,
        'profile': profile
      };
  String? get getNotes => this.notes;

  set setNotes(String? notes) => this.notes = notes;

  String? get getProfile => this.profile;

  set setProfile(String profile) => this.profile = profile;

  get getName => this.name;

  set setName(name) => this.name = name;

  get getClassname => this.classname;

  set setClassname(classname) => this.classname = classname;

  get getAddress => this.address;

  set setAddress(address) => this.address = address;

  get getWork => this.work;

  set setWork(work) => this.work = work;

  get getPoints => this.points;

  set setPoints(points) => this.points = points;

  get getId => this.id;

  set setId(id) => this.id = id;

  get getPhone => this.phone;

  set setPhone(phone) => this.phone = phone;

  get getRingnum => this.ringnum;

  set setRingnum(ringnum) => this.ringnum = ringnum;
  Student(
      {this.id,
      required this.profile,
      required this.name,
      required this.classname,
      required this.address,
      required this.work,
      required this.phone,
      required this.ringnum,
      required this.points,
      this.notes});

  @override
  String toString() {
    return 'Student(profile: $profile, name: $name, classname: $classname, address: $address, work: $work, notes: $notes, points: $points, id: $id, phone: $phone, ringnum: $ringnum)';
  }
}
