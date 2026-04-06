# Design System: The Tactile Archive

## 1. Overview & Creative North Star

**Creative North Star: "The Digital Curator"**

This design system is a rejection of the "app-as-utility" aesthetic. Instead, we are building a "literary sanctuary." The goal is to evoke the sensory experience of a high-end personal library—the weight of premium paper, the precision of a fountain pen, and the calm of an organized study.

To move beyond the "template" look, this system utilizes **intentional asymmetry** and **tonal layering**. We avoid rigid, symmetrical grids in favor of layouts that feel like curated objects on a desk. We achieve a premium feel through high-contrast typography scales—pairing expansive, elegant serifs with utilitarian sans-serifs—and by replacing structural lines with shifts in light and texture.

---

## 2. Colors & Surface Philosophy

The palette is grounded in organic, earthy tones that reduce eye strain and promote deep focus.

### The Palette (Material Design Tokens)

- **Base Surface:** `surface` (#fbf9f4) — Our "warm paper" foundation.

- **Primary Accent:** `primary` (#546253) — A muted moss green for high-intent actions.

- **Secondary Accent:** `secondary` (#6a5d50) — A dried clay/timber tone for organizational elements.

- **Typography:** `on_surface` (#31332c) — A sophisticated charcoal, softened to avoid the harshness of pure black.

### The "No-Line" Rule

Standard 1px borders are strictly prohibited for sectioning. They feel clinical and "digital." Instead:

- **Boundaries** must be defined by shifts in background tokens (e.g., a `surface_container_low` card sitting on a `surface` background).

- **Whitespace** is your primary tool for separation. If you feel the need for a line, increase the padding by 1.5x instead.

### Surface Hierarchy & Nesting

Treat the UI as physical layers of stacked paper.

- Use `surface_container_lowest` (#ffffff) for the most prominent interactive elements (like an active bookmark card) to make them "pop" against the warmer paper background.

- Use `surface_dim` (#d9dbcf) for background overlays or inactive sidebars to create a sense of recession and focus.

### The "Glass & Gradient" Rule

For floating elements (like a navigation bar or a "Quick Save" button), use **Glassmorphism**. Apply a semi-transparent `surface_container` color with a `backdrop-blur` of 12px-20px. This allows the "paper" texture and content below to bleed through, making the UI feel like a cohesive environment rather than a series of disconnected boxes.

---

## 3. Typography

Our typography is an editorial conversation between the classic and the modern.

- **Display & Headlines (Newsreader):** Use these for the "soul" of the app. Headlines should be large and authoritative. Use `display-lg` for empty states or welcome screens to create a high-end magazine feel.

- **Body & Labels (Manrope):** A clean, modern sans-serif provides the "utility." It ensures that long-form descriptions of bookmarked articles remain legible and functional.

- **Hierarchy as Brand:** Use `headline-sm` for card titles. The serif’s high x-height conveys a "published" quality to every user-saved link.

---

## 4. Elevation & Depth

Depth in this system is organic, not mathematical.

- **The Layering Principle:** Stacking `surface_container` tiers is the default method for hierarchy. An inner container should always be one step higher or lower in the tier than its parent.

- **Ambient Shadows:** Shadows should only be used for "floating" objects like Bottom Sheets. Use the `on_surface` color for the shadow at **4-6% opacity** with a blur radius of at least **24px**. It should feel like a soft glow of depth, not a drop shadow.

- **The "Ghost Border" Fallback:** For accessibility in input fields, use the `outline_variant` token at **15% opacity**. It should be barely perceptible—a "whisper" of a boundary.

---

## 5. Components

### Buttons

- **Primary:** `primary` (#546253) background with `on_primary` text. Use a subtle gradient from `primary` to `primary_dim` to give the button a "pressed ink" depth.

- **Secondary:** `surface_container_high` background. No border.

- **Shape:** Use `rounded-md` (0.375rem) for a tailored, stationery-like appearance. Avoid fully rounded "pill" buttons unless they are small action chips.

### Bottom Sheets (The Signature Interaction)

The core navigation and detail views slide up as large, tactile overlays. Use `surface_container_lowest` with a heavy `backdrop-blur` on the content behind it. The top handle should be a subtle `outline_variant` pill.

### Cards & Lists

- **The Rule:** No dividers.

- **The Implementation:** Distinguish list items by alternating between `surface` and `surface_container_low`, or simply by generous vertical spacing (utilizing the `title-md` and `body-sm` hierarchy to create visual blocks).

### Input Fields

- **Style:** Minimalist. A simple `surface_container` background with a `ghost border` that transitions to a `primary` color only upon focus.

- **Tactile Feedback:** Use `label-sm` in `primary` color for floating labels to maintain the literary feel even during data entry.

---

## 6. Do’s and Don’ts

### Do:

- Use **asymmetric margins**. For example, a page title might have a larger left margin than the body text to create an editorial layout.

- Use **Newsreader Serif** for anything that represents "Content" and **Manrope Sans** for anything that represents "Action" or "Metadata."

- Embrace the "Warm Paper" color—ensure `surface` (#fbf9f4) is the dominant color on every screen to maintain the brand’s "Calm" personality.

### Don't:

- **Do not use 100% black.** Always use the charcoal `on_surface` (#31332c).

- **Do not use hard edges.** While the design is clean, use the `rounded-sm` or `rounded-md` tokens to soften the corners of containers, mimicking the way paper corners slightly soften with use.

- **Do not use "Standard" blue for links.** Use the `primary` moss green or `secondary` clay.

---

## 7. Signature Detail: The "Curator's Mark"

Every significant layout should feature one "High-Contrast" moment—pairing a `display-sm` serif headline with a very small `label-sm` sans-serif sub-header. This 4:1 scale ratio is the hallmark of premium editorial design.
