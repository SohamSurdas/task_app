import 'package:flutter/material.dart';
import 'package:task_app/task.dart';

class TaskProvider with ChangeNotifier {
  List<Task> tasks = [];
  bool isDarkMode = false;

  TaskProvider() {
    loadTasks();
    loadTheme();
  }

  
  void addTask(Task task) {
    tasks.add(task);
    saveTasks();
    notifyListeners();
  }

  
  void deleteTask(Task task) {
    tasks.remove(task);
    saveTasks();
    notifyListeners();
  }

  
  void toggleTheme() {
    isDarkMode = !isDarkMode;
    saveTheme();
    notifyListeners();
  }

  
  Future<void> loadTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final taskList = prefs.getStringList('tasks');
    if (taskList != null) {
      tasks = taskList.map((taskTitle) => Task(taskTitle)).toList();
      notifyListeners();
    }
  }

  
  void saveTasks() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList('tasks', tasks.map((task) => task.title).toList());
  }

  
  Future<void> loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    isDarkMode = prefs.getBool('isDarkMode') ?? false;
    notifyListeners();
  }

  
  void saveTheme() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('isDarkMode', isDarkMode);
  }
}

class SharedPreferences {
  static getInstance() {}
}
