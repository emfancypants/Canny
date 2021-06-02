import 'package:Canny/Models/category.dart';
import 'package:flutter/material.dart';

List<Category> defaultCategories = [
  foodDrinks,
  transportation,
  shopping,
  entertainment,
  billAndFees,
  education,
  gift,
  household,
  allowance,
  salary,
  loan,
  others,
];

Category foodDrinks = Category(
  categoryName: 'Food & Drinks',
  categoryIcon: Icon(Icons.fastfood_rounded),
  categoryColor: Colors.green[800],
  categoryId: '00',
);

Category transportation = Category(
  categoryName: 'Transportation',
  categoryIcon: Icon(Icons.directions_bus),
  categoryColor: Colors.red[800],
  categoryId: '01',
);

Category shopping = Category(
  categoryName: 'Shopping',
  categoryIcon: Icon(Icons.shopping_bag_rounded),
  categoryColor: Colors.pinkAccent,
  categoryId: '02',
);

Category entertainment = Category(
  categoryName: 'Entertainment',
  categoryIcon: Icon(Icons.local_movies_rounded),
  categoryColor: Colors.deepOrange,
  categoryId: '03',
);

Category billAndFees = Category(
  categoryName: 'Bills and Fees',
  categoryIcon: Icon(Icons.sticky_note_2_rounded),
  categoryColor: Colors.purple[800],
  categoryId: '04',
);

Category education = Category(
  categoryName: 'Education',
  categoryIcon: Icon(Icons.school_rounded),
  categoryColor: Colors.blue,
  categoryId: '05',
);

Category gift = Category(
  categoryName: 'Gift',
  categoryIcon: Icon(Icons.card_giftcard_rounded),
  categoryColor: Colors.amber[700],
  categoryId: '06',
);

Category household = Category(
  categoryName: 'Household',
  categoryIcon: Icon(Icons.home_work_rounded),
  categoryColor: Colors.teal,
  categoryId: '07',
);

Category allowance = Category(
  categoryName: 'Allowance',
  categoryIcon: Icon(Icons.person),
  categoryColor: Colors.indigo[600],
  categoryId: '08',
);

Category salary = Category(
  categoryName: 'Salary',
  categoryIcon: Icon(Icons.attach_money_rounded),
  categoryColor: Colors.pink[900],
  categoryId: '09',
);

Category loan = Category(
  categoryName: 'Loan',
  categoryIcon: Icon(Icons.location_city_rounded),
  categoryColor: Colors.orange,
  categoryId: '10',
);

Category others = Category(
  categoryName: 'Others',
  categoryIcon: Icon(Icons.scatter_plot),
  categoryColor: Colors.grey[700],
  categoryId: '11',
);
