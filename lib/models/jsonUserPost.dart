class JsonUserPost {
  JsonUserPost({
    this.date,
    this.guid,
    this.title,
    this.content,
    this.excerpt,
    this.featuredMedia,
    this.fimgUrl,
  });

  DateTime date;
  Content guid;
  Content title;
  Content content;
  Content excerpt;
  int featuredMedia;
  String fimgUrl;

  factory JsonUserPost.fromJson(Map<String, dynamic> json) => JsonUserPost(
        date: DateTime.parse(json["date"]),
        guid: Content.fromJson(json["guid"]),
        title: Content.fromJson(json["title"]),
        content: Content.fromJson(json["content"]),
        excerpt: Content.fromJson(json["excerpt"]),
        featuredMedia: json["featured_media"],
        fimgUrl: json["fimg_url"],
      );

  Map<String, dynamic> toJson() => {
        "date": date.toIso8601String(),
        "guid": guid.toJson(),
        "title": title.toJson(),
        "content": content.toJson(),
        "excerpt": excerpt.toJson(),
        "featured_media": featuredMedia,
        "fimg_url": fimgUrl,
      };
}

class Content {
  Content({
    this.rendered,
  });

  String rendered;

  factory Content.fromJson(Map<String, dynamic> json) => Content(
        rendered: json["rendered"],
      );

  Map<String, dynamic> toJson() => {
        "rendered": rendered,
      };
}
