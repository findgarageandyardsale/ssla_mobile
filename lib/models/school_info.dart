class SchoolInfo {
  final String name;
  final String philosophy;
  final String vision;
  final String description;
  final String address;
  final String phone;
  final String email;
  final String website;

  SchoolInfo({
    required this.name,
    required this.philosophy,
    required this.vision,
    required this.description,
    required this.address,
    required this.phone,
    required this.email,
    required this.website,
  });

  factory SchoolInfo.fromJson(Map<String, dynamic> json) {
    return SchoolInfo(
      name: json['name'] ?? '',
      philosophy: json['philosophy'] ?? '',
      vision: json['vision'] ?? '',
      description: json['description'] ?? '',
      address: json['address'] ?? '',
      phone: json['phone'] ?? '',
      email: json['email'] ?? '',
      website: json['website'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'philosophy': philosophy,
      'vision': vision,
      'description': description,
      'address': address,
      'phone': phone,
      'email': email,
      'website': website,
    };
  }
}
