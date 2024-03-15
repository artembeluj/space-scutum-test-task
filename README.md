Project Documentation

Introduction

Welcome to the documentation for the Flutter project. This project is structured into three main folders: 
core, pages, and shared. Each folder serves a specific purpose in organizing the codebase.

Folder Structure

1. Core
   The core folder contains fundamental logic and utilities essential for the project's functionality. 
Here you'll find: database Logic. This folder houses the root logic for creating and managing the SQLite 
database using SQLlite. It encapsulates all database-related operations, providing a centralized approach 
to database management.

2. Pages
   The pages folder comprises individual pages or screens of the application. It contains the main user 
interface and logic for each page. Here's a breakdown of the pages:

Main Page: The entry point of the application.

House List Page: Displays a list of houses and their details. It incorporates the core logic for 
managing houses and interactions with the database.

Floors Page: Shows information about floors in a house. Additionally, it integrates a MethodChannel 
to communicate with native code (Kotlin) for sending background messages every minute.

3. Shared
   The shared folder contains reusable components, constants, and models that can be shared across 
multiple parts of the application. Here's what you'll find:

Constants: Constants and enums used throughout the project.

Widgets: Custom widgets that can be reused across different pages or screens.

Models: Data models representing entities used within the application. These models facilitate structured data handling and management.
Conclusion

With this organized folder structure, the project maintains a clear separation of concerns, making it 
easier to maintain and scale. Each folder serves a distinct purpose, promoting modularity and 
reusability across the codebase.
