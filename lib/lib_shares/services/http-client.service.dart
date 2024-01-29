import 'dart:convert';

import 'package:http/http.dart' as http;

class GetResponse {
  final Map<String, dynamic> body;

  const GetResponse({required this.body});
}

class HttpClientService {
  //+ Instacia de dio
  // late Dio _dio;

  //+ Constructor nombrado
  HttpClientService._internal() {
    // _dio = Dio();
  }

  //+ Instancia única de la clase
  static final HttpClientService _httpClientService =
      HttpClientService._internal();

  //+ Getter para la instancia única
  static HttpClientService get httpClientService => _httpClientService;

  /// Realiza una solicitud GET a la URL especificada.
  ///
  /// [url] La URL a la que se realizará la solicitud.
  /// [queryParameters] Parámetros de consulta opcionales para la solicitud.
  /// [headers] Headerss de consulta opcionales para la solicitud.
  // Future<Response> _get(String url,
  //     {Map<String, dynamic>? queryParameters,
  //     Map<String, dynamic>? headers}) async {
  //   try {
  //     return await _dio.get(url,
  //         queryParameters: queryParameters,
  //         options: Options(
  //           headers: headers,
  //         ));
  //   } catch (e) {
  //     throw Exception(e);
  //   }
  // }

  /// Realiza una solicitud GET a la URL especificada.
  ///
  /// [url] La URL a la que se realizará la solicitud.
  /// [queryParameters] Parámetros de consulta opcionales para la solicitud.
  /// [headers] Headerss de consulta opcionales para la solicitud.
  Future<GetResponse> get(String url,
      {Map<String, String>? queryParameters,
      Map<String, String>? headers}) async {
    try {
      //+ Ejecutamos la request
      final response = await http.get(Uri.parse(url), headers: headers);

      //+ Parseamos la request
      return GetResponse(body: json.decode(response.body));
    } catch (e) {
      throw Exception(e);
    }
  }

  // /// Realiza una solicitud POST a la URL especificada con los datos proporcionados.
  // ///
  // /// [url] La URL a la que se realizará la solicitud POST.
  // /// [data] Los datos que se enviarán en el cuerpo de la solicitud.
  // /// [headers] Headerss de consulta opcionales para la solicitud.
  // Future<Response> post(String url,
  //     {Map<String, dynamic>? data, Map<String, dynamic>? headers}) async {
  //   try {
  //     return await _dio.post(url,
  //         data: data, options: Options(headers: headers));
  //   } catch (e) {
  //     throw Exception(e);
  //   }
  // }

  // /// Realiza una solicitud PATCH a la URL especificada con los datos proporcionados.
  // ///
  // /// [url] La URL a la que se realizará la solicitud PATCH.
  // /// [data] Los datos que se enviarán en el cuerpo de la solicitud.
  // /// [headers] Headerss de consulta opcionales para la solicitud.
  // Future<Response> patch(String url,
  //     {Map<String, dynamic>? data, Map<String, dynamic>? headers}) async {
  //   try {
  //     return await _dio.patch(url,
  //         data: data, options: Options(headers: headers));
  //   } catch (e) {
  //     throw Exception(e);
  //   }
  // }
}
