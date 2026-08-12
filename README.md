# Magnetic CAD Playground

Browser CAD for permanent magnets and coils, with Radia export/results and Figure Studio drawings.

**Branch:** `magnetics`  
**Build:** `v5.2-magnetics`

Open `MagneticCAD.html` in Edge or Chrome.

## Magnetics additions

- Choose **B** or **H (μ₀H)** in the 3D field display.
- Radia exports both B and μ₀H field volumes.
- Optional straight-line `rad.FldInt()` scan.
- Arbitrary integration direction and scan direction.
- Infinite-line or finite-segment integration.
- Saves ∫Bx ds, ∫By ds and ∫Bz ds.
- Results viewer switches between B, μ₀H and field-integral scans.

## Field-integral scan

In **Radia solve…** enable **Field-integral scan**, then define:

1. scan centre;
2. integration direction;
3. scan direction;
4. scan start/end and number of points;
5. infinite or finite integration.

The directions are normalized automatically and do not need to be orthogonal.

In the Results viewer choose **B-field integral scan**, then select the component to plot.

## Radia conventions

- `rad.Fld(..., 'h', ...)` is displayed as **μ₀H**, in tesla.
- `rad.FldInt()` integrates **B** along a straight line, in **T·mm**.
- Coil force/torque still uses **J × B**.
- Coils remain load targets, not field sources, in the current Radia workflow.

The simple CDN-based `main` branch remains the everyday version.
