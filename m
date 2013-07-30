From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Subject: [PATCH v2 00/13] Remove platform callbacks from mmc_spi, sh_mmcif and sh_mobile_sdhi drivers
Date: Tue, 30 Jul 2013 12:37:24 +0200
Message-ID: <1375180657-23641-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-sh@vger.kernel.org, linux-spi@vger.kernel.org, Hartley Sweeten <hsweeten@visionengravers.com>, Ryan Mallon <rmallon@gmail.com>, Chris Ball <cjb@laptop.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Ian Molton <ian@mnementh.co.uk>, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
List-Id: linux-mmc@vger.kernel.org

Hello,

This patch set replaces callbacks to board code with regulators and GPIOs in
the mmc_spi, sh_mmcif and sh_mobile_sdhi MMC drivers.

Most of the required infrastructure is in place already on the drivers side,
except for CD debouncing support in the MMC core and CD/RO GPIOs support in
the mmc_spi driver. The series thus starts with patches 01/13 and 02/13 that
add those features to the MMC core and mmc_spi driver.

Patches 03/13 to 06/13 remove the board callbacks from the ecovec24 and
vision_ep9307 boards. The code has been compile-tested only as I don't have
access to those boards.

Patches 07/13 to 13/13 then proceed to remove the callbacks from the drivers
themselves and from the platform data structures.

This will be a bit messy to merge, as the series interleaves patches for
drivers and board files. Given that the mmc_spi driver is marked as orphan in
MAINTAINERS and that the vision_ep9307 hasn't seen any board-specific
modification in the last couple of kernel versions one option would be to
merge all patches (or at least patches 01/13 to 07/13) through Simon's tree if
all involved maintainers agree.

If patch 01/13 should better be merged through the MMC tree (in which case
02/13 should go through that tree as well), the two patches should be applied
first to the MMC tree, and a stable branch will be needed for Simon to base
the rest of the series on.

The series is based on tag renesas-devel-20130730v2 from
git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git

Laurent Pinchart (13):
  mmc: slot-gpio: Add debouncing capability to mmc_gpio_request_cd()
  mmc: mmc_spi: Support CD/RO GPIOs
  ARM: ep93xx: vision_ep9307: Use MMC CD and RO GPIO
  sh: ecovec24: Use MMC/SDHI CD and RO GPIO
  sh: ecovec24: Remove mmcif .down_pwr() callback
  sh: ecovec24: Remove MMCIF and SDHI .set_pwr() callbacks
  mmc: mmc_spi: Remove platform data .get_cd() and .get_ro() callbacks
  mmc: sh_mmcif: Remove .down_pwr() callback from platform data
  mmc: sh_mmcif: Remove .set_pwr() callback from platform data
  mmc: sh_mobile_sdhi: Remove .get_cd() callback from platform data
  mmc: sh_mobile_sdhi: Remove .set_pwr() callback from platform data
  mmc: tmio-mmc: Remove .get_cd() callback from platform data
  mmc: tmio-mmc: Remove .set_pwr() callback from platform data

 arch/arm/mach-ep93xx/vision_ep9307.c | 57 ++---------------------
 arch/sh/boards/mach-ecovec24/setup.c | 89 ++++--------------------------------
 drivers/mmc/core/host.c              |  2 +-
 drivers/mmc/core/slot-gpio.c         | 14 +++++-
 drivers/mmc/host/jz4740_mmc.c        |  2 +-
 drivers/mmc/host/mmc_spi.c           | 49 +++++++++-----------
 drivers/mmc/host/mvsdio.c            |  3 +-
 drivers/mmc/host/of_mmc_spi.c        | 46 +++++--------------
 drivers/mmc/host/sdhci-esdhc-imx.c   |  2 +-
 drivers/mmc/host/sdhci-pxav3.c       |  3 +-
 drivers/mmc/host/sdhci-sirf.c        |  2 +-
 drivers/mmc/host/sh_mmcif.c          |  5 +-
 drivers/mmc/host/sh_mobile_sdhi.c    | 18 --------
 drivers/mmc/host/tmio_mmc.h          |  1 -
 drivers/mmc/host/tmio_mmc_pio.c      | 25 +---------
 include/linux/mfd/tmio.h             |  2 -
 include/linux/mmc/sh_mmcif.h         |  2 -
 include/linux/mmc/sh_mobile_sdhi.h   |  2 -
 include/linux/mmc/slot-gpio.h        |  3 +-
 include/linux/spi/mmc_spi.h          | 19 +++++---
 20 files changed, 86 insertions(+), 260 deletions(-)

-- 
Regards,

Laurent Pinchart

