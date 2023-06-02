import 'package:assemblyemulator/custom_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

class EditBody extends StatefulWidget {
  EditBody({
    required this.errorIndex,
    required this.dataController,
    required this.textController,
    Key? key,
  }) : super(key: key);
  int errorIndex;
  TextEditingController dataController;
  TextEditingController textController;
  @override
  State<EditBody> createState() => _EditBodyState();
}

class _EditBodyState extends State<EditBody> {
  int _textCount = 0;
  int _datatCount = 0;
  double _textLineHeight = CustomStyle.fontSizes.smallFont;
  FocusNode myFocusNode1 = FocusNode();
  FocusNode myFocusNode2 = FocusNode();

  @override
  void initState() {
    super.initState();
    widget.textController.addListener(_updateTextCount);
    widget.dataController.addListener(_updateDataCount);
    var keyboardVisibilityController = KeyboardVisibilityController();
    keyboardVisibilityController.onChange.listen((bool visible) {
      if (!visible) {
        myFocusNode1.unfocus();
        myFocusNode2.unfocus();
      }
    });
  }

  void _updateTextCount() {
    if (!mounted) return;
    final textPainter = TextPainter(
      text: TextSpan(
        text: widget.textController.text,
      ),
      maxLines: null,
      textDirection: TextDirection.ltr,
    );
    textPainter.layout(
        maxWidth: MediaQuery.of(context).size.width * 0.9 - (80));

    final textHeight = textPainter.height;
    final textLineHeight = textHeight / textPainter.computeLineMetrics().length;

    setState(() {
      _textCount = textPainter.computeLineMetrics().length;
      _textLineHeight = textLineHeight;
    });
  }

  void _updateDataCount() {
    if (!mounted) return;
    final textPainter = TextPainter(
      text: TextSpan(
        text: widget.dataController.text,
      ),
      maxLines: null,
      textDirection: TextDirection.ltr,
    );
    textPainter.layout(
        maxWidth: MediaQuery.of(context).size.width * 0.9 - (80));

    final textHeight = textPainter.height;
    final textLineHeight = textHeight / textPainter.computeLineMetrics().length;

    setState(() {
      _datatCount = textPainter.computeLineMetrics().length;
      _textLineHeight = textLineHeight;
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.02),
          Row(
            children: [
              Text(
                '.data',
                style: TextStyle(
                    color: CustomStyle.colorPalette.lightGrey,
                    fontSize: CustomStyle.fontSizes.mediumFont),
              )
            ],
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.02),
          Wrap(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.05,
                child: Padding(
                  padding: EdgeInsets.only(top: 10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: List.generate(
                      _datatCount,
                      (index) {
                        final lineNumber = index + 1;
                        return Text(
                          lineNumber.toString(),
                          style: TextStyle(
                              color: CustomStyle.colorPalette.white,
                              fontSize: CustomStyle.fontSizes.smallFont),
                        );
                      },
                    ),
                  ),
                ),
              ),
              customTextField(
                focusNode: myFocusNode1,
                keyboardType: TextInputType.multiline,
                textEditingController: widget.dataController,
                hintText: '',
                width: MediaQuery.of(context).size.width * 0.9,
              ),
            ],
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.02),
          Row(
            children: [
              Text(
                '.text',
                style: TextStyle(
                    color: CustomStyle.colorPalette.lightGrey,
                    fontSize: CustomStyle.fontSizes.mediumFont),
              )
            ],
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.02),
          Wrap(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.05,
                child: Padding(
                  padding: EdgeInsets.only(top: 10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: List.generate(
                      _textCount,
                      (index) {
                        final lineNumber = index + 1;

                        return Text(
                          lineNumber.toString(),
                          style: TextStyle(
                              color: (widget.errorIndex == index)
                                  ? Colors.redAccent.shade400
                                  : CustomStyle.colorPalette.white,
                              fontSize: CustomStyle.fontSizes.smallFont),
                        );
                      },
                    ),
                  ),
                ),
              ),
              customTextField(
                focusNode: myFocusNode2,
                keyboardType: TextInputType.multiline,
                textEditingController: widget.textController,
                hintText: '',
                width: MediaQuery.of(context).size.width * 0.9,
              ),
            ],
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.02),
        ],
      ),
    );
  }
}
