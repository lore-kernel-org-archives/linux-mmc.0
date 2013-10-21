From: Jeremie Samuel <jeremie.samuel.ext@parrot.com>
Subject: [PATCH v2 0/8] sdhci: Move real work out of an atomic context
Date: Mon, 21 Oct 2013 17:25:49 +0200
Message-ID: <1382369157-16129-1-git-send-email-jeremie.samuel.ext@parrot.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from co202.xi-lite.net ([149.6.83.202]:36366 "EHLO co202.xi-lite.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753526Ab3JUP1Z (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 21 Oct 2013 11:27:25 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, =?UTF-8?q?Gr=C3=A9gor=20Boirie?= <gregor.boirie@parrot.com>, Matthieu Castet <matthieu.castet@parrot.com>, Jeremie Samuel <jeremie.samuel.ext@parrot.com>

Hi all,

Currently the sdhci driver does everything in the atomic context.
And what is worse, PIO transfers are made from the IRQ handler.

Some patches were already submitted to solve this issue. But there were
rejected because they involved new issues.

This set of patches is an evolution of an old patch from Anton Vorontsov.
I tried to fix all the problems involved by the patches. I tested it for
several time now with SD cards and SDIO.

So, this patch set reworks sdhci code to avoid atomic context,
almost completely.

Thanks,

Jeremie Samuel

Jeremie Samuel (8):
  sdhci: Turn timeout timer into delayed work
  sdhci: Turn tuning timeout timer into delayed work
  sdhci: Use work structs instead of tasklets
  sdhci: Use threaded IRQ handler
  sdhci: Delay led blinking
  sdhci: Turn host->lock into a mutex
  sdhci: Get rid of mdelay()s where it is safe and makes sense
  sdhci: Use jiffies instead of a timeout counter

 drivers/mmc/host/sdhci-bcm-kona.c  |    2 +-
 drivers/mmc/host/sdhci-dove.c      |    6 +-
 drivers/mmc/host/sdhci-esdhc-imx.c |    4 +-
 drivers/mmc/host/sdhci-pxav3.c     |   10 +-
 drivers/mmc/host/sdhci-s3c.c       |    7 +-
 drivers/mmc/host/sdhci-sirf.c      |    4 +-
 drivers/mmc/host/sdhci-spear.c     |    2 +-
 drivers/mmc/host/sdhci.c           |  329 ++++++++++++++++++------------------
 include/linux/mmc/sdhci.h          |   13 +-
 9 files changed, 185 insertions(+), 192 deletions(-)

-- 
1.7.10.4

