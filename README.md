MAGNETIC CAD PLAYGROUND v4.8
============================

Standalone browser CAD, Radia export, solved-field viewer, and publication
Figure Studio for permanent magnets and current-carrying coils.

This README consolidates the current workflow and the principal changes from
the early CAD versions through v4.8.


CONTENTS
--------
1. Quick start
2. Main CAD editor
3. CAD project files
4. Radia solve workflow
5. Results viewer
6. Figure Studio
7. Physics scope and modelling limits
8. Navigation and shortcuts
9. Included files
10. Version history


1. QUICK START
--------------

1. Keep the files in this package together.
2. Double-click Open_MagneticCAD.bat, or open MagneticCAD.html in Edge or
   Chrome.
3. Build the magnet/coil scene.
4. Use the quick 3D preview for geometry, current direction, conceptual field,
   and conceptual load visualization.
5. Click "Radia solve..." to generate the Radia Python solver.
6. Run the generated solver in the main ESRF Radia Python environment.
7. Open the generated .mfield in "Results viewer".
8. Use "Figure Studio" to prepare an SVG or PNG technical illustration.

Internet access is required when opening MagneticCAD.html because the pinned
Three.js modules are loaded from a CDN.


2. MAIN CAD EDITOR
------------------

Supported source bodies
~~~~~~~~~~~~~~~~~~~~~~~

Permanent magnets
- Cuboid geometry with editable X/Y/Z dimensions.
- Cylindrical geometry with editable radius and height.
- Editable position and full 3D orientation for both shapes.
- Magnetization-strength control.
- Magnetization direction is local +Z and follows the body rotation.
- Cylindrical Radia export exposes the number of azimuth sectors.

Annular coil
- Circular winding path.
- Editable radius, current, turns, and wire radius.

Racetrack coil
- Two straight active sections connected by semicircular ends.
- Editable straight length, end radius, current, turns, and wire radius.

Infinite-line coil
- Displayed as a long straight conductor along its local X axis.
- Intended to represent an effectively infinite conductor in CAD and figures.
- A finite simulation length is entered separately in the Radia export menu.
- The generated solver treats it as an open straight integration volume; it
  does not create an artificial return conductor.

Solenoid coil
- Explicit helical conductor wound around local Z.
- Editable solenoid radius, axial length, current, turns, and wire radius.
- CAD, Figure Studio, Results viewer, patterns, duplicate, mirror, and
  .magcad save/open/import preserve the full helix geometry.

General CAD operations
~~~~~~~~~~~~~~~~~~~~~~

- SolidWorks-style orbit, pan, and zoom.
- Move, rotate, and resize tools.
- Object selection in the viewport or feature tree.
- Rename, duplicate, delete, show/hide, and lock bodies.
- Per-coil current slider and numeric entry in the feature tree.
- World X/Y/Z orientation triad.
- Optional 5 mm translation and 15-degree rotation snapping.
- Top, Front, and Isometric views.
- Solid, contour/current, and transparent-source visual modes.

Quick field preview
~~~~~~~~~~~~~~~~~~~

The CAD viewport contains a lightweight conceptual field visualization for
interactive work. It supports:

- Resultant or individual-source field display.
- XY, XZ, YZ, or 3D-volume sampling.
- Three display densities.

This quick preview is not the Radia solution. The solved permanent-magnet field
is produced by the exported Python script and stored in .mfield.

Quick force and torque preview
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Force and torque are independently switchable.

Force choices:
- Fres
- Fx
- Fy
- Fz

Torque choices:
- Mres
- Mx
- My
- Mz

Visual convention:
- Green straight arrow = force.
- Purple curved arrow = torque.

Only visible, unlocked bodies receive quick CAD load indicators. The selected
components are also used by Figure Studio when its load controls are
synchronized with CAD.

Group operations
~~~~~~~~~~~~~~~~

The collapsible group-operation toolbar provides:

Circular pattern / revolve
- Global X, Y, or Z axis.
- Configurable pivot.
- Configurable total angle and copy count.
- Live translucent copies.
- Dashed construction trajectory, axis, and pivot marker.

Linear pattern
- Configurable number of copies.
- Independent X/Y/Z step.
- Live translucent copies and dashed construction line.

Mirror
- XY, YZ, or XZ mirror plane.
- Configurable plane offset.
- Copy or replace behaviour.
- Live mirrored ghost, construction plane, and connecting line.

Apply commits the operation. Cancel removes every preview and restores the
normal properties panel.

Undo / redo
~~~~~~~~~~~

- Undo button or Ctrl+Z.
- Redo button, Ctrl+Y, or Ctrl+Shift+Z.
- Up to 80 meaningful CAD states are retained.


3. CAD PROJECT FILES
--------------------

Save CAD downloads a .magcad JSON project containing:

- magnets and coils;
- coil type, current, turns, and geometry;
- infinite-line display and simulation lengths;
- transforms;
- locks and visibility;
- Radia segmentation and integration settings;
- quick-display settings;
- selected force and torque components;
- camera position and target.

Open CAD
- Replaces the current scene with a saved project.

Import CAD
- Merges another project into the current scene with a small positional offset.

Keyboard shortcuts
- Ctrl+S: Save CAD.
- Ctrl+O: Open CAD.


4. RADIA SOLVE WORKFLOW
-----------------------

1. Build the scene.
2. Click "Radia solve...".
3. Define the 3D field box:
   - X minimum and maximum;
   - Y minimum and maximum;
   - Z minimum and maximum.
4. Define the X/Y/Z field sampling counts.
5. Enter the default result path, for example:

   C:\Users\GRAZZIBE\AppData\Local\Programs\Microsoft VS Code\magnetic_scene.mfield

   The generated Python solver creates missing parent folders when possible.
6. Define source-specific numerical settings.

   Cuboid permanent magnets
   - X/Y/Z subdivision.

   Cylindrical permanent magnets
   - Azimuth-sector resolution used by Radia ObjCylMag.

   Annular and racetrack coils
   - Along-path integration points.
   - Across-width repartition.
   - Across-height repartition.

   Infinite-line coils
   - Simulation length in millimetres.
   - Along-path integration points.
   - Across-width repartition.
   - Across-height repartition.

   Solenoid coils
   - Along-helix integration points.
   - Across-width repartition.
   - Across-height repartition.
   - The solver automatically enforces at least 12 helix points per turn.

7. Download the generated *_radia_solve.py file.
8. Run it in the main ESRF Radia Python environment:

   python magnetic_scene_radia_solve.py

   The path selected in the export dialog is used by default. It can be
   overridden from the command line:

   python magnetic_scene_radia_solve.py --output another_result.mfield

9. Return to MagneticCAD.html, click "Results viewer", and open the .mfield.

.mfield content
~~~~~~~~~~~~~~~

The portable .mfield file stores:

- a JSON header;
- the solved scene description;
- solver metadata;
- X, Y, and Z coordinate arrays;
- the complete saved B-field grid;
- integrated coil forces and torques.


5. RESULTS VIEWER
-----------------

The Results viewer is read-only. It provides:

- SolidWorks-style orbit, pan, and zoom.
- Top, Front, and Isometric fit views.
- Imported magnet and coil geometry.
- A clear "Show magnet field" switch.
- An exact requested number of 3D arrows selected from all stored field points.
- Adjustable field-arrow size.
- User-selectable field-arrow colour, with bright cyan as the default.
- A movable XY/XZ/YZ inspection plane.
- Field-component selection: |B|, Bx, By, or Bz.
- A 2D colour map of the selected slice.
- Cursor probing of field values.
- A movable 1D profile inside the selected slice.
- Optional overlay of the 1D profile line on the 2D map.

Force and torque visualization
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Force and torque are independent in the Results viewer.

Force choices:
- Fres
- Fx
- Fy
- Fz

Torque choices:
- Mres
- Mx
- My
- Mz

Visual convention:
- Green straight arrow = force.
- Purple curved arrow = torque.

The number, size, and colour of 3D field arrows affect only visualization. They
do not change, resample, or overwrite the stored .mfield data, slice map, or 1D
profile.


6. FIGURE STUDIO
----------------

Figure Studio creates publication-oriented SVG and PNG illustrations from the
current CAD scene.

Views
~~~~~

- Top.
- Front.
- Right.
- Isometric.

Isometric variants
- Front-right / north-east.
- Front-left / north-west.
- Back-right / south-east.
- Back-left / south-west.

Global style presets
~~~~~~~~~~~~~~~~~~~~

- Technical black and white.
- Red / blue magnetic poles.
- Monochrome with arrows.
- Schematic outline.

Global controls
~~~~~~~~~~~~~~~

- Visible-line thickness.
- Fill opacity.
- Current-arrow count.
- Object colours.
- Magnetization-arrow colour.
- Force colour.
- Torque colour.
- Radia-field streamline colour.
- Hidden-edge colour.
- Background colour or transparent background.
- SVG/PNG export dimensions and PNG scale.

Object selection and layers
~~~~~~~~~~~~~~~~~~~~~~~~~~~

- Click an object in the drawing or in the object list.
- Configure each magnet or coil independently.
- Reorder layers to control drawing occlusion.
- Send backward, move backward, move forward, or bring to front.
- Restore automatic depth order at any time.
- Hide an object only from the figure without changing the CAD scene.

Magnet representations
~~~~~~~~~~~~~~~~~~~~~~

- Red / blue poles.
- Monochrome body.
- Outline only.
- Optional magnetization arrows.

Coil representations
~~~~~~~~~~~~~~~~~~~~

General coil modes
- Filled conductor.
- Outline path.
- Centre line only.
- Optional current arrows.

Racetrack-specific modes
- Filled conductor.
- Racetrack without borders: only the two active straight conductors.
- Two parallelepipeds: the active conductors are represented as 3D extruded
  rectangular bars and projected face-by-face.
- Centre line only.

Infinite-line representation
- A long straight line/conductor in the selected 2D projection.
- Current direction follows the object current and orientation.

Force and torque in Figure Studio
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Figure Studio follows the CAD load selection:

- Fres, Fx, Fy, or Fz.
- Mres, Mx, My, or Mz.
- Only visible, unlocked bodies receive load indicators.
- Force is a green straight arrow.
- Torque is a purple curved arrow.
- A component normal to the drawing can use dot/cross notation.

Individual load-arrow styling, introduced in v4.2
- Click a force or torque arrow directly in the drawing.
- Change that individual arrow's size.
- Change that individual arrow's line width.
- Change that individual arrow's colour.
- Reset it to the global style at any time.
- These controls alter only the illustration, not the physical load value.

Radia-field streamlines in Figure Studio
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The Radia field panel is collapsed by default to keep the left menu compact.
Click "Add Radia field" / "Radia field settings" to open it.

The panel can:

- import a solved .mfield directly;
- reuse the file already loaded in Results viewer;
- select XY, XZ, or YZ;
- move the plane to a saved grid coordinate;
- choose the requested number of streamlines;
- show, hide, or clear the imported field.

The streamlines:

- are generated from the in-plane resultant permanent-magnet field;
- use interpolation of the saved Radia grid;
- are integrated in both directions from distributed seeds;
- include direction arrows;
- vary in visual emphasis with field magnitude;
- are exported as SVG paths and are therefore editable in vector software.

The imported field remains read-only and is not recalculated by Figure Studio.


7. PHYSICS SCOPE AND MODELLING LIMITS
-------------------------------------

Solved field
- The stored 3D B field is generated by permanent magnets only.

Coil loads
- Coils are treated as homogenised current-carrying winding volumes.
- Force is obtained from the volume integral of J x B.
- Torque is integrated about the coil/load reference position.
- Annular, racetrack, finite exported straight-line, and explicit helical solenoid conductors are supported.

Infinite-line interpretation
- The CAD/Figure Studio body represents an effectively infinite straight
  conductor.
- Radia export requires a finite simulation length.
- The selected length defines the open volume used in the Lorentz integral.
- Increasing the length changes the integrated load whenever the field remains
  significant over the added conductor region.

Intentionally omitted in the current workflow
- Coil self-field in the stored field volume.
- Coil-to-coil magnetic force.
- Full coupled electromagnetic conductor solution.
- Ferromagnetic nonlinear material solution.

Magnet source discretization
- Cuboid subdivision is exported for transparency and future material models.
- Cylindrical magnets use Radia ObjCylMag with a configurable azimuth-sector
  count.
- The X/Y/Z field-grid sampling is the principal control of the spatial
  resolution stored in the .mfield result.

Quick CAD versus solved data
- CAD field/load previews are interactive conceptual approximations.
- Results viewer and Figure Studio streamlines use the solved .mfield data.


8. NAVIGATION AND SHORTCUTS
---------------------------

CAD mouse controls
- Left drag: orbit.
- Right drag: pan.
- Mouse wheel: zoom.
- Click body: select.

CAD keyboard controls
- W: move.
- E: rotate.
- R: resize.
- F: fit view.
- Delete: delete selected body.
- Ctrl+Z: undo.
- Ctrl+Y or Ctrl+Shift+Z: redo.
- Ctrl+S: save .magcad.
- Ctrl+O: open .magcad.

Figure Studio controls
- Click object: select object style.
- Click force/torque arrow: select individual load-arrow style.
- Drag drawing: pan.
- Mouse wheel: zoom.
- Fit drawing: restore automatic framing.


9. INCLUDED FILES
-----------------

MagneticCAD.html
- Main standalone browser application.

Open_MagneticCAD.bat
- Windows launcher that opens MagneticCAD.html with the system browser.

magneticcad_icon.png
- Browser-tab icon. If an older icon persists, refresh or reopen the HTML.

README.txt
- This document.

Do not separate MagneticCAD.html from magneticcad_icon.png if the custom tab
icon is required.


10. VERSION HISTORY
-------------------

Early foundation, v1.0-v1.6
~~~~~~~~~~~~~~~~~~~~~~~~~~~

The detailed early notes were not preserved line-by-line. These versions formed
the initial single-page application foundation:

- cuboid magnets;
- annular and racetrack coils;
- feature tree and properties panel;
- 3D transforms and current controls;
- quick field/current/load visualization;
- initial Radia solver generation;
- initial .mfield result workflow.

v1.7 - CAD project files
~~~~~~~~~~~~~~~~~~~~~~~~

- Save CAD downloads a .magcad JSON project.
- Open CAD replaces the current scene.
- Import CAD merges another project with a positional offset.
- Project data includes bodies, transforms, currents, locks, visibility, Radia
  settings, display settings, and camera view.
- Ctrl+S saves and Ctrl+O opens.

v1.8 - Orientation and group operations
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

- Semi-transparent world X/Y/Z orientation triad.
- Collapsible group-operation toolbar.
- Revolve selected body around global X/Y/Z through a configurable pivot.
- Linear pattern with configurable copy count and X/Y/Z step.
- Mirror about XY, YZ, or XZ with configurable plane offset.
- Operation settings temporarily replace the right properties panel.

v1.9 - Desktop-layout corrections
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

- Removed informal wording from group-operation controls and status messages.
- Constrained the application to the browser viewport.
- CAD viewport flexes to the remaining height.
- Opening group operations shrinks the viewport rather than pushing content
  below the screen.
- Feature-tree and properties panels scroll internally.
- Radia export and Results viewer workflow documented in detail.

v2.0 - Packaged browser icon
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

- Added the custom magneticcad_icon.png favicon.
- Packaged browser-tab branding with the standalone application.

v2.1 - Circular-pattern update
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

- Revolve creates multiple radial copies rather than one rotated copy.
- Live translucent preview.
- Angular spacing uses total angle / (additional copies + 1).
- Example: four additional copies over 360 degrees gives 72-degree spacing.

v2.2 - Construction-preview update
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

- Fixed circular-preview collapse when the pivot matched the body centre.
- Circular preview shows copies, dashed trajectory, global axis, and pivot.
- Linear preview shows copies and dashed construction line.
- Mirror preview shows mirrored body, construction plane, and connection line.
- Previews update live and disappear on Apply or Cancel.

v2.3 - Stronger previews
~~~~~~~~~~~~~~~~~~~~~~~~

- Increased preview visibility.
- Added a complete circular construction ring.
- Added an automatic non-zero pivot offset when the source lies on the axis.

v2.4 - Independent ghost geometry
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

- Rebuilt operation previews as independent CAD ghost geometry.
- Circular, linear, and mirror previews no longer clone live materials.
- Construction rings and lines use visible 3D geometry.

v2.5 - History controls
~~~~~~~~~~~~~~~~~~~~~~~

- Undo and redo buttons.
- Ctrl+Z, Ctrl+Y, and Ctrl+Shift+Z shortcuts.
- Up to 80 meaningful states retained.

v3.0 - Figure Studio draft
~~~~~~~~~~~~~~~~~~~~~~~~~~

- Added publication-oriented 2D vector projections.
- Top, Front, Right, and Isometric views.
- Technical B/W, red/blue poles, monochrome, and schematic presets.
- Current and magnetization arrows.
- Hidden-line option.
- Editable colours.
- SVG and PNG export.

v3.1 - Object-level Figure Studio
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

- Click objects in the figure or object list.
- Independent magnet and coil representation settings.
- Manual drawing/layer order.
- Automatic depth order can be restored.

v3.2 - Isometric and racetrack representation expansion
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

- Four isometric view variants.
- Global and per-object racetrack representation controls.
- Initial projected-loop and active-section drawing concepts.
- Improved current direction notation in projected views.

v3.3 - Curved CAD torque arrows
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

- Replaced straight purple torque axes with curved arrows centred on the body.
- Kept force as a green straight arrow.
- Clarified load meaning in the CAD status text.

v3.4 - Independent force and torque components
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

- Separate Force and Torque switches.
- Force dropdown: Fres, Fx, Fy, Fz.
- Torque dropdown: Mres, Mx, My, Mz.
- Display settings are preserved in .magcad files.

v3.5 - Load legend and Figure Studio loads
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

- Added Force and Torque to the main CAD legend.
- Added force and torque to Figure Studio.
- Figure Studio load controls synchronize with CAD.
- Locked bodies do not receive drawing load arrows.
- Added force and torque colour controls for SVG/PNG output.

v3.6 - Racetrack representation menu
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

- Added Filled conductor.
- Added Racetrack without borders.
- Added Two parallelograms.
- Added Centre line only.
- Improved current arrows and dot/cross notation for active sections.

v3.7 - Extruded active-section correction
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

- Replaced flat active-section rectangles with projected 3D parallelepipeds.
- Added visible faces for technical-illustration depth.

v3.8 - Geometry and workflow refactor
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

- Separated complete racetrack path, drawing bounds, active conductors, and
  3D parallelepiped faces.
- Prevented active-section geometry from corrupting the racetrack SVG path.
- Restored and refactored Radia solve button bindings.
- Restored the complete Results viewer implementation.
- Revalidated .mfield writing, parsing, geometry, loads, slices, and profiles.

v3.9 - Radia streamlines in Figure Studio
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

- Imported solved .mfield data directly into Figure Studio.
- Added XY/XZ/YZ plane and slice-position selection.
- Added configurable streamline count.
- Added in-plane field interpolation, streamline integration, direction arrows,
  and magnitude-weighted visual emphasis.
- Added SVG/PNG field overlay export.

v4.0 - Compact field menu and improved Results loads
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

- Collapsed Figure Studio field controls behind Add Radia field / settings.
- Reduced left-panel crowding.
- Added separate Results viewer Force and Torque controls.
- Added Fres/Fx/Fy/Fz and Mres/Mx/My/Mz in Results viewer.
- Changed Results viewer torque visualization to purple curved arrows.

v4.1 - Infinite-line coil
~~~~~~~~~~~~~~~~~~~~~~~~~

- Added Infinite line as a third coil type.
- Added long straight CAD and Figure Studio representation.
- Added current direction, transforms, patterns, locks, and project persistence.
- Added user-defined finite simulation length in Radia export.
- Added open-path Lorentz-volume integration without artificial closure.
- Added infinite-line geometry and loads to .mfield and Results viewer.

v4.2 - Selectable Figure Studio load arrows
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

- Force and torque arrows became selectable drawing elements.
- Click a green force arrow or purple torque arrow directly in Figure Studio.
- Added individual size override.
- Added individual line-width override.
- Added individual colour override.
- Added reset-to-global-style control.
- Overrides affect illustration only and do not alter solved physics.


END OF README
-------------
Magnetic CAD Playground v4.8

v4.3 drawing-load independence
------------------------------
- Figure Studio copies the current CAD force/torque visibility and component choices only when it opens.
- Figure Studio load controls no longer write back into the CAD viewport.
- Each force or torque arrow can override its displayed component independently (Fres/Fx/Fy/Fz or Mres/Mx/My/Mz), as well as size, width, and colour.

v4.4 Figure Studio legend
-------------------------
- Added a publication legend anchored in the top-right of the Figure Studio drawing.
- Added a dedicated Legend entry above the drawing-object list in the left panel.
- Click either the legend box in the SVG or the Legend entry in the left panel to edit it.
- Legend visibility, title, scale, text/border colour, and background colour are editable.
- The legend can independently include or omit: permanent magnet, coil, current direction, magnetization, Radia field, force, and torque.
- Legend content controls affect only the legend and do not change the drawing visibility of the corresponding objects or overlays.
- The legend is included in SVG and PNG exports; the blue selection outline is not exported.


v4.5 legend polish
------------------
- Figure Studio legend typography now uses a clean regular Arial/Helvetica sans-serif style, closer to MATLAB figure legends.
- Rebuilt the Radia-field legend sample as a smooth streamline with a tangent-aligned arrowhead.
- Rebuilt the torque legend sample as a true curved circular arrow with a tangent-aligned arrowhead.
- Added a Transparent background switch directly above the legend background-colour control.
- When transparent legend background is enabled, the legend border and text remain visible while the box fill is removed.

v4.7 legend refinement
----------------------
- Removed the per-entry square boxes introduced in v4.6.
- Restored a compact scientific/MATLAB-style legend: one outer frame only.
- Legend title remains bold and centered, but is now almost the same size as entry text.
- Tightened title spacing, row spacing, padding, and overall width/height proportions.
- Retained the horizontal divider below the title.
- Magnet, coil, current, magnetization, Radia-field, force, and torque symbols are drawn directly in the symbol column without surrounding cells.
- Existing transparent-background support and legend content controls are unchanged.

v4.8 cylindrical magnet + solenoid
----------------------------------
- Added a first-class cylindrical permanent magnet alongside the original cuboid magnet.
- Cylindrical magnets expose radius, height, polarization strength, and Radia azimuth-sector resolution.
- Cylindrical magnets are supported by CAD transforms, resize baking, patterns, mirror, duplicate, .magcad save/open/import, Results viewer reconstruction, and Figure Studio.
- Generated Radia solvers create cylindrical sources with Radia ObjCylMag, magnetized along the local +Z axis.
- Added a first-class solenoid coil alongside annular, racetrack, and infinite-line coils.
- Solenoids expose radius, axial length, turns, wire radius, and current and are rendered as explicit helices about local Z.
- Solenoids participate in the Lorentz J x B force/torque calculation using the explicit helical path. Because the turns are geometrically represented, the current is not multiplied by the turn count a second time.
- Solenoid Radia export automatically enforces at least 12 path points per turn while retaining the user-configurable cross-section repartition.
- Solenoid and cylindrical-magnet geometry is reconstructed from .mfield metadata in the Results viewer and is available in Figure Studio SVG/PNG drawings.
- CAD project format version increased to 2 while remaining backward-compatible with version-1 .magcad files.

v4.9 solenoid visual rebuild
----------------------------
- Rebuilt the solenoid CAD visualization around a smooth high-resolution open helix.
- New solenoids default to 12 turns and 1.0 mm wire radius, avoiding the physically overlapping 24-turn / 2.8 mm-radius default from v4.8.
- The physical wire radius remains untouched for Radia. CAD, previews, Results viewer, and Figure Studio use a display-only thickness limiter when the entered wire is larger than the available turn pitch.
- Reduced and resized 3D current arrows on solenoids to avoid hiding the winding geometry.
- Figure Studio no longer renders a solenoid through the generic coil-path routine. It uses a dedicated turn-by-turn projected representation with depth ordering.
- Axial views collapse the repeated projected turns to one clean representative ring instead of over-drawing the same circle many times.
- Side and isometric views show the individual turns cleanly and limit current-direction arrows to a readable subset.
- The Radia helical path, physical wire radius, J x B volume integration, .magcad data, and .mfield physics metadata are unchanged.

