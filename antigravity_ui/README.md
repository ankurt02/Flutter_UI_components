# 🫧 Flutter Interactive Antigravity Jellyfish

A high-performance, interactive particle system for Flutter. This project is a technical recreation of the **Google Antigravity** "Jellyfish" effect, featuring a fluid vector field that tracks the user's mouse with organic, physics-based smoothing.

https://github.com/user-attachments/assets/7fee5353-895c-404d-adb8-c1c565eb12e5

## ✨ Features

* **Interactive Mouse Tracking:** The jellyfish body follows the cursor using `Offset.lerp` to create a smooth, "weighted" trailing effect.
* **Organic Vector Field:** Particles utilize complex trigonometry (Sine and Cosine waves) to simulate floating and rhythmic "swimming" motions.
* **Proximity-Based Physics:**
  * **Center Zone:** Sparsity logic ensures the area directly under the cursor remains clean.
  * **Peak Radius:** Particles reach maximum length and opacity as they approach the cursor.
  * **Contraction Zone:** Outer particles experience a strong inward "pull" vector to stay within the jellyfish body.
* **Optimized Rendering:** Powered by a `Ticker` and `CustomPainter`, capable of rendering hundreds of dynamic particles at $60+$ FPS.
* **Minimalist Google Aesthetic:** Clean white background with high-contrast bold typography and Google's signature blue (`#4285F4`).

## 🚀 Getting Started

### Project Structure
* **`JellyfishField`**: Handles the `MouseRegion` and the physics state, including the `Ticker` and mouse `lerp` logic.
* **`JellyfishPainter`**: The math engine. It iterates through the jittered grid and applies the zone-based transformations.
* **`PointerInterceptor`**: A custom wrapper that uses `IgnorePointer` to ensure the background animation doesn't block interactions with foreground buttons.

### Configuration
Customize the "vibe" in the `JellyfishPainter` class:

| Parameter | Value | Description |
| :--- | :--- | :--- |
| `centerZoneRadius` | `78.0` | Size of the "clear" area under the mouse. |
| `outerRadius` | `325.0` | The total reach of the jellyfish effect. |
| `baseWidth` | `4.0` | The thickness of the particle strokes. |
| `pullAmount` | `220.0` | Strength of the inward "swimming" contraction. |

---

## 🎨 UI/UX Highlights

* **Typography**: Uses a mix of Bold (64pt) and Light (64pt) weights with `-2.0` letter spacing to mimic the modern Google IDE landing page.
* **Buttons**: High-contrast black pill buttons with Windows-inspired iconography.
* **Performance**: Uses `LayoutBuilder` to remain fully responsive across different screen sizes while maintaining particle density.

