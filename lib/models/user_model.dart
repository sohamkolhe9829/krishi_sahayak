import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String uid;
  final String name;
  final String email;
  final String profileURL;
  final List<DocumentReference> savedPosts;

  User({
    required this.uid,
    required this.name,
    required this.email,
    required this.profileURL,
    required this.savedPosts,
  });

  // Create a User object from a Firestore document snapshot
  factory User.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    return User(
      uid: snapshot.get('uid') as String,
      name: snapshot.get('name') as String,
      email: snapshot.get('email') as String,
      profileURL: snapshot.get('profileURL') as String,
      savedPosts: (snapshot.get('savedPosts') as List<dynamic>)
          .cast<String>()
          .map((postId) =>
              FirebaseFirestore.instance.collection('posts').doc(postId))
          .toList(),
    );
  }

  // Convert User object to a map for Firestore writes
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'profileURL': profileURL,
      'savedPosts': savedPosts.map((reference) => reference.id).toList(),
    };
  }
}
