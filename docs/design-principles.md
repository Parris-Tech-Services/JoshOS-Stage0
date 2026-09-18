# Design principles

Five rules, derived from the one rule.

## 1. One way to do each thing

If there are two ways to move a window, one of them is wrong. Pick the better
one and delete the other. Familiarity is not a reason to keep both.

## 2. Nothing is hidden that matters

Linux's transparency is the trait worth stealing. Every piece of state the
system acts on should be inspectable and, where sane, editable as plain text.
No binary registry. No settings that exist only in a GUI.

## 3. Restraint over expressiveness

macOS's visual discipline comes from saying no. A fixed palette, a fixed
spacing scale, two type sizes more than you think you need. Enforced by
`design/tokens.json` — if you're typing a hex code, you're off the path.

## 4. Never fake capability

A toggle that does nothing, a menu item that opens an empty dialog, a progress
bar that isn't measuring anything — these are worse than an absence, because
they teach the user the system lies.

## 5. The system explains itself

Error messages say what happened and what to do. The terminal is a first-class
citizen, not a hatch for when the GUI fails. Every surface should be able to
answer "how did I get here and what will this do?"
