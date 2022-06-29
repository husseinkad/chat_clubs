import 'package:chat_clubs/screens/signin_screen.dart';
import 'package:chat_clubs/screens/welcome_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';

final _firestore = FirebaseFirestore.instance;
late User signedInUser;

class ChatArtScreen extends StatefulWidget {
  const ChatArtScreen({Key? key}) : super(key: key);

  @override
  _ChatArtScreenState createState() => _ChatArtScreenState();
}

class _ChatArtScreenState extends State<ChatArtScreen> {

  final _auth = FirebaseAuth.instance;
  final textEditingController = TextEditingController();
  String? messageText;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentUser();

  }

  void getCurrentUser() {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        signedInUser = user;
        print(signedInUser.email);
      }
    } catch (e) {
      print(e);
    }
  }

  // void getMessages() async{
  //   final messages = await _firestore.collection('messages').get();
  //   for (var message in messages.docs){
  //     print(message.data());
  //   }
  // }

  // void messagesStreams() async{
  //    await for (var snapshot in _firestore.collection('messages').snapshots()) {
  //      for (var message in snapshot.docs) {
  //        print(message.data());
  //      }
  //    }
  // }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
        leading: IconButton(icon: const Icon(Icons.arrow_back_ios_new_outlined), onPressed: () { Get.back(); },),
        title: const Text('Art club'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              //  logout function
              _auth.signOut();
              Get.to(const SignInScreen());
            },
            icon: const Icon(Icons.logout),
          )
        ],
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            MessageStreamBuilder(),
            Container(
              decoration: const BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: Colors.white,
                    width: 1,
                  ),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        TextField(
                          style: const TextStyle(color: Colors.white),
                          onChanged: (value) {
                            messageText = value;
                          },
                          controller: textEditingController,
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 20,
                            ),
                            hintText: 'Message',
                            hintStyle: TextStyle(color: Colors.white)
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            textEditingController.clear();
                            _firestore.collection('messages').add({
                              'useremail': signedInUser.email,
                              'text': messageText,
                              'time': FieldValue.serverTimestamp(),
                            });
                          },
                          icon: const Icon(Icons.send_outlined, color: Colors.white,),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.face_retouching_natural, color: Colors.white,),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.now_wallpaper_outlined, color: Colors.white,),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// class MessageStreamBuilder extends StatelessWidget {
//   const MessageStreamBuilder({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Container();
//   }
// }

  MessageStreamBuilder(){
  return StreamBuilder<QuerySnapshot>(
    stream: _firestore.collection('messages').orderBy('time').snapshots(),
    builder: (context, snapshot){
      List<MessageLine> messageWidgets = [];

      if(!snapshot.hasData){
        return const Center(
          child: CircularProgressIndicator(
            color: Colors.white,
          ),
        );
      }

      final messages = snapshot.data!.docs.reversed;
      for(var message in messages){
        final messageText = message.get('text');
        final messageSender = message.get('useremail');
        final currentUser = signedInUser.email;

        if(currentUser == messageSender){

        }

        final messageWidget = MessageLine(
          useremail: messageSender,
          text: messageText,
          isMe: currentUser == messageSender,
        );
        messageWidgets.add(messageWidget);
      }

      return Expanded(
        child: ListView(
          reverse: true,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          children: messageWidgets,
        ),
      );
    },
  );
 }

class MessageLine extends StatelessWidget {
  const MessageLine({Key? key, this.text, this.useremail, required this.isMe}) : super(key: key);

  final String? text;
  final String? useremail;
  final bool isMe;


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
         crossAxisAlignment: isMe? CrossAxisAlignment.end :  CrossAxisAlignment.start,
        children: [
          Text('$useremail', style: const TextStyle(color: Colors.white54, fontSize: 12),),
          Material(
            elevation: 5,
            borderRadius: isMe? const BorderRadius.only(
              topLeft: Radius.circular(30),
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ) : const BorderRadius.only(
              topRight: Radius.circular(30),
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
            color: isMe? Colors.blue[800] : Colors.white,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Text('$text', style: TextStyle(color: isMe? Colors.white : Colors.black, fontSize: 15),),
              ),
          ),
        ],
      ),
    );
  }
}
