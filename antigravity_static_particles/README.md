# 🫧 Flutter Antigravity Jellyfish Particles

A high-performance mathematical particle system implemented in Flutter using `CustomPaint`. This project is a functional recreation of the iconic "Jellyfish" particle animation found on the **Google Antigravity** website, simulating a fluid, organic vector field.


<img width="1916" height="980" alt="image" src="https://github.com/user-attachments/assets/56ae5b66-8650-4a17-888e-949aa801ade0" />


---

## ✨ Key Features

* **Fluid Vector Motion:** Particles utilize dual sine and cosine waves to create a non-repeating, organic "floating" movement.
* **Dynamic Contraction Zones:** Implements four distinct behavior zones (Center, Peak, Contraction, and Outer) that dynamically adjust scale, length, and opacity based on Euclidean distance.
* **Procedural Grid Generation:** Uses a randomized jittered grid to ensure particles are distributed naturally, avoiding a rigid lattice appearance.
* **High-Frequency Ticker:** Powered by a `Ticker` for $60+$ FPS performance, ensuring smooth rendering for hundreds of simultaneous particles.
* **Swim Cycle Logic:** Simulates a "swimming" motion where particles at the field's edge experience an inward pull toward the center.



## 🚀 Getting Started

### Project Structure
* **`AntigravityJellyfishPage`**: The main UI layer containing the Google-style minimalist typography.
* **`JellyfishField`**: The stateful container that initializes the grid and manages the animation `Ticker`.
* **`JellyfishPainter`**: The core engine that performs the math and draws to the `Canvas`.

### Configuration
Adjust the field's behavior in `_JellyfishFieldState`:

| Parameter | Default Value | Description |
| :--- | :--- | :--- |
| `_gridSpacing` | `36.0` | Controls particle density. |
| `_jitterAmount` | `12.0` | Controls the "randomness" of the initial positions. |
| `outerRadius` | `360.0` | The boundary of the jellyfish effect. |
| `baseLength` | `5.0` | The default length of each particle stroke. |

---

## 🎨 UI/UX Design

The design follows a clean, modern aesthetic:
* **Typography:** Bold headers with negative letter spacing (`-2.0`) for a premium look.
* **Interactive Button:** A sleek, pill-shaped "Download for Windows" button using high-contrast black and white.
* **Color Palette:** Focused on **Google Blue** (`#4285F4`) against a stark white background.

---
