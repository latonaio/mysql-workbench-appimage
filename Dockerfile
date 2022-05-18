# 最新版パッケージ利用のため Arch Linux を利用
FROM lopsided/archlinux:latest AS builder

# ビルド高速化のため日本国内のアップデートサーバを指定
WORKDIR /build
RUN (case $(uname -m) in \
  aarch64) \
    echo -n 'https://jp.mirror.archlinuxarm.org/$arch/$repo' \
  ;; \
  x86_64) \
    echo -n 'https://mirrors.edge.kernel.org/archlinux/$repo/os/$arch' \
  ;; \
  esac) > /build/mirror \
  && (echo -n 'Server = ' \
    && cat /build/mirror) > /etc/pacman.d/mirrorlist


# パッケージのインストール
RUN pacman -Syu --noconfirm \
  && pacman -S --noconfirm \
    awk \
    binutils \
    desktop-file-utils \
    fakeroot \
    gdk-pixbuf2 \
    grep \
    gtk-update-icon-cache \
    patchelf \
    procps-ng \
    python \
    python-pip \
    strace \
    wget \
  && pacman -Scc --noconfirm


# appimagetool の準備
WORKDIR /usr/lib/appimagetool
RUN curl -L "https://github.com/AppImage/AppImageKit/releases/download/continuous/appimagetool-$(uname -m).AppImage" -o appimagetool.AppImage \
  && chmod +x appimagetool.AppImage \
  && ./appimagetool.AppImage --appimage-extract \
  && rm -f appimagetool.AppImage \
  && ln -sf /usr/lib/appimagetool/squashfs-root/AppRun /usr/bin/appimagetool

# appimage-builder のインストール
RUN pip install appimage-builder

# ビルド
WORKDIR /build
COPY AppImageBuilder.yml /build
RUN arch=$(uname -m) \
  mirror=$(cat /build/mirror) \
  version=$(LANG=C pacman -Si mysql-workbench | grep '^Version' | awk '{print $3}') \
  appimage-builder


# --------

FROM scratch

# ビルド済みバイナリの出力
COPY --from=builder /build/*.AppImage /
