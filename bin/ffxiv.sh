#!/bin/sh

export WINEARCH=win32
export WINEPREFIX=~/.wine32-ffxiv
export CSMT=enabled

# COMMENT IF THE GAME IS FAILING TO LAUNCH
export WINEDEBUG=-all

# UNCOMMENT THESE LINES IF YOU USE NVIDIA DRIVERS
export LD_PRELOAD="libpthread.so.0 libGL.so.1"
export __GL_THREADED_OPTIMISATIONS=1

# UNCOMMENT THESE FOR VSYNC. 
export __GL_SYNC_TO_VBLANK=1

# Note IF RUNNING DUAL MONITORS WITH VSYNC: 
#You must open your X log in /var/logs and find which display port your game monitor is on. (mine was DFP-0)
#Then set the appropriate device in the line below and uncomment
#export __GL_SYNC_DISPLAY_DEVICE=DFP-0

#this path works for arch, not sure of the ubuntu path
WINE=/bin/wine


$WINE "/home/nogz/.wine/drive_c/Program Files (x86)/SquareEnix/FINAL FANTASY XIV - A Realm Reborn/boot/ffxivboot.exe"
