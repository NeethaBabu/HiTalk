import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:msg_app/services/auth/auth_services.dart';

import '../components/chat_bubble.dart';
import '../components/custom_text_field.dart';
import '../services/chat/chat_services.dart';

class ChatPage extends StatefulWidget {
  final String receiverEmail;
  final String receiverID;

  ChatPage({super.key, required this.receiverEmail, required this.receiverID});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messageController = TextEditingController();

  final ChatServices _chatServices = ChatServices();

  final AuthServices _authServices = AuthServices();
  FocusNode myFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    myFocusNode.addListener(() {
      if (myFocusNode.hasFocus) {
        Future.delayed(Duration(milliseconds: 500), () => scrollDown());
      }
    });
    Future.delayed(Duration(milliseconds: 500), () => scrollDown());
  }

  @override
  void dispose() {
    super.dispose();
    myFocusNode.dispose();
    _messageController.dispose();
  }

  final ScrollController _scrollController = ScrollController();

  void scrollDown() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: Duration(seconds: 1),
      curve: Curves.fastOutSlowIn,
    );
  }

  void sendMessage() async {
    if (_messageController.text.isNotEmpty) {
      await _chatServices.sendMessage(
        widget.receiverID,
        _messageController.text,
      );
      _messageController.clear();
    }
    _messageController.clear();
    scrollDown();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.receiverEmail),
        backgroundColor: Theme.of(context).colorScheme.surface,
        elevation: 0,
        foregroundColor: Colors.grey,
      ),
      body: Column(
        children: [
          Expanded(child: _builMessageList()),
          _buildUserInput(),
        ],
      ),
    );
  }

  Widget _builMessageList() {
    String senderId = _authServices.getCurrentUser()!.uid;
    return StreamBuilder(
      stream: _chatServices.getMessages(widget.receiverID, senderId),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text("Error");
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(
              color: Colors.grey,
            ),
          );
        }
        return ListView(
          controller: _scrollController,
          children: snapshot.data!.docs
              .map((doc) => _builMessageItem(doc))
              .toList(),
        );
      },
    );
  }

  Widget _builMessageItem(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    bool isCurrentUser =
        data['senderID'] == _authServices.getCurrentUser()!.uid;
    var alignment = isCurrentUser
        ? Alignment.centerRight
        : Alignment.centerLeft;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      alignment: alignment,
      child: Column(
        crossAxisAlignment: isCurrentUser
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start,
        children: [
          ChatBubble(message: data['message'], isCurrentUser: isCurrentUser),
        ],
      ),
    );
  }

  Widget _buildUserInput() {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Row(
        children: [
          Expanded(
            child: CustomTextFields(
              controller: _messageController,
              hintText: "Message",
              obscureText: false,
              focusNode: myFocusNode,
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.green,
              shape: BoxShape.circle,
            ),
            margin: EdgeInsets.only(right: 10),
            child: IconButton(
              onPressed: sendMessage,
              icon: Icon(Icons.arrow_upward, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
