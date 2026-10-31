class ServiceProvider {
  final String id;
  final String name;
  final String city;
  final String category;
  final double rating;
  final int reviews;
  final int pricePerHour;
  final bool verified;
  final String about;

  const ServiceProvider({
    required this.id,
    required this.name,
    required this.city,
    required this.category,
    required this.rating,
    required this.reviews,
    required this.pricePerHour,
    required this.verified,
    required this.about,
  });

  String get initials {
    final words = name.split(RegExp(r'\s+'));
    if (words.length == 1) {
      return words[0].substring(0, 1).toUpperCase();
    }
    return '${words.first.substring(0, 1)}${words.last.substring(0, 1)}'.toUpperCase();
  }
}
