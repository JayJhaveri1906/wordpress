class Registermodel {
  Registermodel({
    this.id,
    this.email,
    this.roles,
    this.links,
  });

  int id;
  String email;
  List<String> roles;
  Links links;

  factory Registermodel.fromJson(Map<String, dynamic> json) => Registermodel(
        id: json["id"],
        email: json["email"],
        roles: List<String>.from(json["roles"].map((x) => x)),
        links: Links.fromJson(json["_links"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "roles": List<dynamic>.from(roles.map((x) => x)),
        "_links": links.toJson(),
      };
}

class Links {
  Links({
    this.self,
    this.collection,
  });

  List<Collection> self;
  List<Collection> collection;

  factory Links.fromJson(Map<String, dynamic> json) => Links(
        self: List<Collection>.from(
            json["self"].map((x) => Collection.fromJson(x))),
        collection: List<Collection>.from(
            json["collection"].map((x) => Collection.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "self": List<dynamic>.from(self.map((x) => x.toJson())),
        "collection": List<dynamic>.from(collection.map((x) => x.toJson())),
      };
}

class Collection {
  Collection({
    this.href,
  });

  String href;

  factory Collection.fromJson(Map<String, dynamic> json) => Collection(
        href: json["href"],
      );

  Map<String, dynamic> toJson() => {
        "href": href,
      };
}
