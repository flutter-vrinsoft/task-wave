import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:task_wave/core/error/exceptions.dart';
import 'package:task_wave/core/util/constants/app_strings.dart';

class NetworkService {
  NetworkService._();

  factory NetworkService() => _instance;
  static final NetworkService _instance = NetworkService._();

  final Dio dio = Dio();

  Future<void> init() async {
    final options = BaseOptions(
      baseUrl: NWConstants.baseUrl,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      headers: {
        "Content-Type": "application/json",
        "Authorization": AppStrings.authToken,
      },
      responseType: ResponseType.json,
      followRedirects: false,
      receiveDataWhenStatusError: true,
    );

    dio.options = options;
  }

  Future<T> post<T>(String url, {FormData? body, required T Function(Map<String, dynamic>)? fromJsonT}) async {
    try {
      if (body != null) {
        final data = body.fields.map((field) => "${field.key}:${field.value}").join('\n');
        logRequest('POST', url, data);
      }

      final response = await dio.post(url, data: body);
      logResponse('POST', url, response);
      return _returnResponse<T>(response, fromJsonT!);
    } catch (e) {
      return _handleError<T>(e, url);
    }
  }

  Stream get<T>(String url) async* {
    try {
      logRequest('GET', url, null);
      final response = await dio.get(url);
      logResponse('GET', url, response);
      yield response.data;
    } catch (e) {
      yield _handleError<T>(e, url);
    }
  }

  T _returnResponse<T>(Response response, T Function(Map<String, dynamic>) fromJsonT) {
    switch (response.statusCode) {
      case 200:
        final responseJson = json.decode(jsonEncode(response.data));

        return responseJson;
      case 400:
        throw BadRequestException();
      case 500:
      default:
        throw FetchDataException();
    }
  }

  T _handleError<T>(dynamic error, String url) {
    if (error is SocketException) {
      debugPrint('No internet connection');
      dynamic error = 'No internet connection';
      return error;
    } else if (error is DioException) {
      dynamic error = 'No internet connection';
      return error;
    } else {
      return error;
    }
  }

  void logRequest(String method, String url, String? queryParameters) {
    log(
      "\n>>>>>>>>>>>>>>>>[REQUEST]>>>>>>>>>>>>>>>>\n"
      "METHOD  ==> $method : $url \n"
      "Header  ==> ${dio.options.headers}\n"
      "Query    ==> ${queryParameters ?? 'No queryParameters'}\n"
      ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>",
    );
  }

  void logResponse(String method, String url, Response response) {
    log(
      "\n<<<<<<<<<<<<<<<[RESPONSE]<<<<<<<<<<<<<<<<\n"
      "METHOD     ==> $method : $url\n"
      "STATUS     ==> ${response.statusCode}\n"
      "BODY       ==> ${jsonEncode(response.data)}\n"
      "<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<",
    );
  }
}

class NWConstants {
  static const hostUrl = "https://api.todoist.com";
  static const version = "/rest/v2/";
  static const baseUrl = "$hostUrl$version";

  static const project = "projects";
  static const task = "tasks";

  static const paramProjectId = "project_id";
}
