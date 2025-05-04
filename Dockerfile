ARG LIBC=musl

FROM ghcr.io/void-linux/void-$LIBC-full:latest

RUN <<EOT sh
  set -ex
  echo y | env XBPS_ARCH=x86_64-musl xbps-install -S
  echo y | env XBPS_ARCH=x86_64-musl xbps-install -y -A bash
  echo y | env XBPS_ARCH=x86_64-musl xbps-install -y -A \
    base-voidstrap acl-progs dialog netcat p7zip patch pwgen pv \
    rsync wget unzip zip iputils dcron void-repo-nonfree \
    screen tmux
  svdir=/etc/runit/runsvdir/default

  for sv in crond uuidd statd rpcbind dbus udevd elogind sshd
  do
    [ -e /etc/sv/\$sv ] || continue
    rm -f \$svdir/\$sv
    ln -s /etc/sv/\$sv \$svdir/\$sv
  done

  rm -fv /etc/runit/core-services/*-filesystems.sh
  rm -fv /etc/runit/runsvdir/default/agetty-*
  find /var/cache/xbps -type f -print0 | xargs -0 -r rm -v

EOT

CMD [ "/sbin/runit" ]
