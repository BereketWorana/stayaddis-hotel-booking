class ApiConfig {
  // Change this to match your environment:
  // Linux desktop: 'http://localhost:8080'
  // Android emulator: 'http://10.0.2.2:8080'
  // Chrome/web: 'http://localhost:8080'
  static const String baseUrl = 'http://localhost:8080';

  static const String hotelsEndpoint = '$baseUrl/api/hotels';
  static const String assetsBaseUrl = '$baseUrl/assets/images';

  static String hotelDetailEndpoint(dynamic id) =>
      '$baseUrl/api/hotels/$id';

  static String imageUrl(String path) => '$assetsBaseUrl/$path';
}