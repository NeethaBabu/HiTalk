import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:msg_app/components/my_drawer.dart';
import 'package:msg_app/services/auth/auth_services.dart';
import 'package:msg_app/services/chat/chat_services.dart';

import '../components/user_tile.dart';
import 'chat_page.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final ChatServices _chatServices = ChatServices();
  final AuthServices _authServices = AuthServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("HomePage.."),
        backgroundColor: Theme.of(context).colorScheme.surface,elevation: 0,foregroundColor: Colors.grey,),

      drawer: MyDrawer(),
      body: _buildUserList(),
    );
  }

  // Widget _buildUserList() {
  //   return StreamBuilder(
  //     stream: _chatServices.getUserStream(),
  //     builder: (context, snapshot) {
  //       if (snapshot.hasError) {
  //         return Text("Error");
  //       }
  //       if (snapshot.connectionState == ConnectionState.waiting) {
  //         return Text("Loading...................................");
  //       }
  //       return
  //         // Text("data: ${snapshot.data}");
  //         ListView(
  //         children: snapshot.data!
  //             .map<Widget>((userData) => _buildUserListItem(userData, context))
  //             .toList(),
  //       );
  //     },
  //   );
  // }

  Widget _buildUserList() {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: FirebaseFirestore.instance.collection('User').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) return const Text('Error');
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text('Loading...');
        }

        final docs = snapshot.data?.docs ?? [];
        if (docs.isEmpty) return const Text('No users found');

        final currentEmail = _authServices.getCurrentUser()?.email;

        final users = docs
            .map((d) => d.data())
            .where((u) => u['email'] != null && u['email'] != currentEmail)
            .toList();

        if (users.isEmpty) return const Text('No other users yet');

        return ListView(
          children: users
              .map((userData) => _buildUserListItem(userData, context))
              .toList(),
        );
      },
    );
  }


  Widget _buildUserListItem(
    Map<String, dynamic> userData,
    BuildContext context,
  ) {
    if (userData["email"] != _authServices.getCurrentUser()!.email) {
      return  UserTile(
        text:
        userData["email"],
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChatPage(receiverEmail: userData["email"], receiverID: userData['uid']),
            ),
          );
        },
      );
    } else {
      return Container();
    }
  }
}
