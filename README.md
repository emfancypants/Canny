# NUS Orbital Project 2021 - Canny

## Team Members:
Kang Yunru, Ruth

Emily Kok Fang Ning

## Project Documentation:
[Team Canny Documentation](https://docs.google.com/document/d/1h3EhTxIGTq1qZNmJ-EMcCXW4EAvF8Qw_jmZqraAEv-4/edit?usp=sharing)

## 1. Project Overview
### Motivation
As university students who are venturing into adulthood, we find ourselves struggling to keep track of our finances. Some might find it a hassle to note down every little purchase they make, while others simply don’t find the need to do so. However, it is definitely important for us to keep track of their finances to know where our money goes so that we can ensure that our money is used wisely.

A simple solution that many use would be money tracking applications on their phones, which are not user friendly, and are hard to use. When in a rush, one would not be in the right frame of mind to slowly navigate their way through the application, just to key in that they spent $3.50 on their chicken rice for lunch. And by the time the day ends, one would simply forget that they had spent that money on lunch. This might not seem to be a problem at the start, but as the amount snowballs, their spending habits are not accurately reflected through the application, thus the application is now purposeless to the user. At the end of the day, the user would simply delete the application.

### Aim
We intend to create an **android application** to allow university students to have a proper budget planning as they venture into adulthood. This enables students to determine in advance whether they will have enough money to do the things they need to do or would like to do in the future.

### User Stories
1. As a student who is entering adulthood, I want to have a targeted monthly spending.
2. As a student who has been worrying about my expenditure, I want to be able to keep track of my daily spendings. 
3. As a student, I tend to spend more on entertainment, I want to allow myself to keep track of my spendings in different categories such as entertainment, transport, food, etc.
4. As a student, I want to know if I still have sufficient budget to spend in that month.
5. As a student, I would like a simplified user interface to keep track of my spendings, but also a detailed report on my spending habits.
6. As a student, I want to be able to have a platform to discuss with other students on money saving techniques.

### Tech Stack
The following technologies will be used in the process of developing the mobile app:
* **Flutter & Dart:** for app development and front-end purposes
* **Firebase:** for back-end purposes
* **Git & GitHub:** for repository and source-code control

## 2. Features
### Login Function
* **Login Page (email + password)**
  * Users will login using their registered email and password. If they do not have an account, link them to the register page. Login page will be linked to the Functions page.
* **Register Page**
  * Users will register an account with the app using their email and password if they are a first time user.
* **Functions Page**
  * Users can choose between inputting a quick input or viewing a comprehensive home screen. 

### Quick Input Function
* **Calculator Screen**
  * Consists of just a number pad and buttons for the most used categories, which makes it easier for the user to just key in the amount and pick the category for the spending on the go. This segment will be linked to the receipt function.

### Dashboard Function
* **Budget**
  * Shows the users total expenditure and total income, together with their balance amount.
* **Expenses Breakdown**
  * Keeping track of the percentage spent on each category. There will be a part showing the total amount spent so far by the user and the amount left for them to spend based on their monthly targeted spending amount.
* **Expenses Summary**
  * Shows the users expenditure categories. In each category, there will be the total amount spent by the user for that category.
* **Recent Receipts**
  * Shows the top 5 most recent receipts of the user.

### Receipt Function
* **Spending**
  * Where the user's history of transactions will be displayed, together with its category and date of transaction. 
* **Filter**
  * Users are able to filter their receipt screen by categories and dates.

#### Category Function
* **View Categories**
  * Users are able to view all their current categories.
* **Filter**
  * Users are able to filter and edit their non default categories

### User Interactions
* **Forums**
  * For users to interact and share with their peers good tips to save money. Users can also share different deals they come across on the forums. This will also include a like system where users are able to like the posts and comments posted by other users.

### Insert Function
* **Enter Targeted Expenditure**
  * For users to key in their targeted monthly spending amount.
* **Add Category**
  * For users to add their categories. 
* **Add Spending**
  * For users to add their spendings.

### Reminder Function
* **Notification**
  * Reminds the user at a set time everyday to key in their expenses for the day. 

### Side Bar
* **Customise Quick Input**
  * Users can change the buttons on the quick input screen to the most used categories to spendings the user makes on a frequent basis, to make keying in their expenditures easier.
* **Customise Dashboard**
  * Users can choose what to include in their dashboard.
