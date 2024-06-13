import 'package:flutter/material.dart';
import 'package:shop_app/models/chatUsersModel.dart';
import 'package:shop_app/widgets/conversationList.dart'; // Sesuaikan dengan struktur proyek Anda
import 'package:shop_app/constants.dart'; // Sesuaikan dengan struktur proyek Anda
import 'chatDetailPage.dart'; // Sesuaikan dengan struktur proyek Anda

class ChatPage extends StatefulWidget {
  static String routeName = "/chat_page";

  const ChatPage({Key? key}) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  List<ChatUsers> chatUsers = [
    ChatUsers(name: "test1234", messageText: "Apakah produk Macan bisa ditaw...", imageURL: "", time: "01 Jan"),
    ChatUsers(name: "hamyus", messageText: "Haloo", imageURL: "", time: "02 Jan"),
    ChatUsers(name: "Rianadr", messageText: "Apakah produk Kaos Nascar Vint...", imageURL: "", time: "22 Apr"),
    ChatUsers(name: "Rizki J", messageText: "Apakah masih ready?", imageURL: "", time: "04 Jan"),
    ChatUsers(name: "Hamyuzz", messageText: "Heii", imageURL: "", time: "02 Jan"),
    ChatUsers(name: "fauby", messageText: "halo apakah barang ini ready?", imageURL: "", time: "22 Apr"),
    // ChatUsers(name: "Andrey Jones", messageText: "Can you please share the file?", imageURL: "", time: "24 Feb"),
    // ChatUsers(name: "John Wick", messageText: "How are you?", imageURL: "", time: "18 Feb"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Chat",
          style: Theme.of(context).textTheme.headlineLarge?.copyWith(color: kPrimaryColor), // Sesuaikan dengan warna yang Anda inginkan
        ),
        centerTitle: true, // Ratakan judul ke tengah
      ),
      body: ListView.builder(
        itemCount: chatUsers.length,
        padding: EdgeInsets.only(top: 16),
        itemBuilder: (context, index) {
          return ConversationList(
            name: chatUsers[index].name,
            messageText: chatUsers[index].messageText,
            imageUrl: chatUsers[index].imageURL,
            time: chatUsers[index].time,
            isMessageRead: (index == 0 || index == 3),
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChatDetailPage(chatUser: chatUsers[index]),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
