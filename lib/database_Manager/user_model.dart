class UserDM{
  static const String collectionName='users';
  String fullName;
  String id;
  String phone;
  String email;

  UserDM({
    required this.id,
    required this.fullName,
    required this.email,
    required this.phone
});

  UserDM.fromFirestore(Map<String,dynamic> user): this(
      id: user['id'],
      fullName: user['fullName'],
      phone: user['phone'],
    email: user['email']
  );

  Map<String,dynamic> toFirebase() =>{
    'id':id,
    'fullName': fullName,
    'email': email,
    'phone':phone
  };
}