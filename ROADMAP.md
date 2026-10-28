# v6 roadmap and scope decisions

## Disposition of the original audit

| Item | Caio's decision | v6 treatment |
|---|---|---|
| 1 — Lock behaviour | Intentional | Preserved, including its existing load-selection meaning. |
| 2 — Sphere design and clearance | Main priority | Balanced spacing, thickness-aware cylinder clearance, conservative shell bounds and all-pair checks implemented. Further geometry work below. |
| 3 — Sphere source handling | Part of the sphere redesign | Selected PM is a parameter template; the generator creates new bodies. |
| 4 — Subdivision/performance control | Add practical Config controls | CAD and Figure Studio subdivisions are configurable and saved. |
| 5 — Huge-model history | No 1,000-PM target | No history redesign or huge-model machinery added. |
| 6 — Release numbering | Current baseline is v5.6; build v6 together | The v6 development series retains the project schema number; current release details are in CHANGELOG.md. |
| 7 — Misleading resize | Real usability problem | Preview and release use consistent geometry-preserving scale. |
| 8 — External `.mfield` data | Acceptable; keep simple | Import workflow retained; datasets are not embedded. |
| 9 — Transactional JSON loading | Not needed now | Deferred. |
| 10 — Damaged-file tessellation limits | Not needed now | Deferred; the new drawing controls have normal UI bounds. |
| 11 — Object-name HTML handling | Not a priority | Deferred. |
| 12 — Alleged stale arrow legend entries | User tests worked | Withdrawn as a confirmed defect; no speculative legend patch. |

## Sphere development sequence

1. **Completed in this build — measurable placement and clearance.** Keep N/S parity separate from placement quality. Compare original and relaxed layouts at identical node counts. Use finite-cylinder geometry rather than centre-chord minus diameter. Report shell clearance conservatively and distinguish it from an exact distance.
2. **Next — decide the physical PM family using a moderate model.** Compare identical circular PMs with shell pieces at the intended radius, thickness, gap and useful angular range. Examine minimum gap, gap spread, PM count and covered area together. Equal-size circles inherently leave uncovered regions; improving centre spacing alone does not turn them into a complete shell.
3. **Next — closer-fitting shell geometry.** Prototype variable cell footprints aligned with a sphere tiling. This is separate from changing the magnetic pattern. Validate seams, corners and the complete finite volumes before calling clearance exact. Keep the current working shell operation available during development.
4. **Then — validate the selected geometry in the existing workflow.** Check the same moderate model in CAD, Figure Studio, saved/reopened JSON and Radia output. Choose drawing subdivisions for readability and Radia subdivisions for convergence separately.

No dipole-Halbach replacement is planned. Any later magnetic pattern or motor pole-order feature needs its own explicit specification; it must not silently replace the N/S sphere.

## Additional bugs found and repaired

| Reproduction | Repair |
|---|---|
| Type Delete, W/E/R/F or Ctrl+Z while editing the multiline legend title | Text focus is checked before CAD shortcuts. Native editor undo remains available. |
| Use a very thin cylindrical PM | Pole-cap thickness is bounded by half the physical height, including the sphere preview. |
| Set field-arrow threshold to zero with a zero field vector | Skip zero/nonfinite vectors before creating an arrow. |
| Prefill the sphere from a PM with zero magnetization | Preserve zero instead of replacing it with the default. |

## Local validation gate

The package passed offline checks, but the cloud browser could not open the local app. Confirm startup, a normal sphere preview/apply, curved-body resize, Config changes, Figure Studio view switching and `.magcad` save/reopen in the desktop browser. The earlier legend allegation remains unconfirmed and is not a release change.

## Release-candidate follow-up

The near-PM racetrack-force report remains unresolved. See QA_REPORT.md for the tested uniform-field signs and the remaining finite-magnet field-model limitation. Complete LOCAL_SMOKE_TEST.md before promoting the release candidate.
