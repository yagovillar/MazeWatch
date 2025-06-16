# MazeWatch

MazeWatch is an iOS application that allows users to browse and search TV series using the TVMaze API. The app provides a modern, user-friendly interface for discovering and exploring TV shows.

## Features

### Mandatory Features ✅
- [x] List all TV series with pagination
- [x] Search series by name
- [x] Display series name and poster image in listings
- [x] Detailed series view showing:
  - Name
  - Poster
  - Air schedule (days and time)
  - Genres
  - Summary
  - Episodes organized by season
- [x] Detailed episode view showing:
  - Name
  - Number
  - Season
  - Summary
  - Image (when available)

### Bonus Features ✅
- [x] People search functionality
  - Search by name
  - Display name and image

## Technical Implementation

### Architecture
- MVVM (Model-View-ViewModel) architecture
- Coordinator pattern for navigation
- Protocol-oriented programming
- Clean code principles

### Key Components
- **Network Layer**
  - Robust API integration with TVMaze
  - Proper error handling
  - Efficient data caching

- **UI Components**
  - Custom table views
  - Modern UI design
  - Smooth scrolling
  - Loading states
  - Error feedback

- **Testing**
  - Unit tests for ViewModels
  - Service layer testing
  - UI component testing

### Code Quality
- SwiftLint integration
- Comprehensive error handling
- Memory management
- Documentation
- Code organization

## Requirements
- iOS 15.0+
- Xcode 14.0+
- Swift 5.0+

## Installation
1. Clone the repository
```bash
git clone https://github.com/yourusername/MazeWatch.git
```
2. Open `MazeWatch.xcodeproj` in Xcode
3. Build and run the project

## Project Structure
```
MazeWatch/
├── Core/
│   ├── Views/
│   ├── Services/
│   └── Utils/
├── Scenes/
│   ├── ShowHomeList/
│   ├── Search/
│   └── ShowDetail/
├── Models/
└── Resources/
```

## Testing
The project includes comprehensive test coverage:
- ViewModel tests
- Service layer tests
- UI component tests
...
