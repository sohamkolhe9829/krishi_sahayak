import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String ownerName;
  final String ownerProfile;
  final String postId;
  final String ownerId;

  final DateTime dateTime;
  final String content;
  final List imageUrls;
  final List likes;
  final List<Comment> comments;

  Post({
    required this.ownerName,
    required this.postId,
    required this.ownerProfile,
    required this.ownerId,
    required this.dateTime,
    required this.content,
    required this.imageUrls,
    required this.likes,
    required this.comments,
  });

  // Create a Post object from a Firestore document snapshot
  factory Post.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    return Post(
      ownerName: snapshot.get('ownerName') as String,
      postId: snapshot.get('postId') as String,
      ownerProfile: snapshot.get('ownerProfile') as String,
      ownerId: snapshot.get('ownerId') as String,
      dateTime: (snapshot.get('dateTime') as Timestamp).toDate(),
      content: snapshot.get('content') as String,
      imageUrls: (snapshot.get('imageUrls') as List<dynamic>).cast<String>(),
      likes: snapshot.get('likes') as List<String>,
      comments: (snapshot.get('comments') as List<dynamic>)
          .cast<Map<String, dynamic>>()
          .map((comment) => Comment.fromMap(comment))
          .toList(),
    );
  }

  // Convert Post object to a map for Firestore writes
  Map<String, dynamic> toMap() {
    return {
      'ownerName': ownerName,
      'ownerProfile': ownerProfile,
      'postId': postId,
      'ownerId': ownerId,
      'dateTime': Timestamp.fromDate(dateTime),
      'content': content,
      'imageUrls': imageUrls,
      'likes': likes,
      'comments': comments.map((comment) => comment.toMap()).toList(),
    };
  }
}

// Nested Comment model class (optional)
class Comment {
  final String content;
  final String commenterId;
  final String ownerName;
  final String ownerProfile;
  final DateTime dateTime;

  Comment({
    required this.content,
    required this.ownerName,
    required this.ownerProfile,
    required this.commenterId,
    required this.dateTime,
  });

  // Create a Comment object from a map (for firestore data)
  factory Comment.fromMap(Map<String, dynamic> data) {
    return Comment(
      content: data['content'] as String,
      ownerName: data['ownerName'] as String,
      ownerProfile: data['ownerProfile'] as String,
      commenterId: data['commenterId'] as String,
      dateTime: (data['dateTime'] as Timestamp).toDate(),
    );
  }

  // Convert Comment object to a map for Firestore writes
  Map<String, dynamic> toMap() {
    return {
      'content': content,
      'commenterId': commenterId,
      'ownerProfile': ownerProfile,
      'ownerName': ownerName,
      'dateTime': Timestamp.fromDate(dateTime),
    };
  }
}
