From: Dave Martin <dave.martin@linaro.org>
Subject: [PATCH 00/16] ARM: amba: Enable module alias autogeneration for AMBA drivers
Date: Wed,  5 Oct 2011 17:04:51 +0100
Message-ID: <1317830707-17517-1-git-send-email-dave.martin@linaro.org>
Return-path: <linux-serial-owner@vger.kernel.org>
Sender: linux-serial-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: patches@linaro.org, =?UTF-8?q?Pawe=C5=82=20Moll?= <Pawel.Moll@arm.com>, Alan Cox <alan@linux.intel.com>, Alessandro Rubini <rubini@unipv.it>, Alessandro Zummo <a.zummo@towertech.it>, alsa-devel@alsa-project.org, Chris Ball <cjb@laptop.org>, Dan Williams <dan.j.williams@intel.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Grant Likely <grant.likely@secretlab.ca>, Jaroslav Kysela <perex@perex.cz>, Julia Lawall <julia@diku.dk>, Linus Walleij <linus.walleij@linaro.org>, linux-fbdev@vger.kernel.org, linux-input@vger.kernel.org, linux-mmc@vger.kernel.org, linux-serial@vger.kernel.org, linux-watchdog@vger.kernel.org, Paul Mundt <lethal@linux-sh.org>, rtc-linux@googlegroups.com, Russell King <linux@arm.linux.org.uk>, spi-devel-general@lists.sourceforge.net, Takashi Iwai <tiwai@suse.de>, Vinod Koul <vinod.koul@intel.com>, Wim Van Sebroeck <wim@iguana.be>
List-Id: linux-mmc@vger.kernel.org

There's no special reason why AMBA device drivers should not be
auto-loadable via udev, but udev currently has no way to map AMBA
device IDs to drivers.

As part of the effort to help enable the building of multiple
ARM platforms into a single kernel image in the future, it's desirable
to be able to build any non-critical platform-specific drivers as
modules.

A straightforward solution is to use modaliases to allow udev to
identify the correct driver module to load.

This series enables the general infrastructure for modalias generation
to work for AMBA devices, and enables it in the affected drivers.

Briefly tested on Versatile Express, including aaci, mmci and amba-clcd
(which appears to have the most interesting modalias match pattern).
For me, the appropiate modules now get loaded at udev trigger time.

Any comments and feedback are welcome.

Dave Martin (16):
  ARM: amba: Move definition of struct amba_id to mod_devicetable.h
  ARM: amba: Auto-generate AMBA driver module aliases during modpost
  hwrng: nomadik: Enable module alias autogeneration for AMBA drivers
  dmaengine: pl08x: Enable module alias autogeneration for AMBA drivers
  dmaengine: pl330: Enable module alias autogeneration for AMBA drivers
  gpio: pl061: Enable module alias autogeneration for AMBA drivers
  input: ambakmi: Enable module alias autogeneration for AMBA drivers
  mmc: mmci: Enable module alias autogeneration for AMBA drivers
  rtc: pl030: Enable module alias autogeneration for AMBA drivers
  rtc: pl031: Enable module alias autogeneration for AMBA drivers
  spi: pl022: Enable module alias autogeneration for AMBA drivers
  serial: pl010: Enable module alias autogeneration for AMBA drivers
  serial: pl011: Enable module alias autogeneration for AMBA drivers
  fbdev: amba: Enable module alias autogeneration for AMBA drivers
  watchdog: sp805: Enable module alias autogeneration for AMBA drivers
  sound: aaci: Enable module alias autogeneration for AMBA drivers

 drivers/amba/bus.c                   |    9 ++++-
 drivers/char/hw_random/nomadik-rng.c |    2 +
 drivers/dma/amba-pl08x.c             |    2 +
 drivers/dma/pl330.c                  |    2 +
 drivers/gpio/gpio-pl061.c            |    2 +
 drivers/input/serio/ambakmi.c        |    2 +
 drivers/mmc/host/mmci.c              |    2 +
 drivers/rtc/rtc-pl030.c              |    2 +
 drivers/rtc/rtc-pl031.c              |    2 +
 drivers/spi/spi-pl022.c              |    2 +
 drivers/tty/serial/amba-pl010.c      |    2 +
 drivers/tty/serial/amba-pl011.c      |    2 +
 drivers/video/amba-clcd.c            |    2 +
 drivers/watchdog/sp805_wdt.c         |    2 +
 include/linux/amba/bus.h             |    7 +---
 include/linux/mod_devicetable.h      |   18 ++++++++
 scripts/mod/file2alias.c             |   72 ++++++++++++++++++++++++++++++++++
 sound/arm/aaci.c                     |    2 +
 18 files changed, 127 insertions(+), 7 deletions(-)

-- 
1.7.4.1

