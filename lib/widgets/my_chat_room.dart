import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyChatRoomContainer extends StatelessWidget {
  const MyChatRoomContainer({Key? key, required this.title, required this.screen, required this.image}) :super(key: key);
  final String title;
  final Widget screen;
  final Widget image;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(screen);
      },
      child: SizedBox(
        height: 200,
          child: Stack(
            fit: StackFit.expand,
            children: [
              FittedBox(child: image, fit: BoxFit.fill,),
              Container(
                color: Colors.black54,
                child:  Center(
                  child: Text(
                    '$title',
                    maxLines: 1,
                    style: const TextStyle(fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
              ),
            ],
          )
      ),
    );
  }
}
