#!/bin/bash

pkill -x mpv
mpv $1 --window-minimized
