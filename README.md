# happy_shopy

A online shopping app that offers a good shopping experience

## Getting Started

- All the bugs and not-working functions have been declared below to the best of my knowledge.  If you can find more bugs, please let me know
- ***For testing purposes*** There are 3 login credentials below.
- ***For testing purposes*** There are a few test credit card information below.
- ***NOTICE*** Configuration for web app has changed to the newer version
- To install splash screen, run the following command in flutter terminal:
  +  flutter pub run flutter_native_splash:create


## Credits

- https://codelabs.developers.google.com/codelabs/flutter
- https://firebase.flutter.dev/docs/auth/usage
- https://firebase.flutter.dev/docs/firestore/usage
- https://github.com/SimformSolutionsPvtLtd/flutter_credit_card
- https://pub.dev/packages/flutter_credit_card
- https://www.filledstacks.com/post/building-flutter-login-and-sign-up-forms/
- https://www.youtube.com/playlist?list=PL4cUxeGkcC9jLYyp2Aoh6hcWuxFDX6PBJ
- https://www.youtube.com/watch?v=fi2WkznwWbc
- https://www.youtube.com/watch?v=NHAIiAmxTAU
- https://www.youtube.com/watch?v=wHIcJDQbBFs
- https://medium.com/flutter-community/a-chat-application-flutter-firebase-1d2e87ace78f


## Github Link

https://github.com/thuyn789/happy_shopy


## Supported Platform

- Android
- Web


## Supported Login

- Email/password login
- Google social login
- Anonymous sign-in


## API

- Firebase API: Authentication, Cloud Firestore, Storage
- Stripe Payment API via stripe_payment package


## Dependencies

flutter:
    sdk: flutter
cloud_firestore: ^2.4.0
flutter_credit_card: ^2.0.0
firebase_auth: ^3.0.1
firebase_core: ^1.4.0
google_sign_in: ^5.0.5
simple_animations: ^3.1.1
stripe_payment: ^1.1.4


## Dev_Dependencies

flutter_test:
    sdk: flutter
flutter_native_splash: ^1.2.0

#This is a configuration for splash screen for android and web app
flutter_native_splash:
  color: "#FFD180"
  image: images/loading_screen.png
  android: true
  web: true
  ios: false
  web_image_mode: center
  color_dark: "#000000"


## defaultConfig

- applicationId "com.example.happy_shopy"
- minSdkVersion 28
- targetSdkVersion 30


## Firebase key for web

var firebaseConfig = {
    apiKey: "AIzaSyCAN6ltkh5UO6UYwLF3FmJrHt73bCfLgj8",
    authDomain: "supercool-rental.firebaseapp.com",
    databaseURL: "https://supercool-rental-default-rtdb.firebaseio.com",
    projectId: "supercool-rental",
    storageBucket: "supercool-rental.appspot.com",
    messagingSenderId: "138927912921",
    appId: "1:138927912921:web:4a28b2011ffb2605464bc8"
};


## Configuration for web app

- Please use the correct firebase web app version (8.7.1) 

<script src="https://www.gstatic.com/firebasejs/8.7.1/firebase-app.js"></script>
<script src="https://www.gstatic.com/firebasejs/8.7.1/firebase-firestore.js"></script>
<script src="https://www.gstatic.com/firebasejs/8.7.1/firebase-auth.js"></script>
<script src="./scripts/firebase-key.js"></script>


## Basic App Structure

- The root widget: main.dart
- After login, the app will bring user to a home screen to browser products
- All other screens will be accessible as options via the navigation drawer
  + These options will be available to users based on their role.
  + The options for the base role of users, which is 'customer', will be available to all other roles of users.
- Users will be able to see their shopping cart on different devices as long as they use the same login credential.  For example, users can add an item to cart on their mobile devices, and they can also see the same item on web app and checkout on web app if they prefer.


## Database Structure

- All user information is stored in users -> userID
  + {email, first_name, last_name, reg_date_time, urlAvatar, user_id, user_role}
- All product information is stored in products -> productID
  + {brand, id, imageURL, name, price}
- All items in cart are stored in orders -> userID -> cart
  + Cart information, such as item count, subtotal, etc are stored in userID, which the parent document of cart
- All orders are stored in orders -> userID -> orders -> orderNumber
- All items in an order are stored in orders -> userID -> orders -> orderNumber -> items


## Login Credentials for Demo Accounts

- Admin: admin@admin.com, password

- Customer Support: support@email.com, password

- Customer: customer@email.com, password


## Basic Test Card Numbers

- Visa
  + 4242 4242 4242 4242
  + CVC: Any 3 digits
  + Exp: Any future date

- Mastercard
  + 5555 5555 5555 4444
  + CVC: Any 3 digits
  + Exp: Any future date

- American Express
  + 3782 822463 10005
  + CVC: Any 4 digits
  + Exp: Any future date

- Discover
  + 6011 1111 1111 1117
  + CVC: Any 3 digits
  + Exp: Any future date


## Bugs and Not Working
- Web version is not working properly due to Network Image