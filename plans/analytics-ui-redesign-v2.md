# Analytics Redesign Implementation Plan

**Objective:** Transform the `AnalyticsPage` into a polished, high-fidelity experience using the Material You design system (`designer.md`).

### Changes
1.  **UI Overhaul (`lib/features/transactions/views/analytics_page.dart`)**:
    *   **Atmospheric Depth:** Enhance with layered surface colors (`surfaceContainer`), backdrop blurs, and soft shadows (`shadow-md`).
    *   **Typography:** Apply Material You type scale (HeadlineMedium for titles, BodyMedium for breakdown items).
    *   **Interactivity:** Add `active:scale-95` feedback for interactive card elements.
    *   **Icons:** Replace generic icons with distinctive, thematic iconography.
2.  **Feature Expansion**:
    *   Add a **Time Range Selector** (SegmentedButton) to toggle between "This Week", "This Month", and "This Year".
    *   Add a **Drill-down Capability**: Clicking a category in the Breakdown list navigates to a filtered transaction list for that category.

### Implementation Details
- **Tokens**: Use `colorScheme.surfaceContainer` for cards, `primary` for focus elements.
- **Layout**: Introduce asymmetric elevation and generous `24px` border-radii for cards.
- **Micro-interactions**: Implement smooth color transitions (200-300ms) on hover/state change.

### Verification
- Run `dart format .`
- Run `flutter analyze`
- Verify responsiveness and visual consistency.
