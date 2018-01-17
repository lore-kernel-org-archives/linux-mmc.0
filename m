From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH v3 00/16] mmc: tmio: another batch of TMIO MMC fixes and cleanups
Date: Thu, 18 Jan 2018 01:28:00 +0900
Message-ID: <1516206496-16612-1-git-send-email-yamada.masahiro@socionext.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Ulf Magnusson <ulfalizer@gmail.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Simon Horman <horms+renesas@verge.net.au>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, linux-renesas-soc@vger.kernel.org, Masahiro Yamada <yamada.masahiro@socionext.com>, devicetree@vger.kernel.org, linux-sh@vger.kernel.org, Yoshinori Sato <ysato@users.sourceforge.jp>, Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Lee Jones <lee.jones@linaro.org>, Rich Felker <dalias@libc.org>, Mark Rutland <mark.rutland@arm.com>, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-mmc@vger.kernel.org


In the previous batch (https://lkml.org/lkml/2017/11/24/428)
I sent 22 patches for TMIO MMC.

14 patches were applied, the rest is under discussion.

This series consists of 16 patches.

Patch 1-4:  repost from v2.
            (Wolfram gave Reviewed by, so I moved them to the head)

Patch 5-11: new patches  (cleanups of WP flag)

Patch 12: updated per Wolfram

Patch 13: repost  (almost reviewed)

Patch 14: updated

Patch 15: new

Patch 16: repost (almost reviewed)


Masahiro Yamada (16):
  mmc: tmio: ioremap memory resource in tmio_mmc_host_alloc()
  mmc: tmio: move clk_enable/disable out of tmio_mmc_host_probe()
  mmc: tmio: move {tmio_}mmc_of_parse() to tmio_mmc_host_alloc()
  mmc: tmio: remove dma_ops from tmio_mmc_host_probe() argument
  mmc: slot-gpio: add a helper to check capability of GPIO WP detection
  mmc: tmio: refactor .get_ro hook
  mmc: renesas_sdhi: use MMC_CAP2_NO_WRITE_PROTECT instead of TMIO own
    flag
  sh: kfr2r09: use MMC_CAP2_NO_WRITE_PROTECT instead of TMIO own flag
  mmc: tmio: use MMC_CAP2_NO_WRITE_PROTECT instead of TMIO own flag
  mmc: tmio: remove TMIO_MMC_WRPROTECT_DISABLE
  mmc: tmio: deprecate "toshiba,mmc-wrprotect-disable" DT property
  mmc: tmio: support IP-builtin card detection logic
  mmc: tmio: fix never-detected card insertion bug
  mmc: tmio: move TMIO_MASK_{READOP,WRITEOP} handling to correct place
  mmc: tmio: clear force_pio flag before starting data transfer
  mmc: tmio: remove useless TMIO_MASK_CMD handling in
    tmio_mmc_host_probe()

 Documentation/devicetree/bindings/mmc/tmio_mmc.txt |   1 -
 arch/sh/boards/mach-kfr2r09/setup.c                |   2 +-
 drivers/mmc/core/slot-gpio.c                       |   8 ++
 drivers/mmc/host/renesas_sdhi_core.c               |  18 ++-
 drivers/mmc/host/renesas_sdhi_internal_dmac.c      |  12 +-
 drivers/mmc/host/renesas_sdhi_sys_dmac.c           |  20 ++-
 drivers/mmc/host/tmio_mmc.c                        |  11 +-
 drivers/mmc/host/tmio_mmc.h                        |   7 +-
 drivers/mmc/host/tmio_mmc_core.c                   | 139 +++++++++++----------
 include/linux/mfd/tmio.h                           |   1 -
 include/linux/mmc/slot-gpio.h                      |   1 +
 11 files changed, 120 insertions(+), 100 deletions(-)

-- 
2.7.4
