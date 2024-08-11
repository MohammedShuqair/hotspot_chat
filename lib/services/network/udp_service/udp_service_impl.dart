import 'dart:convert';
import 'dart:io';

import 'udp_service.dart';

class UDPServiceImpl extends UDPService {
  RawDatagramSocket? udpSocket;

  bool get isInitialized => udpSocket != null;

  UDPServiceImpl({required super.ipAddress, required super.port});

  @override
  Future<void> initializeSocket() async {
    udpSocket ??= await RawDatagramSocket.bind(ipAddress.address, port);
  }

  @override
  void initMessagesStreamController() async {
    await initializeSocket();
    print("init stream");
    udpSocket?.listen((RawSocketEvent event) {
      print("object");
      if (event == RawSocketEvent.read) {
        Datagram? datagram = udpSocket?.receive();
        if (datagram != null) {
          String message = utf8.decode(datagram.data);
          print("message $message");
          messageStreamController
              .add(jsonDecode(message) as Map<String, dynamic>);
        }
      }
    });
  }

  @override
  void sendMessage(String message, InternetAddress address) async {
    await initializeSocket();
    int? result = udpSocket?.send(utf8.encode(message), address, port);
    print("result: $result");
  }
}
