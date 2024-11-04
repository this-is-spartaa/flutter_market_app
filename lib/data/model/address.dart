class Address {
  final int id;
  final String fullName;
  final String displayName;
  final bool? defaultYn;

  Address({
    required this.id,
    required this.fullName,
    required this.displayName,
    required this.defaultYn,
  });

  Address.fromJson(Map<String, dynamic> json)
      : this(
          id: json["id"],
          fullName: json["fullName"],
          displayName: json["displayName"],
          defaultYn: json["defaultYn"],
        );

  Map<String, dynamic> toJson() => {
        "id": id,
        "fullName": fullName,
        "displayName": displayName,
        "defaultYn": defaultYn,
      };
}
