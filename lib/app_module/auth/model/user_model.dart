class UserModel {
  String userName;
  String userEmail;
  String userPassword;
  String userToken;
  String userImage;
  String userId;
  String timestamp;

  UserModel({
    required this.userName,
    required this.userEmail,
    required this.userPassword,
    required this.userToken,
    required this.userImage,
    required this.userId,
    required this.timestamp,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      userName: map['user_name'],
      userEmail: map['user_email'],
      userPassword: map['user_password'],
      userToken: map['user_token'],
      userImage: map['user_image'],
      userId: map['user_id'],
      timestamp: map['timestamp'],
    );
  }
}
