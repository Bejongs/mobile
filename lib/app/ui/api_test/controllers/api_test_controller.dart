import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';

class ApiTestController extends GetxController {
  final isLoading = false.obs;

  final resultHttp = "".obs;
  final resultDio = "".obs;

  final timeHttp = 0.obs;
  final timeDio = 0.obs;

  final dio = Dio();

  final url = "https://restcountries.com/v3.1/name/indonesia";

  Future<void> testHttp() async {
    isLoading.value = true;
    final stopwatch = Stopwatch()..start();

    try {
      final response = await http.get(Uri.parse(url));
      resultHttp.value = response.body.substring(0, 100);
    } catch (e) {
      resultHttp.value = "Error: $e";
    }

    stopwatch.stop();
    timeHttp.value = stopwatch.elapsedMilliseconds;
    isLoading.value = false;
  }

  Future<void> testDio() async {
    isLoading.value = true;
    final stopwatch = Stopwatch()..start();

    try {
      final response = await dio.get(url);
      resultDio.value =
          response.data.toString().substring(0, 100);
    } catch (e) {
      resultDio.value = "Error: $e";
    }

    stopwatch.stop();
    timeDio.value = stopwatch.elapsedMilliseconds;
    isLoading.value = false;
  }
}
