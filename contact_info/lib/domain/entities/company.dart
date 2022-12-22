class Company {
  Company({
    required this.name,
    required this.catchPhrase,
    required this.bs,
  });

  factory Company.fromJson(Map<String, dynamic> json) => Company(
        name: json['name'].toString(),
        catchPhrase: json['catchPhrase'].toString(),
        bs: json['bs'].toString(),
      );

  final String name;
  final String catchPhrase;
  final String bs;

  Map<String, dynamic> toJson() => {
        'name': name,
        'catchPhrase': catchPhrase,
        'bs': bs,
      };
}
