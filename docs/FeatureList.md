# WhiskerWaves — Feature List

## Total: 78 Features

---

## Tab 1: Home Dashboard (16 features)
1. MoodRingView animated ring widget showing cat's health score
2. Cat photo display with name and breed
3. Health score (1-100) with color coding (green/yellow/red)
4. Time-aware greeting (Good Morning/Afternoon/Evening)
5. Today's care tasks summary card
6. AI insight card showing latest health tip
7. Quick Log buttons: Meal, Weight, Water, Play
8. Emergency vet contact button
9. Premium upgrade banner
10. Streak badge with day counter
11. Weekly activity chart (DGCharts)
12. Navigation to Cats tab
13. Navigation to Tasks tab
14. Theme-aware UI (dark premium mode)
15. Cat of the Day feature
16. Push notification permission prompt

## Tab 2: My Cats (20 features)
17. Cat profile card list with photos
18. Add new cat button with form
19. Cat photo capture/selection
20. Cat name and breed input
21. Cat age (birth date) picker
22. Cat species selector (Domestic, Persian, Siamese, etc.)
23. Health status badge per cat
24. Vaccination records section
25. Weight history chart (line graph)
26. Spay/Neuter status toggle
27. Microchip ID input field
28. Insurance info field
29. AI nutrition suggestions card
30. Edit cat profile functionality
31. Delete cat with confirmation
32. Multi-cat support (up to 10)
33. Cat birthday reminder setting
34. Breed-specific care tips
35. Emergency contact per cat
36. Veterinary notes field

## Tab 3: Care Tasks (15 features)
37. Daily care task list with checkboxes
38. Task categories: Feeding, Water, Litter, Play, Grooming, Medication
39. Custom task creation
40. Task time scheduling
41. Recurring task templates
42. Task completion animations
43. Missed task reminders
44. Weekly calendar overview
45. AI-powered task suggestions based on cat's routine
46. Task notes/comments field
47. Assign task to specific cat
48. Quick-complete all tasks button
49. Task history log
50. Filter tasks by cat
51. Sort tasks by time/category

## Tab 4: Learn & Insights (15 features)
52. Article categories: Behavior, Health, Nutrition, Training
53. Featured article cards
54. Search functionality for articles
55. Video tutorial section (locked for free users)
56. AI-powered daily tip notification
57. Cat breed encyclopedia (50+ breeds)
58. Symptom checker tool
59. First aid guides
60. Seasonal care tips
61. Training tutorial library
62. Expert Q&A section (Premium)
63. Community tips feed
64. Bookmark favorite articles
65. Reading progress tracking
66. Premium content lock indicators

## Tab 5: Profile (12 features)
67. User avatar and name
68. Cat Parent Level progress
69. Total tasks completed counter
70. Streak days display
71. XP points system
72. Premium upgrade CTA
73. Notifications & Reminders settings
74. Health Records access
75. Subscription & Billing management
76. Privacy & Safety settings
77. Help & Support options
78. About & App version info

---

## Identifier Capabilities Recommendation

| Feature | Required Capability |
|---------|---------------------|
| Task Reminders | Push Notifications (optional, can use local) |
| Premium Videos | StoreKit 2 (In-App Purchase) |
| User Accounts | Sign in with Apple (optional) |

**No additional Capabilities required** for core functionality.

---

## Technical Specifications

- **iOS Version**: 16.0+
- **Swift Version**: 5.9
- **Architecture**: MVVM
- **UI Framework**: UIKit + SnapKit
- **Charts**: DGCharts 5.1.0
- **Storage**: UserDefaults + Codable JSON
- **Subscriptions**: StoreKit 2 ($2.99/month Premium)