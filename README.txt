# Magnetic CAD Playground

Browser CAD for permanent magnets and coils, with Radia export/results and Figure Studio technical drawings.

**v5.1 — offline runtime**

## First preparation

Double-click `Prepare_Offline.bat` **once while online**.

It vendors the pinned **Three.js 0.180.0** runtime into `vendor/three/`.

After that, no internet connection is required. Commit the generated `vendor/` folder to GitHub and fresh clones will also be immediately offline-ready.

## Run

Double-click `Open_MagneticCAD.bat`.

It starts a tiny local server on `127.0.0.1` and opens the CAD. Keep the terminal window open while using it.

No Python, npm or software installation is required.

## Main features

- Cuboid and cylindrical permanent magnets
- Annular, racetrack, infinite-line and solenoid coils
- Move / rotate / resize, patterns, mirror, undo / redo
- `.magcad` save/open/import
- Radia solver export and `.mfield` Results viewer
- Force and torque visualization
- Figure Studio SVG / PNG drawings

## Radia

1. Build the scene.
2. Click **Radia solve…**
3. Download the generated `*_radia_solve.py`.
4. Run it in your Radia Python environment.
5. Open the resulting `.mfield` in **Results viewer**.

## Files

- `MagneticCAD.html` — application
- `Open_MagneticCAD.bat` — offline launcher
- `Prepare_Offline.bat` — one-time dependency vendor
- `vendor/three/` — local Three.js runtime after preparation
- `.ico` / PNG — optional shortcut/browser icons

Stable milestones are preserved with Git tags.
