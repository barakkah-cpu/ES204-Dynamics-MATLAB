# ES204 — Dynamics MATLAB Assignments

MATLAB solutions to ES 204 Dynamics assignments at Embry-Riddle Aeronautical University. Each script analytically derives and numerically computes kinematic and kinetic quantities from a given physical system, then generates multi-panel plot outputs.

## Assignments
### 1. Bicycle Gear Kinematics
**Folder:** `kinematics/`

A cyclist starts from rest and pedals through a piecewise angular acceleration profile over 14 seconds. The script propagates motion through a two-gear drivetrain to the rear wheel using gear ratio relationships, then computes the bicycle's linear kinematics.

**Given:**
- Front gear radius r₁ = 120 mm, rear gear radius r₂ = 45 mm, wheel radius r_W = 330 mm
- Angular acceleration: ramps from 0→1 rad/s² (0–2 s), constant at 1 rad/s² (2–12 s), ramps from 1→0 rad/s² (12–14 s)

**Solves for:**
- ω₁(t), θ₁(t) — front gear angular velocity and displacement
- ω₂(t), θ₂(t) — rear gear angular velocity and displacement
- Total pedal revolutions and total distance travelled
- Bicycle position s(t), velocity v(t) & v(s), acceleration a(t) & a(s)

**Method:** Trapezoidal numerical integration applied at each time step (dt = 0.001 s)

**Output:** 2×3 figure panel — front gear, rear gear, acceleration profile, bicycle motion, v(s) phase plot, a(s)

### 2. Satellite Polar Coordinate Analysis
**Folder:** `polar coordinates/`

An Earth satellite follows an elliptical orbit defined in polar coordinates. The script analytically derives all velocity and acceleration components using polar kinematics, then evaluates and plots them over θ = 0° to 180°.

**Given:**
- r = (1.91 × 10⁷) / (1 + 0.5cosθ) m
- rv_θ = 8.72 × 10¹⁰ m²/s (angular momentum constant)

**Solves for:**
- v_r(θ), v_θ(θ), v(θ) — radial, transverse, and total velocity
- a_r(θ), a_θ(θ), a(θ) — radial, transverse, and total acceleration

**Method:** Analytical differentiation of r(θ) using the chain rule; θ̇ derived from the angular momentum condition; all quantities evaluated at 1° increments

**Output:** 2×3 figure panel — v_r, v_θ, v, a_r, a_θ, and a vs θ

### 3. Four-Petal Pilot Reaction Forces
**Folder:** `reaction forces/`

A pilot flies at constant speed along a four-leaved rose curve path. The script computes the reaction force the seat exerts on the pilot as a function of angular position using Newton's second law resolved into polar components.

**Given:**
- Path: r = −600cos(2θ) ft, θ from 0° to 90°
- Constant speed v_p = 80 ft/s
- Pilot weight W = 130 lb

**Solves for:**
- θ̇ and θ̈ from the constant speed constraint
- Radial and transverse acceleration components a_r, a_θ
- Seat reaction force N(θ) via Newton's second law in polar coordinates

**Method:** Analytical derivatives of r(θ); θ̇ extracted from the speed magnitude equation; weight resolved into polar components via angle ψ = arctan(r / dr/dθ)

**Output:** Plot of seat reaction force N vs θ

## Repository Structure
```
ES204-Dynamics-MATLAB/
├── kinematics/
├── polar coordinates/
├── reaction forces/
├── .gitignore
└── README.md
```
## How to Run
1. Clone the repository
2. Open MATLAB and navigate to the folder of the assignment you want to run
3. Open and run the corresponding `.m` file

Each script is self-contained with no external dependencies.

## Tools Used
- MATLAB
- Numerical integration (trapezoidal method)
- Analytical differentiation and polar coordinate kinematics
- 
## Author
**Barakkah Ibishomi**  
Aerospace Engineering, Embry-Riddle Aeronautical University  
ES 204 — Dynamics, Spring 2026
