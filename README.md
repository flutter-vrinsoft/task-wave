# Task Wave
 
**Task Wave** is a Flutter-based task management application that allows users to create, update, and manage tasks efficiently. The app features dynamic theming, responsive design, and robust state management using the BloC pattern.
 
## Table of Contents
 
1. [Features](#features)
2. [Installation](#installation)
3. [Usage](#usage)
4. [Building the APK](#building-the-apk)
5. [Automating workflow](#Automating-workflow)
6. [Demo Video](#demo-video)
 
## Features
 
- **Task Management:**
  - Create Tasks: Add new tasks with details such as title and description.
  - Update Tasks: Modify existing tasks as needed.
  - Delete Tasks: Remove tasks that are no longer needed.
  - Comment on Tasks: Add comments for better task collaboration.
 
- **Theming:**
  - Dynamic theming controlled by a `ThemeCubit` for a customizable user interface.
 
- **Responsive Design:**
  - Utilizes the `SizeConfig` package to ensure proper scaling on various screen sizes.
 
- **State Management:**
  - Implemented the BloC architecture pattern for efficient state management and testing.
 
## Installation
 
To get started with Task Wave, follow these steps:
 
1. **Clone the Repository**
 
   ```bash
   git clone https://github.com/flutter-vrinsoft/task-wave.git
   cd task_wave
   ```

   or you can download it.
 
2. **Install Dependencies**
 
   Ensure you have Flutter installed. Then, install the required Dart packages by running:
 
   ```bash
   flutter pub get
   ```
 
3. **Run the App**
 
   You can run the app on an emulator or physical device using:
 
   ```bash
   flutter run
   ```
 
## Usage
 
After running the app, you can:
 
- **Create Tasks:** Tap on the "Create Task" button to add new tasks.
- **Update Tasks:** Edit task details by selecting a task and updating its information.
- **Comment on Tasks:** Add comments to tasks for collaboration.
- **View Tasks with Kanban Board:** View your tasks in Kanban board , also you can drag them to update status of your tasks.
 
 
## Building the APK
 
To build the APK for release:
 
1. **Prepare for Release**
 
   Ensure your `android/app/build.gradle` file is properly configured for release.
 
2. **Build the APK**
 
   Run the following command to build a release APK:
 
   ```bash
   flutter build apk --release
   ```
 
   The generated APK will be located in `build/app/outputs/flutter-apk/app-release.apk`.
 
## Automating workflow with CI/CD
Go to the Actions Tab
Click on the "Actions" tab located at the top of your repository page. This will display a list of all workflows and their recent runs.
Select the Workflow
Find the workflow you want to trigger or rerun. Click on the workflow to view the list of runs for that workflow.
Manually Trigger a Workflow
If your workflow is configured to support manual triggering (using the workflow_dispatch event), you will see a "Run workflow" button on the right side of the page. Click this button to start the workflow manually. If this button is not available, the workflow might not be configured for manual triggering.
 
Click "Run Workflow"
Click the "Run workflow" button to initiate the workflow. You will be redirected to a page where you can monitor its progress.
Rerun a Workflow
 
## Locating and Downloading Artifacts
Once the workflow completes, you can find the built APK and other artifacts as follows:
 
Access the Artifacts
After the workflow completes, go to the "Actions" tab and select the workflow run you are interested in.
View Artifacts
On the workflow run details page, scroll down to the "Artifacts" section. You will find a list of artifacts generated by the workflow.
Download the APK
Locate the artifact containing the APK. Click on the download link to download the APK file to your local machine. The artifact will usually be named something like app-release.apk.
 
 
## Demo Video
Here's demo video of Task Wave app:

https://github.com/user-attachments/assets/e2df4aff-1506-4cfd-97dd-87a1f50450b2

