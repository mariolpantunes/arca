#!/usr/bin/env bash


CREDENTIALS=/home/mantunes/.arcacredentials
USERNAME=mario.antunes
WORKGROUP=UA
ID=mantunes
MOUNT=/home/$ID/arca


function is_mounted() {
  if grep -qs $MOUNT /proc/mounts; then
    return 0
  else
    return 1
  fi
}


function arca_mount() {
  sudo mount -t cifs -o credentials=$CREDENTIALS,username=$USERNAME,workgroup=$WORKGROUP,uid=$ID,dir_mode=0700,file_mode=0700 '\\arca.ua.pt\utilizadores\'$USERNAME'@ua.pt' $MOUNT
}


function arca_umount() {
  sudo umount $MOUNT
}


function start() {
   if is_mounted ; then
    echo -e "The arca remote is already mounted"
  else
    arca_mount
  fi
}


function stop() {
   if is_mounted ; then
    arca_umount
  else
    echo -e "The arca remote is already unmounted"
  fi
}


function status() {
  if is_mounted ; then
    echo -e "The arca remote is mounted"
  else
    echo -e "The arca remote is not mounted"
  fi
}


case "$1" in
  start)
    start
  ;;

  stop)
    stop
  ;;

  restart)
    stop
    start
  ;;

  status)
    status
  ;;

  *)
  echo "Usage: $0 (start|stop|restart)"
esac
