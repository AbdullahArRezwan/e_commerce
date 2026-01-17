# 🛒 E-Shop (E-Commerce Mobile Application using Flutter)

A full-featured **E-Commerce mobile application** built with **Flutter**, offering user authentication, product browsing, category-based shopping, wishlist management, and user profile features. The project follows a modular and scalable architecture suitable for real-world applications.

---

## 📱 Features

### 🔐 Authentication & User Management
- User Sign Up & Sign In
- Email and Phone Number Login (OTP-based)
- Email Verification
- Password Reset & Change Password
- Splash Screen with Auth Decision Flow

### 🛍️ Shopping Experience
- Category-wise product listing
- Product details view
- Wishlist functionality
- Order history tracking

### 👤 Profile Management
- View & edit profile
- Order history
- Wishlist
- Secure password change

### 🧾 Product Categories
- Men’s Fashion  
- Women’s Fashion  
- Kids  
- Accessories  
- Unstitched Prints  
- Sweaters & Tops  

---

## 🏗️ Project Structure

---lib/
├── main.dart
├── routes.dart
├── Authentication/
│ ├── Sign_in.dart
│ ├── Sign_up.dart
│ ├── OTP_Screen.dart
│ ├── ResetPassword.dart
│ └── ...
├── Constatnt/
│ ├── BottomBar.dart
│ ├── CategoryItems.dart
│ └── ...
├── HomeScreen/
│ ├── HomeScreen.dart
│ ├── ProductDetails.dart
├── Profile/
│ ├── Profile.dart
│ ├── Edit_profile.dart
│ ├── OrderHistory.dart
│ └── WishList.dart

## 🧰 Tech Stack

| Technology | Description |
|----------|-------------|
| Flutter | Cross-platform mobile framework |
| Dart | Programming language |
| Firebase | Authentication & backend services |
| Material UI | UI components |
| Android SDK | Android build support |

---

## 🔥 Firebase Integration

Firebase is used for:
- User authentication
- Email verification
- OTP-based login

Firebase config file:


