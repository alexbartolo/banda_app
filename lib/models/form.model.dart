class TestForm {
  String phone;
  String time;
  String date;
  String email;
  String checkbox;
  String dropdownValue;

  TestForm(
      {required this.phone,
      required this.time,
      required this.date,
      required this.email,
      required this.checkbox,
      required this.dropdownValue});

  Map<String, String> toJson() => {
        "phone": phone,
        "time": time,
        "date": date,
        "email": email,
        "checkbox": checkbox,
        "dropdownValue": dropdownValue,
      };
}
