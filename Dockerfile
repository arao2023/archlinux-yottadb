FROM lopsided/archlinux
MAINTAINER arao2023 
RUN pacman -Syu --noconfirm base base-devel git vim && \
    useradd -mG wheel user && \
    echo "%wheel ALL=(ALL:ALL) NOPASSWD: ALL" >> /etc/sudoers
USER user
RUN cd /tmp && \
    git clone https://github.com/arao2023/PKGBUILDS && \
    cd PKGBUILDS/yottadb-git && \
    env MAKEFLAGS="-j$(nproc)" makepkg -si --noconfirm && \
    echo 'source $(pkg-config --variable=prefix yottadb)/ydb_env_set' \
        | sudo tee /etc/profile
ENTRYPOINT ["/usr/bin/bash", "-l"]
