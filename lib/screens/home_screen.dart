

import 'package:chat_clubs/chat_screens/chat_art_screen.dart';
import 'package:chat_clubs/screens/signin_screen.dart';
import 'package:chat_clubs/screens/welcome_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../chat_screens/chat_culture_screen.dart';
import '../chat_screens/chat_movies_screen.dart';
import '../chat_screens/chat_science_screen.dart';
import '../chat_screens/chat_tech_screen.dart';
import '../widgets/my_chat_room.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
        appBar: AppBar(
          backgroundColor: Colors.grey[900],
          leading: IconButton(icon: const Icon(Icons.person), onPressed: () { Get.back(); },),
          title: const Text('Chat Clubs'),
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
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20,),
              MyChatRoomContainer(
                image: Image.asset('images/movies.jpg'),
                screen: const ChatMoviesScreen(),
                title: 'Movies club',
              ),
              const SizedBox(height: 15,),
              MyChatRoomContainer(
                image: Image.asset('images/art.jpg'),
                screen: const ChatArtScreen(),
                title: 'Art club',
              ),
              const SizedBox(height: 15,),
              MyChatRoomContainer(
                image: Image.asset('images/programming.jpg'),
                screen: const ChatTechScreen(),
                title: 'Tech club',
              ),
              const SizedBox(height: 15,),
              MyChatRoomContainer(
                image: Image.asset('images/science.jpg'),
                screen: const ChatScienceScreen(),
                title: 'Science club',
              ),
              const SizedBox(height: 15,),
              MyChatRoomContainer(
                image: Image.asset('images/cluture.jpg'),
                screen: const ChatCultureScreen(),
                title: 'Culture club',
              ),

            ],
          ),
        ),
      );
  }
}
