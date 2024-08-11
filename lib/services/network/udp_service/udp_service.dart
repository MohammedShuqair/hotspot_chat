import 'dart:async';
import 'dart:io';

abstract class UDPService {
  final InternetAddress ipAddress;
  final int port;
  RawDatagramSocket? udpSocket;
  StreamController<Map<String, dynamic>> messageStreamController =
      StreamController.broadcast();

  UDPService({required this.ipAddress, required this.port});

  Future<void> initializeSocket();

  void sendMessage(String message, InternetAddress address);

  void initMessagesStreamController();
}
