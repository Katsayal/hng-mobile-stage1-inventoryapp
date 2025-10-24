# InventoryApp 🛒

![Flutter](https://img.shields.io/badge/Flutter-3.0-blue?logo=flutter)  
![Dart](https://img.shields.io/badge/Dart-3.0-blue?logo=dart)  
![HNG13](https://img.shields.io/badge/HNG-13-green)

A **Flutter-based local inventory management app** for storekeepers. The app allows you to **manage products locally**, with full **CRUD operations**, image capture, CSV/JSON export, dark mode, and category management.

## **RELEASE APK**
**Click to download latest release👉** [![Download APK](https://img.shields.io/badge/Download-APK-blue?style=for-the-badge&logo=android)](https://github.com/Katsayal/hng-mobile-stage1-inventoryapp/releases/download/v1.0.0/app-release.apk)

## **GITHUB REPO**
**Click to go to github repo👉** [![Github](https://img.shields.io/badge/Git-HUB-blue?style=for-the-badge&logo=github)](https://github.com/Katsayal/hng-mobile-stage1-inventoryapp.git)

## **APETIZE APK LINK
*Click to play demo on appetize.io👉* ** [![Play Demo](https://img.shields.io/badge/Play-Demo-blue?style=for-the-badge&logo=googleplay)](https://appetize.io/app/b_ceunmy4eegz5i6wypq4o6g7vru)

## **DEMO VIDEO**
Click to watch demo video👉 [![Play Video](https://img.shields.io/badge/Play-Video-blue?style=for-the-badge&logo=youtube)](https://drive.google.com/file/d/1EYXD0MfbEw-xgf54euEFLTQiK-o3UkRg/view?usp=drivesdk)

---

## **Features**

* **Add / Edit / Delete Products**

  * Each product includes:

    * Name
    * Quantity
    * Price
    * Category
    * Image (camera/gallery)

* **View Products**

  * Clean, professional interface
  * Product cards show all details

* **Category Management**

  * Predefined categories: General, Electronics, Clothes, Food
  * Ability to filter products by category

* **Search & Filter**

  * Quick search by product name
  * Filter by category

* **Export Inventory**

  * Export product data to CSV or JSON
  * Files saved to **Documents folder** for easy access

* **Dark / Light Mode**

  * Toggle between light and dark mode.
  * Automatically persists theme preference

* **Local Database**

  * Uses **Drift (SQLite)** for efficient local storage

---

## **Getting Started**

### **Prerequisites**

* Flutter SDK ≥ 3.0
* Dart SDK ≥ 3.0
* Android Studio / VS Code

### **Installation**

1. Clone the repository:

```bash
git clone https://github.com/Katsayal/hng-mobile-stage1-inventoryapp.git
cd inventoryapp
```

2. Install dependencies:

```bash
flutter pub get
```

3. Run the app on your emulator or device:

```bash
flutter run
```

---

## **Folder Structure**

```
lib/
├── data/
│   └── database.dart       # Drift database & tables
├── providers/
│   ├── product_provider.dart
│   └── theme_provider.dart
├── screens/
│   ├── home_screen.dart
│   └── add_edit_screen.dart
├── widgets/
│   └── product_card.dart
└── main.dart
```

---

## **Usage**

1. **Add Product** – Click the "+" button, fill details, take/upload image, select category, save.
2. **Edit Product** – Tap the edit icon on a product card.
3. **Delete Product** – Tap the trash icon, confirm deletion.
4. **Search / Filter** – Use the search bar or category filter dropdown.
5. **Export Inventory** – Tap the export icon to save CSV/JSON to Documents folder.
6. **Toggle Dark Mode** – Tap the sun/moon icon in the AppBar.

---

## **Dependencies**

* [Flutter](https://flutter.dev) – UI toolkit
* [Drift](https://drift.simonbinder.eu/) – Local database (SQLite)
* [Provider](https://pub.dev/packages/provider) – State management
* [Image Picker](https://pub.dev/packages/image_picker) – Camera/gallery integration
* [Intl](https://pub.dev/packages/intl) – Currency formatting

---