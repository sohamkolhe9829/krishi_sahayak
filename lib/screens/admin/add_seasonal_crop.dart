import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:krishi_sahayak/widgets/custom_button.dart';
import 'package:quill_html_converter/quill_html_converter.dart';

// ignore: must_be_immutable
class AddSeasonalCropScreen extends StatefulWidget {
  String title;
  AddSeasonalCropScreen({
    super.key,
    required this.title,
  });

  @override
  State<AddSeasonalCropScreen> createState() => _AddSeasonalCropScreenState();
}

class _AddSeasonalCropScreenState extends State<AddSeasonalCropScreen> {
  QuillController _controller = QuillController.basic();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          leading: IconButton(
              onPressed: () {
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
              Row(
                children: [
                  IconButton(onPressed: () {}, icon: Icon(Icons.add_a_photo)),
                  Expanded(
                    child: CustomButtonWidget(
                      title: "Upload data",
                      callBack: () {
                        print(jsonEncode(
                            _controller.document.toDelta().toHtml()));
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
