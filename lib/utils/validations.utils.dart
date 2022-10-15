RegExp timeRegExp = RegExp(r"^([0-1][0-9]|[2][0-3]):([0-5][0-9])$");
RegExp dateRegExp = RegExp(
    r"^(((0[1-9]|[12][0-9]|3[01])[- /.](0[13578]|1[02])|(0[1-9]|[12][0-9]|30)[- /.](0[469]|11)|(0[1-9]|1\d|2[0-8])[- /.]02)[- /.]\d{4}|29[- /.]02[- /.](\d{2}(0[48]|[2468][048]|[13579][26])|([02468][048]|[1359][26])00))$");
RegExp phoneRegExp = RegExp(r"^[7|9]{2}\d{6}$");
RegExp emailRegExp = RegExp(
    r"^[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?$");

String? validateTime(String? time) {
  return time!.isEmpty
      ? "Time cannot be blank."
      : time.length != 5
          ? "Time is not complete."
          : !timeRegExp.hasMatch(time)
              ? "Time is not valid."
              : null;
}

String? validateDate(String? date) {
  return date!.isEmpty
      ? "Date cannot be blank."
      : date.length != 10
          ? "Date is not complete."
          : !dateRegExp.hasMatch(date)
              ? "Date is not valid."
              : null;
}

String? validatePhone(String? phone) {
  return phone!.isEmpty
      ? "Phone cannot be blank."
      : phone.length != 8
          ? "Phone is not complete."
          : !phoneRegExp.hasMatch(phone)
              ? "Phone is not valid."
              : null;
}

String? validateEmail(String? email) {
  return email!.isEmpty
      ? "Email cannot be blank."
      : !emailRegExp.hasMatch(email)
          ? "Email is not valid."
          : null;
}

String? validateDropdown(String? dropdownOption) {
  return dropdownOption == null ? "Dropdown cannot be empty" : null;
}

String? validateName(String? name) {
  return name!.isEmpty ? "Name cannot be blank." : null;
}

String? validateText(String? text) {
  return text!.isEmpty ? "This field cannot be empty." : null;
}

//https://stackoverflow.com/questions/54925779/textformfield-validator-not-working-the-method-validate-was-called-on-null