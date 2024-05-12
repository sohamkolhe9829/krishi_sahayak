import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:krishi_sahayak/providers/admin_provider.dart';
import 'package:krishi_sahayak/widgets/custom_button.dart';
import 'package:provider/provider.dart';
import 'package:quill_html_converter/quill_html_converter.dart';

// ignore: must_be_immutable
class EditCropsInformations extends StatefulWidget {
  String title;
  String content;
  String docId;
  EditCropsInformations({
    super.key,
    required this.title,
    required this.content,
    required this.docId,
  });

  @override
  State<EditCropsInformations> createState() => _EditCropsInformationsState();
}

class _EditCropsInformationsState extends State<EditCropsInformations> {
  final QuillController _controller = QuillController.basic();
  @override
  void initState() {
    super.initState();
    var text = widget.content;
    text = text.replaceAll(RegExp(r'<br/>'), '&#8203;</br>');
    var html = Document.fromHtml(text);
    var delta = html.toDelta();
    _controller.document = Document.fromDelta(delta);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Consumer<AdminProvider>(
        builder: (context, adminProvider, child) => Scaffold(
          appBar: AppBar(
            title: Text(widget.title),
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
                  title: "Update data",
                  isLoading: false,
                  callBack: () {
                    adminProvider.updateCropsInformation(
                      context,
                      widget.title,
                      jsonEncode(_controller.document.toDelta().toHtml()),
                      widget.docId,
                    );
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
