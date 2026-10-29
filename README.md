# Magnetic CAD Playground

A lightweight browser CAD for building magnetic systems with permanent magnets and coils, exploring their fields and forces, and creating clear technical figures.

I started **Magnetic CAD Playground (MagCAD)** in the context of my thesis, as a practical way to sketch magnetic arrangements, compare ideas and explain how they work. I hope it can also be useful to anyone who wants to brainstorm a magnetic design, teach a concept, or simply understand magnetism a little better.

The idea is simple: build a scene visually, explore it, and take it further with a Radia calculation when you need numerical results.

**Project:** [CaioBelle/Magnetic-CAD-Playground](https://github.com/CaioBelle/Magnetic-CAD-Playground)

## Getting started

To keep the repository :

1. Download the repository using **Code → Download ZIP**, or clone it.
2. Extract the files.

Or only download and : 
3. Open `MagneticCAD.html` in a modern desktop browser, such as Chrome or Edge.

There is no application installation or build step. The main build loads Three.js from a CDN, so an internet connection is needed to load those modules. Python and Radia are only needed if you want to run the exported calculations.

For a first experiment, add a permanent magnet and a racetrack coil. Change their positions, the magnet polarity and the coil current, then use the quick field and force displays to explore the arrangement. Save your work as a `.magcad` project.

## What you can do

- **Build magnetic scenes:** cuboid, cylindrical/disc and spherical-shell permanent magnets; annular, racetrack, straight-line and solenoid coils.
- **Arrange and edit objects:** move, rotate, resize, mirror, undo/redo, and edit common properties across a multiselection.
- **Create repeated structures:** linear patterns, single-body revolve, circular patterns of whole selections, and spherical layouts. Revolve includes alternating N/S and simple Halbach options; the latter is intended for cubes because it rotates the bodies themselves.
- **Explore fields and loads:** quick CAD previews, Radia export, and a Results viewer for solved fields, coil forces and torques.
- **Prepare figures:** Figure Studio provides technical drawings with editable colours, layers, arrows, legends and SVG/PNG export.
- **Keep working:** save, reopen and merge `.magcad` projects, including CAD configuration and Figure Studio settings.

### Selecting and repeating objects

Use **Ctrl/Cmd-click** to add or remove objects from a selection. In the feature tree, **Shift-click** selects a range, and **Ctrl/Cmd+Shift-click** adds that range to the existing selection. The right panel shows the properties shared by the selected objects.

**Revolve about axis** works on one body. **Circular pattern** repeats an entire multiselection while preserving the arrangement within each copy. **Linear pattern** supports both.

### Spherical arrangements

Spherical lattice, spherical coverage and the N/S sphere generator help build arrangements of discs or spherical-shell segments. The N/S sphere uses a cube-based lattice mapped onto a sphere, with alternating polarity along its lattice connections. Spacing varies across the sphere; balanced spacing and thickness-aware disc clearance help control the layout.

## Radia: the calculation engine

[Radia](https://github.com/ochubar/Radia) is a 3D magnetostatics code developed at the **European Synchrotron Radiation Facility (ESRF)** by Oleg Chubar, Pascal Elleaume and Joël Chavanne. It was developed for magnetic insertion devices such as undulators and wigglers, and supports calculations involving permanent magnets, currents and magnetic materials. ESRF directs users to Oleg Chubar's repository for its continued maintenance and distribution.

MagCAD uses Radia through its **Python interface**. MagCAD builds the scene and generates the script; Radia performs the magnetic-field calculation outside the browser.

- [Radia source, downloads and installation information](https://github.com/ochubar/Radia)
- [ESRF Radia overview](https://www.esrf.fr/home/Accelerators/instrumentation--equipment/Software/Radia.html)
- [ESRF Radia documentation](https://www.esrf.fr/home/Accelerators/instrumentation--equipment/Software/Radia/Documentation.html)

### From CAD to calculated results

1. Build and save your magnetic scene.
2. Click **Radia solve…**.
3. Set the field sampling box, resolution and calculation options.
4. Choose an output name and download the generated Python script. For example, `motor_test.mfield` produces `motor_test.py`.
5. Run the script in a Python environment with **NumPy** and **Radia** installed:

   ```sh
   python motor_test.py
   ```

6. Open the resulting `.mfield` file in MagCAD's **Results viewer**.

Cuboid and cylindrical magnets use Radia's native primitives. Spherical-shell magnets are approximated by convex polyhedra; their discretization can be refined for more accurate calculations. Display subdivisions and Radia discretization are separate settings.

## Exploring results

The Results viewer combines the exported source geometry with the sampled field and calculated coil loads. You can:

- Display field arrows or **streamlines coloured by field magnitude**.
- Inspect Cartesian, cylindrical or spherical field components.
- View field slices and plot profiles along a straight line or a circumference.
- Show or hide objects and inspect force and torque results.

Streamlines follow the full magnetic-field vector interpolated from the saved grid. Their detail depends on the sampling resolution; changing the display does not run a new solve. Existing compatible `.mfield` files can be reused without regeneration.

## Figure Studio

Figure Studio turns the scene into a schematic or technical illustration for a report, presentation or discussion.

Use top, front, right or isometric views; adjust object colours, visibility and drawing order; add current, magnetization, force and torque arrows; and give legend entries your own names. Force arrows can use custom XYZ anchors for clearer placement. Racetrack coils can also show the contributions of their two straight active segments and their sum.

**Overall config** shares the general style across views. Each view remembers its own visibility, individual styles, legend, layers, force anchors and framing. These settings are saved in the `.magcad` project. Export the finished figure as **SVG** for further editing or **PNG** for direct use.

## Understanding the physics

The quick CAD field and load displays use simplified models for interactive exploration. Near magnet surfaces in particular, use the Radia workflow to assess quantitative results.

In MagCAD's current exported workflow:

- Permanent magnets generate the calculated field.
- Coil forces and torques are obtained by numerical integration of `J × B` over the conductor volume.
- Coil self-fields and coil-to-coil forces are omitted.
- Figure Studio's racetrack decomposition uses the quick CAD field and includes only the two straight active segments, excluding the curved returns.

Radia itself supports more physics than MagCAD currently exposes. For numerical work, check the geometry, units, magnetization and current directions, then refine the relevant discretization to check convergence.

## Files

| File | Purpose |
|---|---|
| `MagneticCAD.html` | Browser application |
| `.magcad` | Editable CAD project and saved figure settings |
| `.py` | Generated Radia calculation script |
| `.mfield` | Sampled field, exported geometry and calculated loads |
| `.svg` / `.png` | Exported Figure Studio illustration |

Imported `.mfield` datasets remain separate from `.magcad` projects. Keep both files if you want to reopen the design and its calculated results later.

## Feedback and contributions

MagCAD grows alongside my research and the problems encountered while using it. If something behaves unexpectedly, or you have an idea that would make it more useful, please [open an issue](https://github.com/CaioBelle/Magnetic-CAD-Playground/issues). A small example project, the steps to reproduce the behaviour and a screenshot are especially helpful.

**Created by Caio Belle.** Thanks to the Radia authors and maintainers for making the calculation engine available, and to [Three.js](https://threejs.org/) for the browser-based 3D tools.
