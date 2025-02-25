# ShinobiWay

ShinobiWay is an interactive iOS application designed to help users learn and perfect Naruto's iconic hand sign techniques. By practicing the correct sequence of gestures under timed conditions and receiving real-time feedback via a CoreML model, users can improve their speed, accuracy, and cognitive agility while immersing themselves in a gamified, anime-inspired experience.

## Overview

ShinobiWay delivers a unique training experience that:
- **Teaches Proper Technique:** Guides users through the precise sequence of hand signs required to perform various jutsus.
- **Provides Real-Time Feedback:** Uses a CoreML model for live performance verification, ensuring users receive immediate, actionable insights.
- **Gamifies Progression:** Implements a Challenge-Based Learning (CBL) system, where mastering basic techniques unlocks advanced jutsus, promoting a sense of progression and achievement.
- **Stimulates Brain and Body:** Enhances spatial processing, muscle memory, and cognitive functions through engaging, physically interactive exercises.
- **Captures the Anime Spirit:** Features visually striking custom gradients, dynamic animations, and themed sound effects that evoke the energy of the Naruto universe.

## Features

- **Interactive Hand Sign Training:** Step-by-step guidance through complex hand sign sequences.
- **Real-Time Feedback:** Integrated CoreML model evaluates hand sign performance via live camera detection.
- **Progressive Unlock System:** Advanced jutsus unlock as users master basic techniques.
- **Immersive UI:** Custom-designed visuals with dynamic gradients, smooth transitions, and an anime-inspired aesthetic.
- **Practice Mode:** Dedicated sessions to refine techniques with instant feedback.
- **Comprehensive Jutsu Library:** Curated collection of popular jutsus with detailed sequences and explanations.

## ScreenViews  

<p align="center">
  <img src="ScreenViews/Screenshot%202025-02-24%20at%2006.53.40.png" alt="Onboarding Screen" width="27%">
  <img src="ScreenViews/Screenshot%202025-02-24%20at%2006.54.10.png" alt="Hand Signs" width="27%">
  <img src="ScreenViews/Screenshot%202025-02-24%20at%2002.48.23.png" alt="Jutsu Library" width="27%">
  <img src="ScreenViews/Screenshot%202025-02-24%20at%2005.55.51.png" alt="Practice Mode" width="27%">
  <img src="ScreenViews/2025-02-24%2007.11.22.jpg" alt="Camera Detection" width="27%">
</p>



## Development Challenges

Due to short notice, I developed ShinobiWay in just 4 days. During this time, I faced several challenges, including:
- Working within Swift Playground packages in Xcode.
- Ensuring the app correctly loads the CoreML model and displays accurate output.
- Reconciling the high (99%) preview accuracy of the model with lower performance in the live app.

These challenges provided a steep learning curve, and I am committed to further refining and enhancing the app in future updates.

## Future Development

- **Enhanced ML Accuracy:** Continuously refine the CoreML model to better capture the nuances of hand signs.
- **Custom Training Programs:** Enable users to create personalized jutsu sequences and practice routines.
- **Social and Competitive Features:** Integrate leaderboards, challenges, and social sharing to build a community of ninja learners.
- **Augmented Reality Integration:** Overlay digital guidance during practice sessions for a more immersive experience.
- **Advanced Sound and Haptic Feedback:** Implement adaptive audio cues and tactile responses based on performance.
- **Localization and Accessibility:** Expand language support and accessibility options for a global audience.
- **Virtual Reality (VR):** Imagine choosing your favorite anime character and battling fellow participants in VR, where your speed, accuracy, and muscle memory translate into thrilling, real-time combat—bringing intellectual, physical, and social benefits to an entirely new level.

## Technologies

- **Swift & SwiftUI:** For a modern, responsive iOS interface.
- **CoreML & Vision:** For real-time hand sign recognition and feedback.
- **AVFoundation:** For camera integration and multimedia management.
- **GitHub:** For version control and collaborative development.

