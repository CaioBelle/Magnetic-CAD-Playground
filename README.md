# MagCAD v6.4.0-rc.1

Release candidate prepared on 28 October 2026. Open `MagneticCAD.html` in your desktop browser, or double-click `Open_MagCAD.cmd` on Windows. Three.js 0.180.0 is loaded from jsDelivr; internet access is required. Python/Radia is not bundled.

The `.magcad` JSON schema remains version 6. The `.mfield` binary format remains MCFIELD1: existing solved files do not need regeneration for the viewer features.

## CAD and selection

- Ctrl/Cmd-click toggles selection. In the feature tree, Shift-click selects a range; Ctrl/Cmd+Shift-click adds that range to the existing selection.
- Multiselections share applicable property fields. Mixed values remain unchanged until that field is edited. Move/rotate uses an editable common pivot.
- Revolve about axis acts on **one body**, with alternating N/S and simple Halbach options. The simple Halbach mode is intended for cubes; it physically rotates bodies, so other shapes can change footprint.
- Circular pattern acts on a **multiselection**, copying the entire structure with its relative orientations and polarities. Linear pattern supports either one body or a selection.
- CAD and Figure Studio drawing subdivisions are configured independently of Radia discretization.
- Balanced N/S sphere spacing and thickness-aware cylinder clearance are retained. Alternating polarity does not imply identical gaps.

## Results viewer

The left sidebar contains configuration first, followed by a collapsed Objects list.

**Arrows / Streamlines:** arrows display the selected component; streamlines always follow the full saved B vector. Streamline colour represents |B| in teslas, using a linear scale over the displayed lines. Density is Sparse, Medium or Dense. Lines are integrated through interpolated saved vectors, with finite tracing limits; their density is not a quantitative flux measure.

**Field coordinates:** Cartesian Bx/By/Bz, cylindrical Br/Btheta/Bz or spherical Br/Btheta/Bphi. Cylindrical theta is azimuth about global Z, from +X toward +Y. Spherical theta is the polar angle from +Z; phi is azimuth. A custom coordinate origin is available. Undefined components on the axis/origin are omitted.

**1D profiles:** choose a line or circumference in the current XY/XZ/YZ slice. Circle centre and radius use millimetres. Angle starts along the slice's horizontal axis and increases toward its vertical axis. Saved Cartesian vectors are interpolated before component projection; points outside the saved volume appear as gaps.

**Sampling bounds:** the quick-field width sets plane span and cube side about the global origin. The Radia solve dialog has its own centre/dimensions and matching preview outline.

## Figure Studio

Overall style remains shared across views; per-view colours, legend, custom force anchors, visibility, layers and view box remain independent and save in `.magcad`. Imported `.mfield` data remains external. Opening a replacement CAD project clears the prior project's imported Figure Studio field; import the appropriate field again. Merging and undo do not intentionally discard it.

## Validation

See `QA_REPORT.md` for evidence and limits, and `LOCAL_SMOKE_TEST.md` before promoting this candidate to a stable tag. No live browser/WebGL run or fresh Radia solve was performed during this audit. The earlier racetrack near-PM force-arrow report remains unresolved: Figure Studio leg forces use the conceptual CAD field, not the imported Radia field.

Run the offline suite with Node.js (tested on Node 24):

```sh
node qa/run.cjs
python -m py_compile qa/generated_solver.py
python qa/check_clearance.py
```

The last command requires NumPy and SciPy. Static analysis uses Acorn bundled inside Node when available; otherwise install `acorn` for that check. The tests use lightweight math/DOM/scene fixtures and do not replace browser or solver validation.

`COMMIT_MESSAGE.txt` contains the proposed Git commit message. No Git commit, push or publication has been performed.
