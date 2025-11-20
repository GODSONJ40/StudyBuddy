---
title: readme

---

# StudyBuddy

## Table of Contents

* [Overview](#overview)
* [Product Spec](#product-spec)
* [Wireframes](#wireframes)
* [Schema](#schema)

---

## Overview

### Description

**StudyBuddy+** is a smart study assistant that helps students stay productive, focused, and motivated. The app lets users manage Pomodoro-style study sessions, track their progress, and view motivational quotes fetched from a public API — all in a clean, intuitive interface.

### App Evaluation

**Category:** Education / Productivity
**Mobile:** Designed for iOS using Swift and UIKit.
**Story:** Students want to improve their focus and track study progress with motivation boosts.
**Market:** High — targets students from high school to university levels.
**Habit:** Encourages daily use during study or work sessions.
**Scope:** Compact but complete — timer logic, data persistence, API integration, and navigation.

---

## Product Spec

### 1. User Stories

#### Required (Must-have)

* [x] User can start, pause, and reset a timer for focused study sessions.
* [x] User can view total study time and completed sessions.
* [x] User’s progress is saved using `UserDefaults`.
* [x] User can view motivational quotes from an external API (e.g., ZenQuotes).
* [x] App uses tab navigation for “Study”, “Progress”, and “Motivation” screens.
* [x] Different study modes (Focus, Break, Review) are represented using an Enum.

#### Optional (Nice-to-have)

* [ ] User can customize session duration.
* [ ] Daily/weekly progress charts.
* [ ] Notifications when it’s time for a break or to refocus.
* [ ] Dark mode toggle for better UX.

---

### 2. Screen Archetypes

**Study Screen**

* Start, pause, and reset timer.
* Switch between study modes (Focus/Break/Review).

**Progress Screen**

* View total time studied and number of completed sessions.
* Display user’s study history saved in `UserDefaults`.

**Motivation Screen**

* Fetch and display daily motivational quotes using ZenQuotes API.
* Refresh quotes manually.

---

### 3. Navigation

**Tab Navigation**

* Study
* Progress
* Motivation

**Flow Navigation**

* From Study → Progress (via tab)
* From Study → Motivation (via tab)

---

## Wireframes

📱 *(Add your hand-drawn sketches or Figma screenshots here)*

* **Study Tab:** Timer with play/pause/reset buttons.
* **Progress Tab:** List or chart showing session history.
* **Motivation Tab:** Random quote displayed with refresh option.

**[BONUS] Digital Wireframes & Mockups:** *(Add Figma or XD link if available)*
**[BONUS] Interactive Prototype:** *(Optional link)*

----

## Schema

### Models

**Session Model**

| Property  | Type   | Description                            |
| --------- | ------ | -------------------------------------- |
| mode      | String | Type of session (Focus, Break, Review) |
| duration  | Int    | Duration of session in minutes         |
| date      | Date   | When the session occurred              |
| completed | Bool   | Whether the session was finished       |

---

### Networking

**Motivation Screen API Calls**
**GET** `https://zenquotes.io/api/random`

* Fetch a random motivational quote.

**Example Request Snippet (Swift):**

```swift
let url = URL(string: "https://zenquotes.io/api/random")!
URLSession.shared.dataTask(with: url) { data, _, _ in
    if let data = data {
        if let quote = try? JSONDecoder().decode([Quote].self, from: data) {
            print(quote.first?.q ?? "")
        }
    }
}.resume()
```

----

## Video presenting the Brainstorming and Readme documents:
Capstone Project Ideas Presentation - Watch Video 
<div style="position: relative; padding-bottom: 62.5%; height: 0;"><iframe src="https://www.loom.com/embed/ac80a988242a44b4982ae9bb031b2d97" frameborder="0" webkitallowfullscreen mozallowfullscreen allowfullscreen style="position: absolute; top: 0; left: 0; width: 100%; height: 100%;"></iframe></div>

Last/Best video:
https://www.loom.com/share/d00ac649ccca4ec4bb291b15684dfa4b

