From: Alexander Elbs <alex@segv.de>
Subject: regression: sd cards no longer recognized
Date: Sun, 1 Jan 2012 12:51:46 +0100
Message-ID: <20120101115146.GE16096@segv.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from siggy.segv.de ([88.198.14.238]:44644 "EHLO siggy.segv.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751957Ab2AAMSM (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sun, 1 Jan 2012 07:18:12 -0500
Received: from alex by siggy.segv.de with local (Exim 4.72 #1 (Debian))
	id 1RhJx4-0004AO-DC
	for <linux-mmc@vger.kernel.org>; Sun, 01 Jan 2012 03:51:46 -0800
Content-Disposition: inline
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

Hi,

on a dell vostro with an integrated SD card reader I have the problem, that
inserted SD cards are no longer recognized.
The reader is a "O2 Micro, Inc. Integrated MMC/SD Controller (rev 02)"
(1217:7120).

Doing a git bisect I found that commit 49c468f "mmc: sd: add support for uhs
bus speed mode selection" caused this regression.

Looking more closely into it I found that the flag SDHCI_CTRL_HISPD is always
set even on MMC_TIMING_UHS_SDR12 (which is an alias for MMC_TIMING_LEGACY).

If that flag in that case is not set (as was before commit 49c468f) my reader
works fine again.

Could you include that fix or does it break other readers?

Regards,
Alexander Elbs

---
 drivers/mmc/host/sdhci.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 6d8eea3..8872e92 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1364,8 +1364,7 @@ static void sdhci_do_set_ios(struct sdhci_host *host,
struct mmc_ios *ios)
                if ((ios->timing == MMC_TIMING_UHS_SDR50) ||
                    (ios->timing == MMC_TIMING_UHS_SDR104) ||
                    (ios->timing == MMC_TIMING_UHS_DDR50) ||
-                   (ios->timing == MMC_TIMING_UHS_SDR25) ||
-                   (ios->timing == MMC_TIMING_UHS_SDR12))
+                   (ios->timing == MMC_TIMING_UHS_SDR25))
                        ctrl |= SDHCI_CTRL_HISPD;
 
                ctrl_2 = sdhci_readw(host, SDHCI_HOST_CONTROL2);
-- 
Alexander Elbs  ***  eMail alex@segv.de
