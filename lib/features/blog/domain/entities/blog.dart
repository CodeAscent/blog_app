// ignore_for_file: public_member_api_docs, sort_constructors_first

class Blog {
  final String id;
  final String ownerId;
  final String title;
  final String content;
  final String? ownerName;
  final String imageUrl;
  final List<String> tags;
  final DateTime updatedAt;

  Blog(
      {required this.id,
      required this.ownerId,
      required this.title,
      required this.content,
      required this.imageUrl,
      required this.tags,
      required this.updatedAt,
      this.ownerName});
}
