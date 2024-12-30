import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:task_todo_app/app/core/utils/extensions.dart';
import 'package:task_todo_app/app/core/values/colors.dart';
import 'package:task_todo_app/app/data/models/task.dart';
import 'package:task_todo_app/app/modules/home/controller.dart';
import 'package:task_todo_app/app/widgets/icons.dart';

class AddCard extends StatelessWidget {
  const AddCard({super.key});

  @override
  Widget build(BuildContext context) {
    final homeController = Get.find<HomeController>();
    final icons = getIcons();
    var squareWidth = Get.width - 12.0.wp;

    return Container(
      width: squareWidth / 2,
      height: squareWidth / 2,
      margin: EdgeInsets.all(3.0.wp),
      child: InkWell(
        onTap: () async {
          await Get.defaultDialog(
              titlePadding: EdgeInsets.symmetric(vertical: 5.0.wp),
              radius: 5,
              title: 'Task Type',
              content: Form(
                  key: homeController.formKey,
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 3.0.wp),
                        child: TextFormField(
                          controller: homeController.editController,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(), labelText: 'Title'),
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Please enter your task title';
                            }
                            return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 5.0.wp),
                        child: Wrap(
                          spacing: 2.0.wp,
                          children: icons
                              .map((e) => Obx(
                                    () {
                                      final index = icons.indexOf(e);
                                      return ChoiceChip(
                                        label: e,
                                        selected:
                                            homeController.chipIndex.value ==
                                                index,
                                        onSelected: (selected) {
                                          homeController.chipIndex.value =
                                              selected ? index : 0;
                                        },
                                      );
                                    },
                                  ))
                              .toList(),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          if (homeController.formKey.currentState!.validate()) {
                            int icon = icons[homeController.chipIndex.value]
                                .icon!
                                .codePoint;
                            String color = icons[homeController.chipIndex.value]
                                .color!
                                .toHex();
                            var task = Task(
                                title: homeController.editController.text,
                                icon: icon,
                                color: color);
                            Get.back();
                            homeController.addTask(task)
                                ? EasyLoading.showSuccess('Create Success')
                                : EasyLoading.showError('Duplicated Task');
                          }
                        },
                        child: Text(
                          'Confirm',
                          style: TextStyle(color: Colors.white),
                        ),
                        style: ElevatedButton.styleFrom(
                            minimumSize: Size(150, 40),
                            backgroundColor: blue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            )),
                      )
                    ],
                  )));
          homeController.editController.clear();
          homeController.changeChipIndex(0);
        },
        child: DottedBorder(
            color: Colors.grey.shade400,
            dashPattern: [8, 4],
            child: Center(
              child: Icon(
                Icons.add,
                size: 40.0.sp,
                color: Colors.grey,
              ),
            )),
      ),
    );
  }
}
