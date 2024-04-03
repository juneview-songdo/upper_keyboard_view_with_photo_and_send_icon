import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import '../../../../../../../../main.dart';
import '_/state_child.dart';
import '_/state_mother.dart';
import 'package:universal_io/io.dart';

class KeyboardWidgetView extends StatefulWidget {
  KeyboardWidgetView({super.key, required this.userName});

  final String userName;

  @override
  State<KeyboardWidgetView> createState() => StateChild();
}

class KeyboardWidgetViewState extends State<KeyboardWidgetView>
    with StateMother {
  final TextEditingController textEditingController = TextEditingController();
  bool enableSendButton = false;
  List<String> photos = [];
  FocusNode focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Divider(
          height: 1,
          thickness: 1,
        ),
        (photos.isNotEmpty)
            ? Container(
                height: 110,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.only(left: 10, right: 10, top: 10),
                  itemCount: photos.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                        //round image file
                        child: Stack(
                      children: [
                        AspectRatio(
                          aspectRatio: 1, // 이미지 비율을 1:1로 유지 (필요에 따라 조정)
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            // 이미지 모서리 둥글게
                            child: Image.file(
                              File(photos[index]),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Positioned(
                          top: -2,
                          right: -2,
                          child: Material(
                            color: Colors.transparent,
                            // 배경을 투명하게 설정합니다.
                            shape: CircleBorder(),
                            // 원형 아웃라인을 만듭니다.
                            clipBehavior: Clip.hardEdge,
                            // 재질의 모양에 맞춰 자식 위젯을 잘라냅니다.
                            child: Ink(
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .background,
                                    width: 2), // 아웃라인 설정
                                color: Colors.grey, // 아이콘 배경색
                                shape: BoxShape.circle,
                              ),
                              child: InkWell(
                                borderRadius: BorderRadius.circular(12),
                                // 물결 효과의 범위를 원형으로 설정합니다.
                                onTap: () {
                                  print('click close photo item button');
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  // 아이콘과 아웃라인 사이의 간격을 설정합니다.
                                  child: Icon(
                                    Icons.close_rounded,
                                    size: 16,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )).paddingDirectional(horizontal: 5, vertical: 10);
                  },
                ),
              )
            : Container(),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            enableSendButton
                ? Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .color!
                          .withOpacity(0.6),
                    ),
                    child: Icon(
                      Icons.add_photo_alternate_outlined,
                      color: Colors.white,
                    ),
                  ).gestures(onTap: () {
                    print('add photo');
                  })
                : CircleAvatar(
                    radius: 24,
                    backgroundImage: AssetImage(
                        'assets/view/upper_keyboard_view_with_photo_and_send_icon/iu.jpg'),
                  ),
            Gap(10),
            Expanded(
              // Flexible 또는 Expanded 사용
              child: TextFormField(
                focusNode: focusNode,
                controller: textEditingController,
                keyboardType: TextInputType.multiline,
                minLines: 1,
                // 최소 시작 줄 수
                maxLines: 4,
                // 최대 확장될 수 있는 줄 수
                decoration: InputDecoration(
                  hintMaxLines: 1,
                  hintText: 'Send a heart to ${widget.userName}',
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  // Padding 조절
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    borderSide: BorderSide(),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    borderSide: BorderSide(color: Colors.red),
                  ),
                ),
              ),
            ),
            Gap(10),
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: enableSendButton
                    ? Theme.of(context)
                        .textTheme
                        .bodySmall!
                        .color!
                        .withOpacity(0.8)
                    : Colors.grey.withOpacity(0.5),
              ),
              child: Icon(
                Icons.send_rounded,
                color: Colors.white,
              ),
            ),
          ],
        ).padding(horizontal: 10, vertical: 10),
      ],
    );
  }
}

main() async {
  return buildApp(
      appHome: KeyboardWidgetView(
    userName: 'june',
  ));
}
