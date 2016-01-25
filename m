From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH 0/9] mmc: sdhi: some refactoring and adding basic r8a7795 support
Date: Mon, 25 Jan 2016 20:15:07 +0100
Message-ID: <1453749316-1848-1-git-send-email-wsa@the-dreams.de>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:33061 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757563AbcAYTPV (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 25 Jan 2016 14:15:21 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-renesas-soc@vger.kernel.org, linux-sh@vger.kernel.org, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, Magnus Damm <magnus.damm@gmail.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Dirk Behme <dirk.behme@gmail.com>

So, here is the series to enable basic SD support on r8a7795; no DMA and UHS-I
for now. Will be added incrementally. It turns out that the driver needs a
little love, so some refactoring is also in place before adding the actual
support.

eMMC works in 4-bit mode, too. 8-bit mode sadly fails currently. I'll post MMC
support patches once this issue is fixed.

These patches have been tested on Gen3 (Salvator-X) and Gen2 (Lager), doing
basic operations with SD cards and running the mmc_test driver (its results
point out some potential corner cases to check later).

A branch can be found here (including clock and DTS patches):

git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git renesas/v8-sdhi

Changes since RFC (only sent to sh-devel lists):

* patches 1,7,8 are new
* patch 4 drops 10ms wait also for set_clock
* patch 9 also sets MMC_CAP_WAIT_WHILE_BUSY (see comment there)
* some commit message rewording

Please test, comment, apply...

Thanks,

   Wolfram


Shinobu Uehara (1):
  mmc: sdhi: Add EXT_ACC register busy check

Wolfram Sang (8):
  mmc: tmio_dma: remove debug messages with little information
  mmc: sdhi: error message on ENOMEM is superfluous
  mmc: tmio: add flag to reduce delay after changing clock status
  mmc: tmio: remove stale comments
  mmc: sdhi: use faster clock handling on RCar Gen2
  mmc: tmio: refactor set_clock a little
  mmc: tmio: disable clock before changing it
  mmc: sdhi: Add r8a7795 support

 Documentation/devicetree/bindings/mmc/tmio_mmc.txt |  1 +
 drivers/mmc/host/Kconfig                           |  2 +-
 drivers/mmc/host/sh_mobile_sdhi.c                  | 54 +++++++++++++++-------
 drivers/mmc/host/tmio_mmc_dma.c                    | 12 -----
 drivers/mmc/host/tmio_mmc_pio.c                    | 27 ++++++-----
 include/linux/mfd/tmio.h                           |  4 ++
 include/linux/mmc/tmio.h                           |  5 ++
 7 files changed, 63 insertions(+), 42 deletions(-)

-- 
2.1.4

