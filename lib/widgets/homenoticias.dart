class Noticias {
  String id;
  String name;
  String description;
  String url;
  String category;
  String language;
  String country;

  Noticias({
    required this.id,
    required this.name,
    required this.description,
    required this.url,
    required this.category,
    required this.language,
    required this.country,
  });

  factory Noticias.fromJson(Map<String, dynamic> json) {
    return Noticias(
      id: json['source']['id'] ?? '',
      name: json['source']['name'] ?? '',
      description: json['description'] ?? '',
      url: json['url'] ?? '',
      category: json['category'] ?? '',
      language: json['language'] ?? '',
      country: json['country'] ?? '',
    );
  }
}