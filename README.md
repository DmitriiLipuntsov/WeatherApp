# WeatherApp

WeatherApp is a mobile application that provides weather forecasts for different locations. It fetches weather data from the OpenWeatherMap API and displays it to the user.

## Screenshots
<img src="https://github.com/DmitriiLipuntsov/WeatherApp/blob/main/screen.png" width="200" height="400"/> <img src="https://github.com/DmitriiLipuntsov/WeatherApp/blob/main/screen0.png" width="200" height="400"/>

## Features

- Display current weather for the user's location.
- Allow users to change the location to view weather forecasts for other cities.
- Show a tab bar with two tabs:
  - Main: Display current weather information for the user's location, including temperature, city name, and a brief weather condition description.
  - Forecast: Display a weather forecast for the selected location for the next few days.
- Implement a central button in the tab bar with an enlarged size.
- Handle location access permission requests and display appropriate messages to the user.
- Offline mode: Cache weather data for offline viewing.

## Technologies Used

- Swift programming language
- SwiftUI framework for building user interfaces
- Combine framework for reactive programming
- CoreLocation framework for location services
- URLSession for network requests
- OpenWeatherMap API for weather data
- User Default for local data storage

## Additional Notes

Development Time: Approximately 10 hours.
Design: The project focused more on functionality rather than design aesthetics. Further improvements in design and layout adaptation for different screen sizes are needed.
Data Management: More detailed work is required on data storage, testing, performance optimization, and memory leaks.
