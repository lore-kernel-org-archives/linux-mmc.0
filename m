From: Ohad Ben-Cohen <ohad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v3 0/9] native support for wl1271 on ZOOM
Date: Wed, 11 Aug 2010 01:12:19 +0300
Message-ID: <1281478348-24833-1-git-send-email-ohad@wizery.com>
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Chikkature Rajashekar Madhusudhan <madhu.cr-l0cyMroinI0@public.gmane.org>, Luciano Coelho <luciano.coelho-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, San Mehat <san-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Roger Quadros <roger.quadros-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Nicolas Pitre <nico-vtqb6HGKxmzR7s880joybQ@public.gmane.org>, Pandita Vikram <vikram.pandita-l0cyMroinI0@public.gmane.org>, Kalle Valo <kalle.valo-X3B1VOXEql0@public.gmane.org>, Ohad Ben-Cohen <ohad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

This patch series adds native support for wl1271 on ZOOM.

Changes since v2:
- mmc/sdio power manipulation is removed, and will be
  posted separately in the shape of mmc/sdio runtime pm.
- the platform device is back, used to deliver board-specific
  platform data (i.e. irq and ref clock)

Patches are based on linux-next (as of Aug 7th), and tested
on ZOOM2.

Please note that I am going to have a very limited email access
in the next three weeks, so I might not respond right away.

Thanks,

Ohad Ben-Cohen (9):
  wireless: wl1271: make wl12xx.h common to both spi and sdio
  wireless: wl1271: support return value for the set power func
  wireless: wl1271: add platform driver to get board data
  wireless: wl1271: take irq info from private board data
  wireless: wl1271: make ref_clock configurable by board
  omap: hsmmc: remove unused variable
  omap: zoom: add fixed regulator device for wlan
  omap: hsmmc: support mmc3 regulator power control
  omap: zoom: add mmc3/wl1271 device support

 arch/arm/mach-omap2/board-zoom-peripherals.c |   69 +++++++++++++++
 arch/arm/mach-omap2/hsmmc.c                  |   10 ++-
 drivers/mmc/host/omap_hsmmc.c                |   68 +++++++++++++--
 drivers/net/wireless/wl12xx/wl1251_sdio.c    |    2 +-
 drivers/net/wireless/wl12xx/wl1251_spi.c     |    2 +-
 drivers/net/wireless/wl12xx/wl1271.h         |   15 +++-
 drivers/net/wireless/wl12xx/wl1271_boot.c    |    9 +-
 drivers/net/wireless/wl12xx/wl1271_boot.h    |    1 -
 drivers/net/wireless/wl12xx/wl1271_io.h      |    8 +-
 drivers/net/wireless/wl12xx/wl1271_main.c    |    4 +-
 drivers/net/wireless/wl12xx/wl1271_sdio.c    |  120 +++++++++++++++++++++++---
 drivers/net/wireless/wl12xx/wl1271_spi.c     |    8 ++-
 include/linux/spi/wl12xx.h                   |   34 -------
 include/linux/wl12xx.h                       |   35 ++++++++
 14 files changed, 311 insertions(+), 74 deletions(-)
 delete mode 100644 include/linux/spi/wl12xx.h
 create mode 100644 include/linux/wl12xx.h

--
To unsubscribe from this list: send the line "unsubscribe linux-wireless" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
