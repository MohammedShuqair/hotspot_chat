import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:hotspot_chat/controllers/chat_controller.dart';
import 'package:hotspot_chat/data_sources/database/repositories/message_repository.dart';
import 'package:hotspot_chat/data_sources/database/repositories/user_repository.dart';
import 'package:hotspot_chat/data_sources/shared_pref/shared_helper.dart';
import 'package:hotspot_chat/models/chat.dart';
import 'package:hotspot_chat/models/check_connection.dart';
import 'package:hotspot_chat/models/check_connection_response.dart';
import 'package:hotspot_chat/models/data_response.dart';
import 'package:hotspot_chat/models/indirect_message.dart';
import 'package:hotspot_chat/models/message.dart';
import 'package:hotspot_chat/models/sync_other_request.dart';
import 'package:hotspot_chat/models/sync_other_response.dart';
import 'package:hotspot_chat/services/device_identifier/device_identifier.dart';
import 'package:hotspot_chat/services/device_identifier/device_identifier_impl.dart';
import 'package:hotspot_chat/services/navigation_service/navigation_service.dart';
import 'package:hotspot_chat/services/network/network_devices_service/network_devices_service_ping.dart';
import 'package:hotspot_chat/services/network/network_information/network_information.dart';
import 'package:hotspot_chat/services/network/network_information/network_information_impl.dart';
import 'package:hotspot_chat/services/network/udp_endpoints/udp_endpoint.dart';
import 'package:hotspot_chat/services/network/udp_service/udp_service.dart';
import 'package:hotspot_chat/services/network/udp_service/udp_service_impl.dart';
import 'package:hotspot_chat/services/permisiion/app_permission.dart';
import 'package:hotspot_chat/services/permisiion/app_permission_impl.dart';
import 'package:hotspot_chat/utils/chat_id.dart';
import 'package:hotspot_chat/utils/constants.dart';
import 'package:hotspot_chat/views/chat/direct/chat_screen.dart';
import 'package:hotspot_chat/views/check_connection/check_connection_dialog.dart';
import 'package:hotspot_chat/views/home/home_screen.dart';
import 'package:hotspot_chat/views/shared/no_network_dialog.dart';
import 'package:hotspot_chat/views/user_info/user_info_screen.dart';
import 'package:provider/provider.dart';

import '../data_sources/database/repositories/chat_repository.dart';
import '../models/user.dart';
import '../services/network/network_devices_service/network_devices_service.dart';
import '../views/shared/dialog_skeleton.dart';

class NetworkController extends ChangeNotifier {
  DataResponse<String?>? userIpAddress;
  DataResponse<String?>? deviceIdentifier;
  late NetworkDevicesService networkDevicesService;

  User? currentUser;

  StreamSubscription? udpStreamSubscriptionGetter;

  late DeviceIdentifierService deviceIdentifierService;
  late AppPermissionService appPermissionService;
  late NetworkInformationService networkInformationService;
  late UDPService? udpService;

  NetworkController() {
    appPermissionService = AppPermissionImpl();
    networkInformationService = NetworkInformationImpl(appPermissionService);
    networkDevicesService =
        NetworkDevicesServicePing(networkInformationService);
    deviceIdentifierService = DeviceIdentifierServiceImpl();
    init();

    StreamSubscription<List<ConnectivityResult>> subscription = Connectivity()
        .onConnectivityChanged
        .listen((List<ConnectivityResult> result) {
      init();
    });
  }

  Future<void> _initUDPService() async {
    try {
      udpService = UDPServiceImpl(
          ipAddress: InternetAddress(userIpAddress!.data!),
          port: AppConstants.port);
      await udpService!.initializeSocket();
      notifyListeners();
    } catch (e, s) {
      udpService = null;
      notifyListeners();
      print("error in initializing udp service $e");
      print("stacktrace $s");
      NavigationService.showSnackBar(
          "please make sure you are connected to a network");
    }
  }

  Future<bool> userNameIsNotEmpty() async {
    if (deviceIdentifier?.data != null) {
      User? user = await UserRepository.getUser(deviceIdentifier!.data!);
      if (user != null) {
        currentUser = user;
      } else {
        String? name = SharedHelper.instance.getString(PrefKeys.userName);
        if (name != null) {
          currentUser = User(
              deviceIdentifier: deviceIdentifier!.data,
              name: name,
              ip: userIpAddress?.data);
          UserRepository.addUser(currentUser!);
        } else {
          return false;
        }
      }
    }
    notifyListeners();
    return currentUser == null ? false : true;
  }

  void listenToUdpStream() {
    print("controller listen to udp stream");
    udpStreamSubscriptionGetter?.cancel();
    udpService?.initMessagesStreamController();
    udpStreamSubscriptionGetter =
        udpService!.messageStreamController.stream.listen((event) async {
      print("received endpoint ${event["endpoint"]}");
      switch (event["endpoint"]) {
        case UDPEndpoint.syncOtherResponse:
          {
            try {
              SyncOtherResponse response = SyncOtherResponse.fromJson(event);
              if (response.message?.isNotEmpty ?? false) {
                await MessageRepository().addMessages(response.message!);
                NavigationService.showSnackBar("Synced messages");
              } else {
                NavigationService.showSnackBar("No messages to sync");
              }
            } catch (e) {
              NavigationService.showSnackBar("Error in syncing messages");
            }
            break;
          }
        case UDPEndpoint.syncOtherRequest:
          {
            SyncOtherRequest request = SyncOtherRequest.fromJson(event);
            if (request.user?.deviceIdentifier != null &&
                request.user?.ip != null) {
              await NavigationService.showDialog(
                DialogSkeleton(
                  title: "Syncing",
                  body: "Syncing request from\n ${request.user?.name}",
                  onAccept: () async {
                    List<Message> messages = await MessageRepository.indirect()
                        .getWhenReceiver(request.user!.deviceIdentifier!);
                    await sendMessage(
                        data: SyncOtherResponse(
                          message: messages,
                        ).toRawJson(),
                        destinationIP: request.user!.ip!);
                    await MessageRepository.indirect()
                        .deleteWhenReceiver(request.user!.deviceIdentifier!);
                    NavigationService.goBack();
                  },
                ),
              );
            }
            break;
          }
        case UDPEndpoint.indirectMessage:
          {
            try {
              IndirectMessage indirectMessage = IndirectMessage.fromJson(event);
              await MessageRepository.indirect()
                  .addMessage(indirectMessage.message!);
              NavigationService.showSnackBar("Indirect message received");
            } catch (e, s) {
              print("error in receiving indirect message $e");
              print("error in receiving indirect message $s");
              NavigationService.showSnackBar(
                  "Error in receiving indirect message");
            }
            break;
          }

        case UDPEndpoint.sendMessage:
          {
            Message message = Message.fromJson(event);
            MessageRepository().addMessage(message);

            break;
          }
        case UDPEndpoint.checkConnectionResponse:
          {
            CheckConnectionResponse response =
                CheckConnectionResponse.fromJson(event);
            if (response.status) {
              bool isExist = await UserRepository.isUserExist(
                  response.user.deviceIdentifier!);
              if (!isExist) {
                await UserRepository.addUser(response.user);
              }
              bool isChatExist = await ChatRepository.isChatExist(
                  response.user.deviceIdentifier!);
              String chatId = ChatId.combine(
                  response.user.deviceIdentifier!, deviceIdentifier!.data!);
              if (!isChatExist) {
                await ChatRepository.addChat(
                    Chat(id: chatId, userList: [response.user, currentUser!]));
              }
              NavigationService.navigateTo(ChangeNotifierProxyProvider<
                  NetworkController, ChatController>(
                create: (BuildContext context) => ChatController(
                    chatId,
                    response.user,
                    currentUser!,
                    userIpAddress!.data!,
                    udpService!),
                update: (context, networkController, chatController) {
                  if (chatController != null) {
                    return ChatController(chatId, response.user, currentUser!,
                        userIpAddress!.data!, udpService!);
                  } else {
                    return chatController!..updateIP(userIpAddress!.data!);
                  }
                },
                child: ChatScreen(),
              ));
            }
            break;
          }
        case UDPEndpoint.checkConnectionRequest:
          {
            CheckConnectionRequest request =
                CheckConnectionRequest.fromJson(event);
            if (request.sender?.deviceIdentifier != null &&
                isControllerVarsInitialized()) {
              await NavigationService.showDialog(CheckConnectionDialog(
                  user: request.sender!,
                  onAccept: () async {
                    // check if user is already in the database
                    // if not add him/her
                    // if yes load messages between you and him/her
                    // then navigate to chat screen

                    bool isExist = await UserRepository.isUserExist(
                        request.sender!.deviceIdentifier!);
                    if (!isExist) {
                      await UserRepository.addUser(request.sender!);
                    }
                    bool isChatExist = await ChatRepository.isChatExist(
                        request.sender!.deviceIdentifier!);
                    String chatId = ChatId.combine(
                        request.sender!.deviceIdentifier!,
                        deviceIdentifier!.data!);

                    if (!isChatExist) {
                      await ChatRepository.addChat(Chat(
                          id: chatId,
                          userList: [request.sender!, currentUser!]));
                    }
                    udpService!.sendMessage(
                        CheckConnectionResponse(
                                endpoint: UDPEndpoint.checkConnectionResponse,
                                user: currentUser!,
                                status: true)
                            .toRawJson(),
                        InternetAddress(request.sender!.ip!));

                    NavigationService.navigateReplacementTo(
                        ChangeNotifierProxyProvider<NetworkController,
                            ChatController>(
                      create: (BuildContext context) => ChatController(
                          chatId,
                          request.sender!,
                          currentUser!,
                          userIpAddress!.data!,
                          udpService!),
                      update: (context, networkController, chatController) {
                        if (chatController != null) {
                          return ChatController(
                              chatId,
                              request.sender!,
                              networkController.currentUser!,
                              networkController.userIpAddress!.data!,
                              networkController.udpService!);
                        } else if (chatController!.ip !=
                            networkController.userIpAddress!.data) {
                          return chatController
                            ..updateIP(networkController.userIpAddress!.data!);
                        }
                        return chatController;
                      },
                      child: ChatScreen(),
                    ));
                  }));
            }
            break;
          }
        default:
          break;
      }
    });
  }

  bool isControllerVarsInitialized() {
    return deviceIdentifier?.data != null &&
        userIpAddress?.data != null &&
        udpService != null &&
        currentUser != null;
  }

  Future<void> init() async {
    await getDeviceIdentifier();
    if (await userNameIsNotEmpty()) {
      await getIPAddress();
      await _initUDPService();
      FlutterNativeSplash.remove();

      if (isInitialized()) {
        listenToUdpStream();
        NavigationService.navigateAndRemoveUntilTo(HomeScreen());
      } else {
        NavigationService.showDialog(NoNetworkDialog());
      }
    } else {
      FlutterNativeSplash.remove();
      NavigationService.navigateAndRemoveUntilTo(UserInfoScreen());
    }
  }

  bool isInitialized() =>
      userIpAddress?.status == DataStatus.COMPLETED &&
      deviceIdentifier?.status == DataStatus.COMPLETED &&
      udpService != null;

  bool isError() =>
      userIpAddress?.status == DataStatus.ERROR &&
      deviceIdentifier?.status == DataStatus.ERROR;

  Future<void> getIPAddress() async {
    try {
      userIpAddress = DataResponse.loading();
      notifyListeners();
      String? ip = await networkInformationService.getDeviceIP();
      currentUser?.updateIp(ip);

      if (ip == null) {
        NavigationService.showSnackBar("Please connect to a network");
        userIpAddress =
            DataResponse.error(message: "Error in getting IP address");
        notifyListeners();
      } else {
        userIpAddress = DataResponse.completed(ip);
        notifyListeners();
      }
    } catch (e) {
      currentUser?.updateIp(null);
      NavigationService.showSnackBar("Error in getting IP address");
      userIpAddress =
          DataResponse.error(message: "Error in getting IP address");
      notifyListeners();
    }
  }

  Future<void> getDeviceIdentifier() async {
    try {
      deviceIdentifier = DataResponse.loading();
      notifyListeners();
      String id = await deviceIdentifierService.getDeviceIdentifier();
      deviceIdentifier = DataResponse.completed(id);
      notifyListeners();
    } catch (e, s) {
      NavigationService.showSnackBar("Error in getting Device Identifier ");
      deviceIdentifier =
          DataResponse.error(message: "Error in getting Device Identifier");
      notifyListeners();
    }
  }

  Future<void> checkDestinationConnection(String destinationIP) async {
    if (udpService != null) {
      print("checking connection with $destinationIP");
      udpService!.sendMessage(
          CheckConnectionRequest(
            endpoint: UDPEndpoint.checkConnectionRequest,
            sendAt: DateTime.now().toIso8601String(),
            sender: currentUser,
          ).toRawJson(),
          InternetAddress(destinationIP));
    } else {
      NavigationService.showSnackBar("Please connect to a network");
    }
  }

  Future<void> syncChat(String destinationIP) async {
    if (udpService != null) {
      print("syncChat with $destinationIP");
      sendMessage(
          data: SyncOtherRequest(
            endpoint: UDPEndpoint.syncOtherRequest,
            user: currentUser,
          ).toRawJson(),
          destinationIP: destinationIP);
    } else {
      NavigationService.showSnackBar("Please connect to a network");
    }
  }

  Future<void> sendMessage({
    required String data,
    required String destinationIP,
  }) async {
    if (udpService != null) {
      print("checking connection with $destinationIP");
      udpService!.sendMessage(data, InternetAddress(destinationIP));
    } else {
      NavigationService.showSnackBar("Please connect to a network");
    }
  }

  dispose() {
    udpStreamSubscriptionGetter?.cancel();
    super.dispose();
  }
}
