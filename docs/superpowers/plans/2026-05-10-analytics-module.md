# Analytics Module Implementation Plan

**Goal:** Implement a "Spending Insights" screen featuring a category-based breakdown using pie charts.

---

### Task 1: Add Visualization Dependencies
- Modify: `pubspec.yaml`
- [ ] Add `fl_chart` to `pubspec.yaml`
- [ ] Run `flutter pub get`

### Task 2: Implement Analytics Logic Provider
- Create: `lib/features/transactions/providers/analytics_provider.dart`
- [ ] Implement `categorySummaryProvider` to aggregate transaction amounts by `categoryId`.
- [ ] Ensure it watches `transactionProvider` for real-time updates.

### Task 3: Create Analytics UI Components
- Create: `lib/features/transactions/views/analytics_page.dart`
- [ ] Create a screen that displays a `PieChart` widget showing expense distribution.
- [ ] Add a legend list that shows category names, colors, and total amounts.

### Task 4: Integrate Analytics into App Navigation
- Modify: `lib/features/transactions/views/home_page.dart`
- [ ] Add an "Analytics" button (e.g., in the AppBar or FAB menu) to navigate to the new page.

---

**Verification Strategy:**
- Run `flutter analyze` after each task.
- Verify UI renders correctly with mock data.
- Ensure the pie chart updates dynamically when a new transaction is added.
