#!/bin/bash
if [ ! -f ~/.chaded ]; then
  bf /var/local/chad.bf
  touch ~/.chaded
fi