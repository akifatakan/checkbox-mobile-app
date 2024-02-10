import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/controller.dart';
import '../screens/screens.dart';

class ImageAttachmentCart extends StatelessWidget {
  const ImageAttachmentCart({
    Key? key,
    required this.attachmentUrl,
    required this.todoController,
    this.isEditable = true,
  }) : super(key: key);

  final String attachmentUrl;
  final TodoController todoController;
  final bool isEditable;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      // Allow overflow for positioned elements
      children: [
        GestureDetector(
          onTap: () {
            Get.to(() => PhotoViewScreen(imageUrl: attachmentUrl));
          },
          child: SizedBox(
            width: 125,
            height: 125,
            child: Image.network(
              attachmentUrl,
              fit: BoxFit.cover, // Ensure the image covers the SizedBox area
              // Other properties...
            ),
          ),
        ),
        if(isEditable)
          Positioned(
          right: -10,
          // Adjust the position to your preference
          top: -10,
          // Adjust the position to your preference
          child: InkWell(
            onTap: () async {
              await todoController.deleteFileFromFirebaseWithUrl(
                  attachmentUrl);
              todoController.attachments.remove(attachmentUrl);
            },
            child: Container(
              padding: EdgeInsets.all(2),
              // Adjust the padding to your preference
              decoration: BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
                border: Border.all(
                    width: 2,
                    color: Colors
                        .white), // Add a border to separate the button from the image
              ),
              child: Icon(Icons.close,
                  color: Colors.white,
                  size: 16), // Adjust the icon size to your preference
            ),
          ),
        ),
      ],
    );
  }
}