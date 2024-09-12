enum Tags {
  vegetariano,
  vegano,
  parrilla,
  res,
  cordero,
  pollo,
  pescado,
  postre
}

class Plato {
  const Plato({
    required this.name,
    required this.description,
    required this.video,
    required this.previewImage,
    required this.coleccion,
    required this.cost,
    required this.rating,
    required this.ingredients,
    required this.steps,
    required this.images,
    required this.time,
    required this.tags,
  });

  final String name;
  final String description;
  final String video;
  final String previewImage;
  final String coleccion;
  final double cost;
  final double rating;
  final Map<String, int> ingredients;
  final List<String> steps;
  final List<String> images;
  final List<Tags> tags;
  final Duration time;

  // Convierte un objeto Plato a un mapa JSON
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'time': time.inMinutes,
      'video': video,
      'previewImage': previewImage,
      'coleccion': coleccion,
      'cost': cost,
      'rating': rating,
      'ingredients': ingredients,
      'steps': steps,
      'images': images,
      'tags': tags.map((tag) => tag.toString().split('.').last).toList(),
    };
  }

  // Crea un objeto Plato a partir de un mapa JSON
  factory Plato.fromJson(Map<String, dynamic> json) {
    return Plato(
      name: json['name'],
      description: json['description'],
      time: Duration(minutes: json['time']),
      video: json['video'],
      previewImage: json['previewImage'],
      coleccion: json['coleccion'],
      cost: json['cost'].toDouble(),
      rating: json['rating'].toDouble(),
      ingredients: Map<String, int>.from(json['ingredients']),
      steps: List<String>.from(json['steps']),
      images: List<String>.from(json['images']),
      tags: (json['tags'] as List)
          .map((tag) => Tags.values
              .firstWhere((e) => e.toString().split('.').last == tag))
          .toList(),
    );
  }
}
