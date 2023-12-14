class PhotoItem {
  final int albumId;
  final int id;
  final String title;
  final String imageUrl;
  final String thumbnailImageUrl;

  PhotoItem(
      this.albumId, this.id, this.title, this.imageUrl, this.thumbnailImageUrl);

  PhotoItem.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        albumId = json['albumId'],
        title = json['title'],
        imageUrl = json['url'],
        thumbnailImageUrl = json['thumbnailUrl'];

  // Map<String, dynamic> toJson() {};
}
