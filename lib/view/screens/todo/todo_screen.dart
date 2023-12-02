import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:todo_app/view/screens/todo/todo_controller.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  TextEditingController textEditingController = TextEditingController();
  TextEditingController editTextController = TextEditingController();

  TodoController todoController=Get.put(TodoController());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'TodoApp',
          style: TextStyle(
            fontSize: 16,
          ),
        ),
      ),
      body: GetBuilder<TodoController>(
          builder: (controller){
            if(controller.isLoading){
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return RefreshIndicator(
              onRefresh: ()async{
                controller.TodoList.clear();
                controller.getTodos();
              },
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Todos',
                      style: TextStyle(
                          color: Colors.black87,
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Column(
                      children: List.generate(
                          controller.TodoList.length, (index) {
                        return Container(
                          margin: const EdgeInsets.only(bottom: 8),
                          padding:
                          const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                          decoration: BoxDecoration(
                            color: Colors.brown,
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                flex: 2,
                                child: Row(
                                  children: [
                                    IconButton(
                                        onPressed: () {},
                                        icon: const Icon(
                                          Icons.add_circle,
                                          color: Colors.white,
                                        )),
                                     Expanded(
                                      child: Text(
                                        textAlign: TextAlign.start,
                                       controller.TodoList[index].title.toString(),
                                        maxLines: 4,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Row(
                                  children: [
                                    IconButton(
                                        onPressed: () {
                                           Get.defaultDialog(
                                              backgroundColor: Colors.white,
                                              title: 'Edit Task',
                                              content: Column(
                                                children: [
                                                  TextFormField(
                                                    controller: editTextController,
                                                    decoration:
                                                    const InputDecoration(hintText: 'edit task'),
                                                  ),
                                                  const SizedBox(
                                                    height: 12,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                    children: [
                                                      OutlinedButton(
                                                          onPressed: () {
                                                            Get.back();
                                                          },
                                                          child: const Text('Cancel')),
                                                      ElevatedButton(
                                                          onPressed: () {
                                                           controller.editTodos(editTextController.text, controller.TodoList[index].id.toString());
                                                           editTextController.clear();
                                                           controller.TodoList.clear();
                                                           controller.getTodos();
                                                            Get.back();
                                                          },
                                                          child: const Text('Save')),
                                                    ],
                                                  )
                                                ],
                                              ));
                                        },
                                        icon: const Icon(
                                          Icons.edit,
                                          color: Colors.white,
                                        )),
                                    IconButton(
                                        onPressed: () {
                                          Get.defaultDialog(
                                              backgroundColor: Colors.white,
                                              title: 'Delete Task ',
                                              content: Column(
                                                children: [
                                                  const Text(
                                                    textAlign: TextAlign.start,
                                                    'Do you want to delete',
                                                    maxLines: 4,
                                                    style: TextStyle(
                                                        color: Colors.black87,
                                                        fontSize: 16,
                                                        fontWeight: FontWeight.w500),
                                                  ),
                                                  const SizedBox(
                                                    height: 12,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                    children: [
                                                      OutlinedButton(
                                                          onPressed: () {
                                                            Get.back();
                                                          },
                                                          child: const Text('no')),
                                                      ElevatedButton(
                                                          onPressed: () {
                                                            controller.deleteTodos(controller.TodoList[index].id);
                                                            Get.back();
                                                            print(controller.TodoList[index].id);

                                                          },
                                                          child: const Text('yes')),
                                                    ],
                                                  )
                                                ],
                                              ));
                                        },
                                        icon: const Icon(
                                          Icons.delete,
                                          color: Colors.white,
                                        )),
                                  ],
                                ),
                              )
                            ],
                          ),
                        );
                      }).toList(),
                    )
                  ],
                ),
              ),
            );
          }),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: InkWell(
              onTap: () {
                addNewTodo(textEditingController);
              },
              child: Container(
                width: 120,
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                decoration: BoxDecoration(
                  color: Colors.brown,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 4,
                    ),
                    Text(
                      'ADD NEW',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    ));
  }



  void addNewTodo( TextEditingController textEditingController) {
    Get.defaultDialog(
        backgroundColor: Colors.white,
        title: 'Enter New Task ',
        content: Column(
          children: [
            TextFormField(
              controller: textEditingController,
              decoration:
                  const InputDecoration(hintText: 'enter new task'),
            ),
            const SizedBox(
              height: 12,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                OutlinedButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: const Text('Cancel')),
                ElevatedButton(
                    onPressed: () {
                      todoController.postTodos(textEditingController.text);
                      textEditingController.clear();
                      todoController.TodoList.clear();
                      todoController.getTodos();
                      Get.back();
                    },
                    child: const Text('Save')),
              ],
            )
          ],
        ));
  }
}
