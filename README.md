
# 🌍 Global Impact Swipe

## Project Summary

Global Impact Swipe is a **sustainability-focused mobile app** built as part of our Mobile Development module at the **Dundalk Institute of Technology** under the supervision of **Dr. Ruth McKeever**.

The app was developed by:
- **Patrick Orjieh** (Student Number: D00251785)
- **Robert Nugent** (Student Number: D00244618)

Our app contributes towards the **United Nations Sustainable Development Goals (SDGs)** by helping users discover and engage with impactful sustainability projects around them.

---

## App Overview

**Mission**:  
To promote sustainable projects based on users' locations by allowing them to swipe through projects, like or unlike them, and get matched with opportunities to make a real-world impact.

**How it works**:
- Set your **Location** (Permission is requested properly as per Apple Guidelines ✅).
- Swipe **Right** to like projects, **Left** to dislike them, or **Double Tap** to view full details.
- View **Tips of the Day** and learn how to make the world a better place.
- Matched Projects are saved, and you can access them anytime.
- Notifications alert users after liking a project.

---

## Features

| Feature | Description | Screenshot |
|:-------:|:------------|:-----------:|
| **Splash Screen** | Animated splash screen introducing Global Impact Swipe. | ![Splash Screen](https://github.com/user-attachments/assets/61bd84a8-bbac-479c-86ba-2d4a53a74a8a) |
| **Set Location** | Search for location with MapKit integration. Requests user permission properly. | ![Set Location](https://github.com/user-attachments/assets/84ecd941-ec0b-4d55-b4a7-e3c8e5fff6ae) |
| **Swipe Projects** | Swipe left, right, or double tap for details. Smooth animations included. | ![Swipe View](https://github.com/user-attachments/assets/2c3acc7a-4808-4feb-86fd-96fdc438b914) |
| **Matches View** | View all the projects you liked! | ![Matches View](https://github.com/user-attachments/assets/4d00b546-12d4-4a78-8580-7d128a6a33f1) |
| **Notifications** | Get notified locally when you like a project (60-second delay). | ![Notifications View](https://github.com/user-attachments/assets/7ad818a6-fc53-4c29-9620-98d5a9960bc5) |
| **Dark Mode Support** | Fully functional in both light and dark themes. | ![Dark Mode View](https://github.com/user-attachments/assets/8fde5376-a9e7-48e3-bacd-3a20511bb4ae) |

---

## Architecture and Code Structure

We used a combination of:

- **Model-View-Controller (MVC) Pattern** — especially for the early screens like Login, Registration, and Home.
- **MVVM (Model-View-ViewModel) Pattern** — for areas like HomePage, Swipe, and Notifications, to better separate logic and views.

---

## Technologies and Independent Learning

We went beyond basic SwiftUI knowledge by integrating:

- **Firebase Authentication** for Email/Password Sign-In and Apple Sign-In.
- **Location Management with MapKit** (also learned how to use Search AutoComplete with Apple's APIs).
- **Apple Sign In Integration** — understanding OAuth2 authentication with Apple.
- **Image Carousel** with smooth auto-scroll animations.
- **Gesture Recognizers**:
  - Swipe Left ➡️ Dislike a project
  - Swipe Right ➡️ Like a project
  - Double Tap ➡️ Open Project Details
  - Single Tap ➡️ Dismiss popups or menus
- **Local Notifications** using `UNUserNotificationCenter`.
- **Local Storage**:
  - **SwiftData** for persisting locations, notifications, liked projects.
  - **UserDefaults** for small cached objects like random tips and projects.
- **Light and Dark Mode** Support automatically throughout the app.
- **Animations** on Splash screen and throughout transitions for a more modern experience.

All these were **independently researched and learned** during the project. 

---

## Good Practices

We made sure to follow:

- ✅ **Clean Code Practices** (small files, reusable components, no duplication).
- ✅ **Standard Error Handling** especially during Firebase login and registration (alerts and user-friendly messages).
- ✅ **Permission Requests** implemented properly:
  - Location permission asked **only when needed**.
  - Notification permission asked **on app launch**.
- ✅ **Safe Network Calls** using async/await.
- ✅ **Good UI/UX Design Principles**:
  - Consistent spacing, colors, and fonts.
  - Scrollable, responsive designs.
  - Proper navigation patterns using `NavigationStack`.

---

## How We Meet Assignment Context (SDGs)

Our app directly supports the United Nations **Sustainable Development Goals** (SDGs):

We encourage users to **engage with local projects** tackling environmental and sustainability issues through an easy and fun mobile experience.

Each project in our app is tied to one or more SDGs, making it **easy for users to contribute to global change** starting from their own local communities.

---

## Installation and Setup

1. Clone the repository.
2. Open the `.xcodeproj` file in **Xcode 15 or later**.
3. Make sure to have an iOS Simulator (or device) running iOS 17+.
4. Run the app.
5. To get full functionality:
   - Start the local Node.js API (port 4000).
   - Images are served from the `/images` folder.
   
To start backend:

```bash
npm install
node server.js
```

---

## Future Improvements

- Adding push notifications via **Firebase Cloud Messaging (FCM)**.
- More personalized matching algorithm.
- Support for real-time project updates from a cloud backend.

---

# More Screenshots

| Screen | Preview |
|:------:|:--------:|
| Project Details | ![Project Detail Screenshot](https://github.com/user-attachments/assets/e8a35f5f-0dc9-4b50-b0a7-062daa634b56) |

---

# License

This project is for academic purposes only, as part of the Dundalk Institute of Technology Mobile Development Module (2025).
