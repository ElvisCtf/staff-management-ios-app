
# Staff Management App

StaffConnect is a secure app for employees to quickly access staff info and connect with colleagues.

<br>




## Tech Stack

**Design Pattern:** MVVM, Dependency Injection, Observer

**Native Framework:** SwiftUI, SwiftData, Foundation, Security, Swift Testing

**Language:** Swift

<br>




## Features
### Login Authentication Page
- ✅ Simple UI for email and password input and action button
- ✅ Validation
- ✅ Masked password
- ✅ Indicator for API Loading
- ✅ Go to the Staff Directory page if successful login
- ✅ Error handling

### Staff Directory Page
- ✅ Display user token at the top of the page
- ✅ Show a loading indicator when reaching the bottom of the current page
- ✅ Pagination

### Persistent Login Session
- ✅ Store the user token in Keychain if successful login
- ✅ Go to staff directory page directly if the user token exists

### Offline Mode
- ✅ Display cached data if the user log in and previous data is cached
    - The user token and cached data are cleared if the user log out
    - Avatar image is not cached in the database

<br>




## Run Locally
**IDE:** XCode 16.0

**Minimum iOS:** 17.0

1. Clone the project
2. To run on a physical device, set your Apple Developer Team ID in the project settings or .xcconfig file.
<br>
 



## Screenshots

<img src="https://github.com/user-attachments/assets/efcb1f25-8f34-4f78-a5f6-471472a1d8e8" width="200"/>
<img src="https://github.com/user-attachments/assets/5ce8ae3e-4fdd-417c-9198-2e781236e26e" width="200"/>
<img src="https://github.com/user-attachments/assets/532abd5e-b918-4828-a5cd-ea5a39d9ec59" width="200"/>

<br>

<img src="https://github.com/user-attachments/assets/359783e5-5e34-4c48-9c2f-c223f330e829" width="200"/>
<img src="https://github.com/user-attachments/assets/3efd6830-d985-44b9-bbf2-b1508172e025" width="200"/>