class UserData {
  String? name;
  String? provider;
  String? email;
  String? photoUrl;

  UserData({required this.name,required this.provider,required this.email,required this.photoUrl});

  UserData.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    provider = json['provider'];
    email = json['email'];
    photoUrl = json['photoUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['provider'] = provider;
    data['email'] = email;
    data['photoUrl'] = photoUrl;
    return data;
  }
}