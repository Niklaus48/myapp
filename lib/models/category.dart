
class Category {
  final String slug;
  final String name;
  final String url;

  Category({
    required this.slug,
    required this.name,
    required this.url,
  });

  factory Category.fromJson(String jsonString) {
    // Remove the curly braces and split the string by comma
    String cleaned = jsonString.replaceAll('{', '').replaceAll('}', '');
    Map<String, String> parts = {};
    
    cleaned.split(',').forEach((part) {
      var keyValue = part.split(':');
      if (keyValue.length == 2) {
        String key = keyValue[0].trim().replaceAll('slug:', '').replaceAll('name:', '').replaceAll('url:', '');
        String value = keyValue[1].trim();
        parts[key] = value;
      }
    });

    return Category(
      slug: parts['slug'] ?? '',
      name: parts['name'] ?? '',
      url: parts['url'] ?? '',
    );
  }
}
