# Movie App ReadMe

## Overview

Welcome to the Movie App project! This document provides essential information for engineers to quickly get started with the codebase. The Movie App is a SwiftUI and UIKit based iOS application that allows users to view display popular movie and its detail.

## Getting Started

1. Clone the repository.

```bash
  $ git clone https://github.com/WhyMeP/MovieApp
```

2. Add your API key to the `AppConfig.xconfig` file under key call `MOVIE_API_KEY`.
3. To disable login flow go to the `AppConfig.xconfig` file under key call `ENABLE_LOGIN` and set it to `NO`
4. Explore and contribute to the project!

## Architecture

Follow the MVVM-C architecture. For SwiftUI and UIKit. Each feature has its own coordinator and the coordinator controls the navigation for the feature journey. For SwiftUI use the publish properties to communicate from the view model to the view whereas UIKit uses delegate approach. The navigation is done using UINavigationController where the SwiftUI is view is embeded in UIHostController. The overall architecture can be summarized as follows:

**Coordinator -> View -> ViewModel -> Repository**

## Design Decisions

I approached this assessment to highlight my skills rather than completing a production-ready app. Instead of using a strings file for the entire app, I applied it only on the login screen. Likewise, for the unit tests, I wrote them only for the `MovieListViewModel` and `MovieRepository`. For the login flow, I decided to store the credentials in `UserDefaults` instead of `KeyChain` due to time constraints. Ideally, I would store them in the `KeyChain`.

I would have used the following libraries if it were an option:

1. [Swinject](https://github.com/Swinject/Swinject) for dependency injection instead of creating a custom one `DependencyContainer`
2. [Kingfisher](https://github.com/onevcat/Kingfisher) for downloading and caching images. UsI usee the Apple `AsyncImage` which does not provide caching functionality.

## Challenges

One challenge faced was avoiding duplication of components. To solve this, I decided to create all the common components, such as the `LoadingView` and `ErrorView`, in SwiftUI and consume them as UIHostingControllers for the UIKit features.
