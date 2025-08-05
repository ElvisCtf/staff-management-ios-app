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

<img src="https://github.com/user-attachments/assets/cf17761b-fa8b-4950-98e5-62dcbc17d186" width="200"/>
<img src="https://github.com/user-attachments/assets/209abb60-d3db-43ed-a7a0-46847e4bc695" width="200"/>
<img src="https://github.com/user-attachments/assets/d38919a4-1499-47a4-9f98-4f228e2f66db" width="200"/>

<br>

<img src="https://github.com/user-attachments/assets/9c165e32-a08e-410f-8237-48d8ee4b2f84" width="200"/>
<img src="https://github.com/user-attachments/assets/007af45a-ccae-48de-aa26-55761848e8e8" width="200"/>
