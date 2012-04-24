From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH/RFC 0/7] mmc: tmio: regulator support, clock management, convert ecovec
Date: Tue, 24 Apr 2012 18:41:40 +0200
Message-ID: <1335285707-22707-1-git-send-email-g.liakhovetski@gmx.de>
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-sh@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

This patch series adds clock management callbacks to the TMIO MMC driver,
fixes clock management on SDHI systems, updates clock frequency every time
the clock is re-enabled, adds regulator support to TMIO MMC and converts
the sh7724 ecovec system to use regulators with both MMCIF and SDHI/TMIO
controllers.

These patches continue my earlier series "mmc: sh_mmcif: add regulator
support," "mmc: sh-mmcif: clock management updates." The last patch in this
series also supersedes the earlier patch "[PATCH/RFC] sh: ecovec: switch
MMC power control to regulator."

I think, my clock management updates might cause some comments and require
some updates, so, I'm labelling this whole series as RFC too.

Guennadi Liakhovetski (7):
  mmc: tmio: stop interface clock before runtime PM suspending
  mmc: tmio: don't needlessly enable interrupts during probing
  mmc: tmio: add callbacks to enable-update and disable the interface
    clock
  mmc: sdhi: implement tmio-mmc clock enable-update and disable
    callbacks
  mmc: tmio: add regulator support
  mmc: sdhi: do not install dummy callbacks
  sh: ecovec: switch MMC power control to regulators

 arch/sh/boards/mach-ecovec24/setup.c |   85 ++++++++++++++++++++--------
 drivers/mmc/host/sh_mobile_sdhi.c    |   38 ++++++++++---
 drivers/mmc/host/tmio_mmc.h          |    2 +
 drivers/mmc/host/tmio_mmc_pio.c      |  102 ++++++++++++++++++++++++++-------
 include/linux/mfd/tmio.h             |    3 +
 5 files changed, 176 insertions(+), 54 deletions(-)

Thanks
Guennadi
-- 
1.7.2.5

