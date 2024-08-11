import 'package:flutter/material.dart';

class DataResponse<T> {
  DataStatus status;
  T? data;
  String? message;

  DataResponse.loading({this.message}) : status = DataStatus.LOADING;

  DataResponse.more({this.message, this.data}) : status = DataStatus.MORE;

  DataResponse.completed(this.data, {this.message})
      : status = DataStatus.COMPLETED;

  DataResponse.error({this.message}) : status = DataStatus.ERROR;

  @override
  String toString() {
    return "Status : $status \n message : $message \n Data : $data";
  }

  when({required Widget Function() loading,
    required Widget Function(String message) error,
    required Widget Function(T? data) completed}) {
    switch (status) {
      case DataStatus.LOADING:
        return loading();
      case DataStatus.COMPLETED || DataStatus.MORE:
        return completed(data);
      case DataStatus.ERROR:
        return error(message ?? 'error');
      default:
        return loading();
    }
  }
}

enum DataStatus { LOADING, COMPLETED, ERROR, MORE }
