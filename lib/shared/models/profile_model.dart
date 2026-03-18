class ProfileModel {
  final String name;
  final String email;
  final String createdAt;

  ProfileModel({
    required this.name,
    required this.email,
    required this.createdAt
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
    name: json['name'],
    email: json['email'],
    createdAt: _formatDate(json['created_at']),
  );

  static String _formatDate(String isoDate) {
    final date = DateTime.parse(isoDate);
    return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
  }
}