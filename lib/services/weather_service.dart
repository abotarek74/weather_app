import 'package:dio/dio.dart';
import 'package:weather_app/models/weather_model.dart';

class WeatherService {
  final Dio dio;

  final String baseUrl = 'https://api.weatherapi.com/v1';

  final String apiKay = '3d68df884c3640199e6215200240409';
  WeatherService(
    this.dio,
  );

  Future<WeatherModel> getCurrentWeather({required String cityName}) async {
    try {
      Response response = await dio
          .get('$baseUrl/forecast.json?key=$apiKay&q=$cityName&days=1');

      WeatherModel weatherModel = WeatherModel.fromjson(response.data);

      return weatherModel;
    } on DioException catch (e) {
      final String errorMessage = e.response?.data['error']['message'] ??
          'oops there was an error , try agian later';
      throw Exception(errorMessage);
    } catch (e) {
      throw Exception('oops there was an error , try later');
    }
  }
}
