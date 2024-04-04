import 'package:blog_app/features/blog/domain/entities/blog.dart';

class BlogModel extends Blog {
  BlogModel({
    required super.id,
    required super.ownerId,
    required super.title,
    required super.content,
    required super.imageUrl,
    required super.tags,
    required super.updatedAt,
    super.ownerName,
  });
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'owner_id': ownerId,
      'title': title,
      'content': content,
      'image_url': imageUrl,
      'tags': tags,
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  factory BlogModel.fromJson(Map<String, dynamic> map) {
    return BlogModel(
      id: map['id'] as String,
      ownerId: map['owner_id'] as String,
      title: map['title'] as String,
      content: map['content'] as String,
      imageUrl: map['image_url'] as String,
      tags: List<String>.from(map['tags'] ?? []),
      updatedAt: map['updated_at'] == null
          ? DateTime.now()
          : DateTime.parse(map['updated_at'] as String),
    );
  }
  BlogModel copyWith({
    String? id,
    String? ownerId,
    String? title,
    String? content,
    String? imageUrl,
    String? ownerName,
    List<String>? tags,
    DateTime? updatedAt,
  }) {
    return BlogModel(
      id: id ?? this.id,
      ownerId: ownerId ?? this.ownerId,
      title: title ?? this.title,
      content: content ?? this.content,
      ownerName: ownerName ?? this.ownerName,
      imageUrl: imageUrl ?? this.imageUrl,
      tags: tags ?? this.tags,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
