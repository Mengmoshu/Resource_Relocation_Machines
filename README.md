# Resource Relocation Machines
A Factorio mod themed around moving pesky ore patches to less pesky places.


# Guide
## Resource Relocation Machine:
A 1x1 building that moves ores from behind it to in front of it, one at a time. Directional machine that moves resource entities to it's far side. Excludes oil patches,

Place one of the machines and shortly it will begin moving ore from behind the machine to in front of it. It doesn't require power or fuel, and it doesn't produce pollution. They come in 10, 20, and 30 tile ranges, if you make the longer ranged ones they turn back into the basic one when you mine them. Don't worry, it doesn't cost any resources to upgrade them again.


# A Note
I haven't refined this mod at all really, so be warned that the art is ugly, and the features are limited. For example, right now the machines are also fully functional Constant Combinators.

# Contributing
I'm usually very happy to receive Pull Requests and other contributions, but please consider these points first.

#### One feature or fix per Pull Request:
Reviewing a PR is not fun for me, and if it contains multiple changes with multiple purposes that only gets worse. If a feature or fix depends on another feature or fix, open an issue to discuss it.

#### Create an Issue for any "gameplay design" changes before writing code:
If there isn't an issue that I have participated in that shows the behavior is unwanted then there is a very high probability that I intentionally designed it that way. Some recurring requests I would like to solve by providing options so that I can continue to use my mod the way I want to.

#### Please take care that you do not alter the formatting of lines you do not change:
This may happen because of your editor, or because the existing formatting is inconsistent, or you might dislike the existing formatting. However, this causes PRs to be slightly more difficult to review, and significantly harder to merge into unrelated branches. That second is really only a problem for me because I don't get around to working on this mod frequently any more.
    
# Changelog:
#### 0.0.11 -
* Updated for 0.18.x

#### 0.0.10 -
* Merged in The Staplergun's queueing and performance improvements

#### 0.0.9 -
* Updated for 0.17.x
* Fixed Flags not found when lauching with v 0.17.x (Removed Flag line entirely as game no longer uses it)

#### 0.0.8 -
* Updated for 0.16.x

#### 0.0.7 -
* Updated for 0.15.x

#### 0.0.6 -
* Fixed name mismatch caused by missed adjustments after pluralizing the mod's name.

#### 0.0.5 -
* Initial public release.


# Credits:
* Mengmoshu - Original idea and implementation.
* Vampiredmage - 0.17 update.
* The Staplergun - Implemented a work queue and other performance improvements.
