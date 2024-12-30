import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_todo_app/app/core/utils/extensions.dart';
import 'package:task_todo_app/app/modules/home/controller.dart';

class DoingList extends StatelessWidget {
  const DoingList({super.key});

  @override
  Widget build(BuildContext context) {
    final homeController = Get.find<HomeController>();
    return Obx(
      () => homeController.doingTodos.isEmpty &&
              homeController.doneTodos.isEmpty
          ? Column(
              children: [
                SizedBox(height: 10.0.wp,),
                Image.asset(
                  'assets/images/task.png',
                  fit: BoxFit.cover,
                  width: 45.0.wp,
                ),
                SizedBox(height: 5.0.wp,),
                Text(
                  'Add Task',
                  style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0.sp),
                )
              ],
            )
          : ListView(
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              children: [
                ...homeController.doingTodos
                    .map((element) => Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 3.0.wp, horizontal: 9.0.wp),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 20,
                                height: 20,
                                child: Checkbox(
                                  value: element['done'],
                                  onChanged: (value) {
                                    homeController.doneTodo(element['title']);
                                  },
                                ),
                              ),
                              Padding(
                                padding:
                                    EdgeInsets.symmetric(horizontal: 4.0.wp),
                                child: Text(
                                  element['title'],
                                  overflow: TextOverflow.ellipsis,
                                ),
                              )
                            ],
                          ),
                        ))
                    .toList(),
                if( homeController.doingTodos.isNotEmpty)
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5.0.wp),
                    child: Divider(thickness: 2,),
                  )
              ],
            ),
    );
  }
}
