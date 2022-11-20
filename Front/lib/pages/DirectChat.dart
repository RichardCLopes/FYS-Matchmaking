import 'dart:developer';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fys/builders.dart';
import 'package:fys/customui/MessageModel.dart';
import 'package:fys/customui/OwnMessageCard.dart';
import 'package:fys/customui/ReplyCard.dart';
import 'package:fys/pages/UserProfile.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class chatPage extends StatefulWidget {
  chatPage(this.id);
  final String id;

  @override
  State<chatPage> createState() => _chatPageState(this.id);
}

class _chatPageState extends State<chatPage> {
  _chatPageState(this.id);
  final String id;
  late IO.Socket socket;
  List<MessageModel> messages = [];
  TextEditingController _controller = TextEditingController();
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    connect();
  }

  void connect() {
    socket = IO.io("http//192.168.43.92:3000", <String, dynamic>{
      "transport": ["websocket"],
      "autoconnect": false,
    });
    socket.connect();
    socket.emit("signin", id);
    socket.onConnect((data) {
      print("Connected");
      socket.on("message", (msg) {
        print(msg);
        setMessage("destination", msg["message"]);
      });
    });
    print(socket.connected);
  }

  void sendMes(String message, String sourceId, String id) {
    setMessage("source", message);
    socket
        .emit("message", {"message": message, "sourceId": sourceId, "Id": id});
  }

  void setMessage(String type, String message) {
    MessageModel messageModel = MessageModel(message: message, type: type);
    setState(() {
      setState(() {
        messages.add(messageModel);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0x44000000),
        actions: [
          IconButton(
            icon: Icon(
              Icons.account_circle,
              size: 35,
              color: Color.fromARGB(255, 51, 225, 255),
            ),
            onPressed: () => PushScreen(context, userProfilePage(id)),
          )
        ],
        centerTitle: true,
        title: Text(id), //pegar o nome atravez do server pelo ID
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Expanded(
              //height: MediaQuery.of(context).size.height - 140,
              child: ListView.builder(
                controller: _scrollController,
                itemCount: messages.length + 1,
                itemBuilder: (context, index) {
                  if (index == messages.length) {
                    return Container(
                      height: 70,
                    );
                  }
                  if (messages[index].type == "source") {
                    return OwnMessageCard(
                      message: messages[index].message,
                    );
                  } else {
                    return ReplyCard(
                      message: messages[index].message,
                    );
                  }
                },
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 70,
                child: Row(
                  children: [
                    Container(
                        width: MediaQuery.of(context).size.width - 50,
                        child: Card(
                          margin:
                              EdgeInsets.only(left: 5, right: 10, bottom: 8),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25)),
                          child: TextFormField(
                            controller: _controller,
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.multiline,
                            maxLines: 3,
                            minLines: 1,
                            decoration:
                                InputDecoration(hintText: "Digite algo"),
                          ),
                        )),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 9, right: 5),
                      child: CircleAvatar(
                        radius: 22,
                        backgroundColor: Color.fromARGB(255, 140, 0, 255),
                        child: IconButton(
                          icon: Icon(Icons.play_arrow_rounded),
                          onPressed: () {
                            _scrollController.animateTo(
                                _scrollController.position.maxScrollExtent,
                                duration: Duration(milliseconds: 500),
                                curve: Curves.easeOut);
                            sendMes(_controller.text, "1", id);
                            _controller.clear();
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
