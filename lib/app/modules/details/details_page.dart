import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:task_todo_app/app/core/utils/extensions.dart';
import 'package:task_todo_app/app/modules/details/widgets/doing_list.dart';
import 'package:task_todo_app/app/modules/details/widgets/done_list.dart';
import 'package:task_todo_app/app/modules/home/controller.dart';

class DetailsPage extends StatelessWidget {
  const DetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final homeController = Get.find<HomeController>();
    final task = homeController.task.value!;
    final color = HexColor.fromHex(task.color);
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
                  children: [
                    IconButton(
                        onPressed: () {
                          Get.back();
                          homeController.updateTodos();
                          homeController.changeTask(null);
                          homeController.editController.clear();
                        },
                        icon: Icon(Icons.arrow_back)),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0.wp),
                child: Row(
                  children: [
                    Icon(
                      IconData(task.icon, fontFamily: 'MaterialIcons'),
                      color: color,
                    ),
                    SizedBox(width: 3.0.wp),
                    Text(
                      task.title,
                      style: TextStyle(
                          fontSize: 12.0.sp, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
              Obx(
                () {
                  var totalTodos = homeController.doingTodos.length +
                      homeController.doneTodos.length;
                  return Padding(
                    padding: EdgeInsets.only(
                        left: 16.0.wp, top: 3.0.wp, right: 16.0.wp),
                    child: Row(
                      children: [
                        Text(
                          '$totalTodos Tasks',
                          style: TextStyle(
                            fontSize: 12.0.sp,
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(
                          width: 3.0.wp,
                        ),
                        Expanded(
                            child: StepProgressIndicator(
                          totalSteps: totalTodos == 0 ? 1 : totalTodos,
                          currentStep: homeController.doneTodos.length,
                          size: 5,
                          padding: 0,
                          selectedGradientColor: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [color.withOpacity(0.5), color]),
                          unselectedGradientColor: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Colors.grey.shade300,
                                Colors.grey.shade300
                              ]),
                        ))
                      ],
                    ),
                  );
                },
              ),
              Padding(
                padding:
                    EdgeInsets.symmetric(vertical: 2.0.wp, horizontal: 5.0.wp),
                child: TextFormField(
                  controller: homeController.editController,
                  autofocus: true,
                  decoration: InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey.shade400),
                      ),
                      prefixIcon: Icon(
                        Icons.check_box_outline_blank,
                        color: Colors.grey.shade400,
                      ),
                      suffixIcon:
                          IconButton(onPressed: () {
                            if (homeController.formKey.currentState!.validate()){
                              var success = homeController.addTodo(homeController.editController.text);
                              if (success){
                                EasyLoading.showSuccess('Todo item add success');
                              }else {
                                EasyLoading.showError('Todo item already exits');
                              }
                              homeController.editController.clear();
                            }
                          }, icon: Icon(Icons.done))),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty){
                      return 'Please enter your todo item';
                    }
                    return null;
                  },
                ),
              ),
              DoingList(),
              DoneList(),
            ],
          ),
        ),
      ),
    );
  }
}
