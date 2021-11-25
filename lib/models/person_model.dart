class PersonFields {
  static List<String> values = [
    /// Add all fields
    id, firstName, lastName, phoneNo, mailId, fav
  ];

  static const String id = 'id';
  static const String firstName = 'firstName';
  static const String lastName = 'lastName';
  static const String phoneNo = 'phoneNo';
  static const String mailId = 'mailId';
  static const String fav = 'fav';
}

class Person {
  String firstName;
  String lastName;
  String phoneNo;
  String mailId;
  String fav;

  int id;
  Person(
    this.firstName,
    this.lastName,
    this.phoneNo,
    this.mailId,
    this.fav,
    this.id,
  );

  get getFirstName => this.firstName;

  set setFirstName(firstName) => this.firstName = firstName;

  get getLastName => this.lastName;

  set setLastName(lastName) => this.lastName = lastName;

  get getPhoneNo => this.phoneNo;

  set setPhoneNo(phoneNo) => this.phoneNo = phoneNo;

  get getMailId => this.mailId;

  set setMailId(mailId) => this.mailId = mailId;
  get getFav => this.fav;

  set setFav(fav) => this.fav = fav;

  get getId => this.id;

  set setId(id) => this.id = id;

  Person copy({
    String? firstName,
    String? lastName,
    String? phoneNo,
    String? mailId,
    String? fav,
    int? id,
  }) =>
      Person(firstName ?? this.firstName, lastName ?? this.lastName,
          phoneNo ?? this.phoneNo, mailId ?? this.mailId, fav ?? this.fav  ,id ?? this.id);

  static Person fromJson(Map<String, dynamic?> json) => Person(
        json[PersonFields.firstName] as String,
        json[PersonFields.lastName] as String,
        json[PersonFields.phoneNo] as String,
        json[PersonFields.mailId] as String,
        json[PersonFields.fav] as String,
        json[PersonFields.id] as int,
      );
  Map<String, Object?> toJson() => {
        PersonFields.id: id,
        PersonFields.firstName: firstName,
        PersonFields.lastName: lastName,
        PersonFields.phoneNo: phoneNo,
        PersonFields.mailId: mailId,
        PersonFields.fav :fav
      };
}
