From: akpm@linux-foundation.org
Subject: [patch 040/177] mmc: omap: fix for bus width which improves SD card's  peformance.
Date: Tue, 10 Aug 2010 18:01:46 -0700
Message-ID: <201008110101.o7B11kLv027065@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:39751 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757897Ab0HKBC3 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 10 Aug 2010 21:02:29 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, kishore.kadiyala@ti.com, adrian.hunter@nokia.com, jhnikula@gmail.com, linux-mmc@vger.kernel.org, madhu.cr@ti.com, matt@console-pimps.org, nm@ti.com, svenkatr@ti.com, tony@atomide.com

From: Kishore Kadiyala <kishore.kadiyala@ti.com>

This patch improves low speeds for SD cards.

OMAP-MMC controller's can support maximum bus width of '8'.  when bus
width is mentioned as "8" in controller data,the SD stack will check
whether bus width is "4" and if not it will set bus width to "1" and there
by degrading performance.  This patch fixes the issue and improves the
performance of SD cards.

Signed-off-by: Kishore Kadiyala <kishore.kadiyala@ti.com>
Signed-off-by: Venkatraman S <svenkatr@ti.com>
Signed-off-by: Nishanth Menon <nm@ti.com>
Acked-by: Madhusudhan Chikkature <madhu.cr@ti.com>
Tested-by: Jarkko Nikula <jhnikula@gmail.com>
Cc: Adrian Hunter <adrian.hunter@nokia.com>
Cc: Matt Fleming <matt@console-pimps.org>
Cc: Tony Lindgren <tony@atomide.com>
Cc: <linux-mmc@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/mmc/host/omap_hsmmc.c |   17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff -puN drivers/mmc/host/omap_hsmmc.c~mmc-omap-fix-for-bus-width-which-improves-sd-cards-peformance drivers/mmc/host/omap_hsmmc.c
--- a/drivers/mmc/host/omap_hsmmc.c~mmc-omap-fix-for-bus-width-which-improves-sd-cards-peformance
+++ a/drivers/mmc/host/omap_hsmmc.c
@@ -2096,10 +2096,23 @@ static int __init omap_hsmmc_probe(struc
 	mmc->caps |= MMC_CAP_MMC_HIGHSPEED | MMC_CAP_SD_HIGHSPEED |
 		     MMC_CAP_WAIT_WHILE_BUSY;
 
-	if (mmc_slot(host).wires >= 8)
+	switch (mmc_slot(host).wires) {
+	case 8:
 		mmc->caps |= MMC_CAP_8_BIT_DATA;
-	else if (mmc_slot(host).wires >= 4)
+		/* Fall through */
+	case 4:
 		mmc->caps |= MMC_CAP_4_BIT_DATA;
+		break;
+	case 1:
+		/* Nothing to crib here */
+	case 0:
+		/* Assuming nothing was given by board, Core use's 1-Bit */
+		break;
+	default:
+		/* Completely unexpected.. Core goes with 1-Bit Width */
+		dev_crit(mmc_dev(host->mmc), "Invalid width %d\n used!"
+			"using 1 instead\n", mmc_slot(host).wires);
+	}
 
 	if (mmc_slot(host).nonremovable)
 		mmc->caps |= MMC_CAP_NONREMOVABLE;
_
