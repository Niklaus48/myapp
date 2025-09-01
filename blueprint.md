# Online Shop Flutter App

## Overview

This is a Flutter application for an online shop. It uses Firebase for authentication and displays a list of products from a dummy API. Users can view product details, add products to their cart, and search for products.

## Features Implemented

* **Firebase Authentication:** 
    * Users can log in with email and password.
    * **Dynamic Profile Button:** The app bar now displays a profile icon for logged-in users and a "Sign In" button for guests.
    * **Sign Out:** Users can sign out from their profile screen.
* **Tabbed Profile Screen:** The profile section is organized into three tabs:
    * **Favorites:** Users can view a list of their favorited items, accessed through their profile.
    * **Order History:** A dedicated screen to display the user's past orders.
    * **Personal Data:** Users can view and edit their personal information, including name, phone number, and address.
* **Product List:** The main screen of the application, displaying a list of products with their thumbnail, title, and price.
* **Product Detail:** Shows the details of a selected product, including images, description, and price.
* **Product Search:** Users can search for products by name.
* **Unified Filter Section:** 
    * A collapsible section that combines category and price filters for a cleaner UI.
    * **Category Filter:** Users can filter products by category.
    * **Price Filter:** Users can filter products by price using a range slider.
* **Advanced Shopping Cart:**
    * Users can add products to their shopping cart.
    * Users can view the items in the cart.
    * **Quantity Management:** Users can increase or decrease the quantity of each item in the cart.
    * **Remove Items:** Users can remove items from the cart by swiping them away.

## Next Steps

* Implement a checkout process.
* Populate the "Favorites" and "Order History" screens with dynamic data.
* Improve the UI/UX of the application.
* Add more error handling and user feedback.
