class Customer {
  String id;
  String name;
  int age;
  String phone;

  Customer(this.id, this.name, this.age, this.phone);
}

class Authentication {
  Customer? customer;

  Authentication(this.customer);
}

class ResetPassword {
  String support;
  String contactUs;

  ResetPassword(this.support, this.contactUs);
}
