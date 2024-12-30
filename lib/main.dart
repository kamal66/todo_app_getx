import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:task_todo_app/app/data/services/storage/services.dart';
import 'package:task_todo_app/app/modules/home/binding.dart';
import 'package:task_todo_app/app/modules/home/home_page.dart';

import 'app/controller/theme_controller.dart';
import 'app/utils/theme/theme.dart';

void main() async{
  await GetStorage.init();
  await Get.putAsync(() => StorageService().init());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final ThemeController themeController = Get.put(ThemeController());

  MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return Obx(
      () =>  GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Task Todo App',
        initialBinding: HomeBinding(),
        builder: EasyLoading.init(),
        themeMode: themeController.themeMode.value,
        theme: TAppTheme.lightTheme,
        darkTheme: TAppTheme.darkTheme,
        home: const HomePage(),
      ),
    );
  }
}


