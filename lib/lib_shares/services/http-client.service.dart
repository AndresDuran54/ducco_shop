import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http_interceptor/http_interceptor.dart';

class MyInterceptor implements InterceptorContract {
  final BuildContext context;

  MyInterceptor({required this.context});

  @override
  Future<RequestData> interceptRequest({required RequestData data}) async {
    return data;
  }

  @override
  Future<ResponseData> interceptResponse({required ResponseData data}) async {
    if (data.statusCode == 401) {
      print("401");
    }
    return data;
  }
}

class GetResponse {
  final Map<String, dynamic> body;

  const GetResponse({required this.body});
}

class PostResponse {
  final Map<String, dynamic> body;

  const PostResponse({required this.body});
}

class HttpClientService {
  //+ Referencia de Build Context
  late BuildContext context;

  //+ Cliente HTTP
  static late http.Client client;

  //+ Método para iniciar el cliente HTTP
  static start(BuildContext context) {
    //+ Inicializamos el cliente
    client = InterceptedClient.build(
      interceptors: [MyInterceptor(context: context)],
    );

    //+ Inicializamos la instancia Singleton
    _httpClientService = HttpClientService._internal(context);
  }

  //+ Constructor nombrado
  HttpClientService._internal(BuildContext context) {
    context = context;
  }

  //+ Instancia única de la clase
  static late HttpClientService _httpClientService;

  //+ Getter para la instancia única
  static HttpClientService get httpClientService => _httpClientService;

  /// Realiza una solicitud GET a la URL especificada.
  ///
  /// [url] La URL a la que se realizará la solicitud.
  /// [queryParameters] Parámetros de consulta opcionales para la solicitud.
  /// [headers] Headers de consulta opcionales para la solicitud.
  Future<GetResponse> get(String url,
      {Map<String, String>? queryParameters,
      Map<String, String>? headers}) async {
    try {
      //+ Ejecutamos la request
      final response = await client.get(Uri.parse(url), headers: headers);
      print("response");
      print(response.body);
      print("response");
      //+ Parseamos la request
      return GetResponse(body: json.decode(response.body));
    } catch (e) {
      throw Exception(e);
    }
  }

  /// Realiza una solicitud POST a la URL especificada con los datos proporcionados.
  ///
  /// [url] La URL a la que se realizará la solicitud POST.
  /// [data] Los datos que se enviarán en el cuerpo de la solicitud.
  /// [headers] Headers de consulta opcionales para la solicitud.
  Future<PostResponse> post(String url,
      {Map<String, String>? queryParameters,
      Map<String, String>? headers,
      Map<String, dynamic>? body}) async {
    //+ Ejecutamos la request
    final response = await http.post(Uri.parse(url),
        headers: headers, body: json.encode(body));

    if (response.statusCode != 200) {
      throw new HttpError(response.body);
    }

    //+ Parseamos la request
    return PostResponse(body: json.decode(response.body));
  }
}

class HttpError extends Error {
  final String data;

  HttpError(this.data);

  @override
  String toString() {
    return 'MiError: $data';
  }
}
