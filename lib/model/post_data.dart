class PostData {
  String id, sourceId, description, title, attachmentName, attachmentURI, attachmentSize, createdAt, updatedAt;
  List<dynamic> reactions;
  bool isActive;
  
  PostData({
    this.id,
    this.attachmentName,
    this.attachmentSize,
    this.attachmentURI,
    this.createdAt,
    this.description,
    this.isActive,
    this.reactions,
    this.sourceId,
    this.updatedAt,
    this.title
  });

}