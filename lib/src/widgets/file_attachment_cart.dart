import 'package:flutter/material.dart';

import '../controller/controller.dart';

class FileAttachmentCart extends StatelessWidget {
  const FileAttachmentCart({
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
        Container(
          color: Colors.grey[200],
          width: 125,
          height: 125,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.insert_drive_file,
                // Replace with an appropriate icon or thumbnail for files
                size: 48,
                // Adjust the size to your preference
                color: Colors.grey, // Adjust the color to your preference
              ),
              Flexible(
                child: Text(
                  Uri.decodeFull(
                      Uri.parse(attachmentUrl).path)
                      .split('/')
                      .last
                      .substring(Uri.decodeFull(
                      Uri.parse(attachmentUrl)
                          .path)
                      .split('/')
                      .last
                      .indexOf('-') +
                      'file_picker_'.length +
                      1),
                  overflow: TextOverflow.ellipsis,
                  // Add overflow property
                  style:
                  TextStyle(fontSize: 12), // Adjust font size if necessary
                ),
              ),
            ],
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
                        .white), // Add a border to separate the button from the file representation
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
