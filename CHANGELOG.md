# Changelog

## 6.4.0-rc.1 — 2026-10-28

Audit fixes:

- Prevent CAD Delete, transform, selection and undo shortcuts from acting behind the Results viewer, Figure Studio or Radia export dialog.
- Make the latest requested `.mfield` load win in Results and Figure Studio, even if an older file read completes later.
- Allow reopening the same Results file by resetting the file input before choosing it.
- Close active construction operations when loading a CAD project. Clear stale external Figure Studio field data when replacing a project, and invalidate pending field imports from the old project.
- Dispose geometries, materials and instanced-mesh resources when rebuilding field/load displays or replacing solved geometry. Clean up rebuilt coil current arrows as well.
- Replace missing favicon-file references with an embedded SVG icon.
- Add a whole-module lexical-reference audit and reproducible workflow tests. Recheck the loader restored in 6.3.1.

## 6.3.1

Restore the Results `.mfield` loader accidentally removed during the profile edit. Binary format unchanged.

## 6.3

Add intensity-coloured 3D streamlines, density presets, colour legend, cancellable tracing and caching. Preserve the existing arrows mode.

## 6.2

Add feature-tree range selection, collapsed Results object list, coordinate components, circular 1D profiles and consistent sampling outlines.

## 6.1 development updates

Add multiselection, shared-property editing, common-pivot transforms, whole-selection arrays and distinct single-body Revolve / multiselection Circular pattern commands. Add alternating N/S and simple Halbach revolve options; clarify cube suitability.

## 6.0 development baseline

Improve N/S sphere spacing/clearance and source handling; add drawing-subdivision configuration; correct curved-body resize previews and text-editor shortcut handling. See ROADMAP.md for retained scope decisions.
