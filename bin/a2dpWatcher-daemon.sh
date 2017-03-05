#!/bin/bash

if [[ $(pgrep a2dpWatcher.py) ]]; then
    echo "A2DPWatcher process found"
else
    echo "A2DPWatcher process not found"
    a2dpWatcher.py
fi
