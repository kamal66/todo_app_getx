import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:task_todo_app/app/core/utils/extensions.dart';
import 'package:task_todo_app/app/core/values/colors.dart';
import 'package:task_todo_app/app/modules/home/controller.dart';

class AddDialog extends StatelessWidget {
  const AddDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final homeController = Get.find<HomeController>();

    return WillPopScope(
      onWillPop: () async=> false,
      child: Scaffold(
        body: Form(
          key: homeController.formKey,
          child: ListView(
            children: [
              Padding(
                padding: EdgeInsets.all(3.0.wp),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {
                        Get.back();
                        homeController.editController.clear();
                        homeController.changeTask(null);
                      },
                      icon: Icon(Icons.close),
                    ),
                    TextButton(
                        style: ButtonStyle(
                            overlayColor:
                                WidgetStateProperty.all(Colors.transparent)),
                        onPressed: () {
                          if (homeController.formKey.currentState!.validate()){
                            if (homeController.task.value == null){
                              EasyLoading.showError('Please select task type');
                            }else {
                              var success = homeController.updateTask(
                                homeController.task.value!,
                                homeController.editController.text
                              );
                              if (success){
                                EasyLoading.showSuccess('Todo item add success');
                                Get.back();
                                homeController.changeTask(null);
                              }else {
                                EasyLoading.showError('Todo item already exist');
                              }
                              homeController.editController.clear();
                            }
                          }
                        },
                        child: Text(
                          'Done',
                          style: TextStyle(fontSize: 14.0.sp, color: blue),
                        ))
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.0.wp),
                child: Text(
                  'New Task',
                  style:
                      TextStyle(fontSize: 20.0.sp, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.0.wp),
                child: TextFormField(
                  controller: homeController.editController,
                  autofocus: true,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return ' Please enter your todo item';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey.shade400))),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: 5.0.wp, left: 5.0.wp, right: 5.0.wp, bottom: 2.0.wp),
                child: Text(
                  'Add to',
                  style: TextStyle(fontSize: 14.0.sp, color: Colors.grey),
                ),
              ),
              ...homeController.tasks
                  .map(
                    (element) => Obx(
                      () =>  InkWell(
                        onTap: () => homeController.changeTask(element),
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 3.0.wp, horizontal: 5.0.wp),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    IconData(element.icon, fontFamily: 'MaterialIcons'),
                                    color: HexColor.fromHex(element.color),
                                  ),
                                  SizedBox(width: 3.0.wp,),
                                  Text(
                                    element.title,
                                    style: TextStyle(fontSize: 12.0.sp,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              if (homeController.task.value == element)
                                const Icon(Icons.check, color: Colors.blue),

                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ],
          ),
        ),
      ),
    );
  }
}
