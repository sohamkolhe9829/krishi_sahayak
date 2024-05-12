import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:krishi_sahayak/providers/admin_provider.dart';
import 'package:krishi_sahayak/widgets/custom_button.dart';
import 'package:provider/provider.dart';
import 'package:quill_html_converter/quill_html_converter.dart';

// ignore: must_be_immutable
class AddCropsInformation extends StatefulWidget {
  AddCropsInformation({
    super.key,
  });

  @override
  State<AddCropsInformation> createState() => _AddCropsInformationState();
}

class _AddCropsInformationState extends State<AddCropsInformation> {
  final QuillController _controller = QuillController.basic();
  TextEditingController titleController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Consumer<AdminProvider>(
        builder: (context, adminProvider, child) => Scaffold(
          appBar: AppBar(
            title: const Text("Add Crops Informations"),
            leading: IconButton(
                onPressed: () {
                  adminProvider.clearData();
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back_ios)),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextField(
                  controller: titleController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text("Title"),
                  ),
                ),
                QuillToolbar.simple(
                  configurations: QuillSimpleToolbarConfigurations(
                    controller: _controller,
                    sharedConfigurations: const QuillSharedConfigurations(
                      locale: Locale('en'),
                    ),
                  ),
                ),
                Expanded(
                  child: QuillEditor.basic(
                    configurations: QuillEditorConfigurations(
                      controller: _controller,
                      sharedConfigurations: const QuillSharedConfigurations(
                        locale: Locale('en'),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 100,
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      adminProvider.selectedImage == null
                          ? const SizedBox()
                          : AspectRatio(
                              aspectRatio: 16 / 9,
                              child: Image.file(
                                adminProvider.selectedImage!,
                                fit: BoxFit.cover,
                              ),
                            ),
                      adminProvider.selectedFiles.isEmpty
                          ? const SizedBox()
                          : AspectRatio(
                              aspectRatio: 16 / 9,
                              child: PageView.builder(
                                itemCount: adminProvider.selectedFiles.length,
                                itemBuilder: (context, index) {
                                  return Image.file(
                                    adminProvider.selectedFiles[index],
                                    fit: BoxFit.cover,
                                  );
                                },
                              ),
                            ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () {
                        adminProvider.pickImage();
                      },
                      child: Container(
                        height: 50,
                        padding: const EdgeInsets.all(5),
                        child: const Center(
                          child: Row(
                            children: [
                              Icon(Icons.add_a_photo),
                              Text("  Add Banner"),
                            ],
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        adminProvider.pickMultipleImages();
                      },
                      child: Container(
                        height: 50,
                        padding: const EdgeInsets.all(5),
                        child: const Center(
                          child: Row(
                            children: [
                              Icon(Icons.add_a_photo),
                              Text("  Add Images"),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                CustomButtonWidget(
                  title: "Upload data",
                  isLoading: false,
                  callBack: () {
                    if (titleController.text != "") {
                      adminProvider.addCropsInformation(
                        context,
                        titleController.text,
                        jsonEncode(
                          _controller.document.toDelta().toHtml(),
                        ),
                      );
                    } else {
                      Fluttertoast.showToast(msg: "Title is required");
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
