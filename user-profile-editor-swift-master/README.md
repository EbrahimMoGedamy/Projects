**User Profile Editor By Swift 4**
===================
Build a user profile editor application implementing by **VIPER iOS software architecture**.
It is a user profile editor application. User should be able to enter his personal info and view it in another screen after submission.
Screens

----------

What is VIPER architecture?
-------------
- **VIPER** is a backronym for **View**, **Interactor**, **Presenter**, **Entity**, and **Router**.
- This architecture is based on **Single Responsibility Principle** which leads to a **clean architecture**.
	- **View**: The responsibility of the view is to send the user actions to the presenter and shows whatever the presenter tells it.
	- **Interactor**: This is the backbone of an application as it contains the business logic.
	- **Presenter**: Its responsibility is to get the data from the interactor on user actions and after getting data from the interactor, it sends it to the view to show it. It also asks the router/wireframe for navigation.
	- **Entity**: It contains basic model objects used by the Interactor.
	- **Router**: It has all navigation logic for describing which screens are to be shown when. It is normally written as a wireframe.


![enter image description here](https://camo.githubusercontent.com/2398365d539a5b3675567a4abaa91ce6a060efda/68747470733a2f2f63646e2d696d616765732d322e6d656469756d2e636f6d2f6d61782f3830302f312a30704e33424e545866774b626630386c6877757461672e706e67)

Viper architecture is used for building large projects, but for the sake of understanding, I have created a very simple app to describe it properly.

----------

The application consists of the **Two Screens**:
-------------------

1. **User Form Screen**
	 - As a user, I should be able to enter my **name**.
	 - As a user, I should be able to enter my **email**.
	 - As a user, I should be able to select my **country** (using **Picker View**) from a set of predefined countries.
	 - As a user, I should be able to enter my **age** (using **Date Picker**).
	 - As a user, I should be able to enter my **gender** (using **Segmented Control**).
	 - As a user, I should be able to **show/hide** my name on my profile (using **Switch Control**).
	 - As a user, I should be able to see an **error message/feedback** if any of my fields is not valid upon submission.
2. **Profile Screen**
	- As a user, I should be able to **view my profile**.
	- As a user, I should be able to **edit my profile**.
