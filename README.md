# Resource Relocation Machines
A Factorio mod themed around moving pesky ore patches to less pesky places.


# Guide
## Resource Relocation Machine:
A 1x1 building that moves ores from below it and behind it to in front
of it, one at a time. Directional machine that moves resource entities
to it's far side. Excludes oil patches.

## Basic Usage
Place one of the machines and shortly it will begin moving ore from
below or behind the machine to in front of it. It doesn't require
power or fuel, and it doesn't produce pollution. They come in 10, 20,
and 30 tile ranges.

## Overriding range and filtering
Click on the machine to open the entities GUI. Set item and count in
the left slot to override the input range (1 is only below the
machine) and the type of ore to move. Set the item and count in the
right slot to override the output range (1 is just in front of the
machine) and add a second filter option.

If the input range is not set then any ore will be moved, no filtering
applies. The item set in the right slot is ignored, only the count is
considered.

If the output range is negative then the filter is inverted. This
moves all ores except those specified.

If the input range is negative then the given ore is prefied with
"infinite-" so infinite ores from Angles Infinite Ore mod can be
moved.

Filtering allows easy separating ore patches that are too near to each
other or moving infinite ores out of a patch for later mining.

# A Note:
I haven't refined this mod at all really, so be warned that the art is ugly, and the features are limited. For example, right now the machines are also fully functional Constant Combinators.

# Todo:
- Maybe replace constant combinator with filter inserter?
- Allow reading ore type and count below machine (separate entity?)
- Add signals for infinite ores instead of negative range hack
- Add signals for input and output range
- Add custom entity GUI

# Changelog:
* unreleased
** spread processing equally over all ticks
** slow down RRMs if RRMs per tick exceeds its limit
** probe RRMs that can't do any work infrequently
** Use 2 combinator slots for filtering and set range
** search under the machine
** mine as same item as was placed
* 0.0.7 -
** Updated for 0.15.x
* 0.0.6 -
** Fixed name mismatch caused by missed adjustments after pluralizing the mod's name.
* 0.0.5 -
** Initial public release.
