// ignore_for_file: file_names

class UserDetails {
  UserDetails({
    required this.name,
    required this.email,
  });
  late final String name;
  late final String email;

  UserDetails.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['name'] = name;
    _data['email'] = email;
    return _data;
  }
}
