class PostReported {
  final int userId;
  final String userName;
  final int postId;
  final String postTitle;
  final String reason;
  final String date;
  final String status;
  final String updatedAt;
  final String createdAt;
  final int id;

  PostReported({
    required this.userId,
    required this.userName,
    required this.postId,
    required this.postTitle,
    required this.reason,
    required this.date,
    required this.status,
    required this.updatedAt,
    required this.createdAt,
    required this.id,
  });

  // From JSON to PostReported object
  factory PostReported.fromJson(Map<String, dynamic> json) {
    return PostReported(
      userId: json['user_id'],
      userName: json['user_name'],
      postId: json['post_id'],
      postTitle: json['post_title'],
      reason: json['reason'],
      date: json['date'],
      status: json['status'],
      updatedAt: json['updated_at'],
      createdAt: json['created_at'],
      id: json['id'],
    );
  }

  // To JSON for sending the data to API
  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'user_name': userName,
      'post_id': postId,
      'post_title': postTitle,
      'reason': reason,
      'date': date,
      'status': status,
    };
  }
}
