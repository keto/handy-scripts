#!/bin/bash

# Simple schroot wrapper
# Example:
#
#   $ ln -s do_chroot.sh squeeze_ls
#
# where 'squeeze' is the name of the chroot and 'ls' is the command
#
#   $ ./squeeze_ls -l squeeze_*
#   Environment: squeeze
#   Command: ls
#   Parameters: -l squeeze_ squeeze_dch squeeze_debuild squeeze_ls squeeze_pylint
#   In 2 seconds...

#   I: [squeeze chroot] Running command: “ls -l squeeze_ squeeze_dch squeeze_debuild squeeze_ls squeeze_pylint”
#   lrwxrwxrwx 1 pketolai pketolai 12 Jul 28 09:52 squeeze_ -> do_chroot.sh
#   lrwxrwxrwx 1 pketolai pketolai 12 Jun  8 13:25 squeeze_dch -> do_chroot.sh
#   lrwxrwxrwx 1 pketolai pketolai 12 Jun  8 10:22 squeeze_debuild -> do_chroot.sh
#   lrwxrwxrwx 1 pketolai pketolai 12 Jul 28 10:13 squeeze_ls -> do_chroot.sh
#   lrwxrwxrwx 1 pketolai pketolai 12 Jun 14 11:26 squeeze_pylint -> do_chroot.sh


CALL=${0##*/}
CHROOT=${CALL%_*}
CMD=${CALL#*_}
echo "Environment: $CHROOT"
if [ -z "$CMD" ]; then
  echo "Starting default command"
  CMD=""
else
  echo "Command: $CMD"
  echo "Parameters: $*"
  CMD="$CMD $*"
fi
count=5
for c in {5,4,3,2,1}; do
  echo -ne "In $c seconds...\r"
  read -t 1 && break
done
echo
schroot -c $CHROOT -p -- $CMD
