From: Adrian Hunter <adrian.hunter@nokia.com>
Subject: [PATCH 09/22] mmc: omap_hsmmc: move hardcoded frequency constants to definition block
Date: Thu,  5 May 2011 14:51:09 +0300
Message-ID: <1304596282-4095-10-git-send-email-adrian.hunter@nokia.com>
References: <1304596282-4095-1-git-send-email-adrian.hunter@nokia.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.128.24]:62762 "EHLO mgw-da01.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753252Ab1EELwW (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 5 May 2011 07:52:22 -0400
In-Reply-To: <1304596282-4095-1-git-send-email-adrian.hunter@nokia.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Madhusudhan Chikkature <madhu.cr@ti.com>, linux-omap Mailing List <linux-omap@vger.kernel.org>, linux-mmc Mailing List <linux-mmc@vger.kernel.org>, linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>, Andy Shevchenko <ext-andriy.shevchenko@nokia.com>, Adrian Hunter <adrian.hunter@nokia.com>

From: Andy Shevchenko <ext-andriy.shevchenko@nokia.com>

Move the min and max frequency constants to the definition block in the source
file.

Signed-off-by: Andy Shevchenko <ext-andriy.shevchenko@nokia.com>
Signed-off-by: Adrian Hunter <adrian.hunter@nokia.com>
---
 drivers/mmc/host/omap_hsmmc.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index a1a1101..a727bf8 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -120,6 +120,8 @@
 
 #define MMC_TIMEOUT_MS		20
 #define OMAP_MMC_MASTER_CLOCK	96000000
+#define OMAP_MMC_MIN_CLOCK	400000
+#define OMAP_MMC_MAX_CLOCK	52000000
 #define DRIVER_NAME		"omap_hsmmc"
 
 #define DMA_TYPE_NODMA	0
@@ -2176,8 +2178,8 @@ static int __init omap_hsmmc_probe(struct platform_device *pdev)
 	if (mmc_slot(host).vcc_aux_disable_is_sleep)
 		mmc_slot(host).no_off = 1;
 
-	mmc->f_min	= 400000;
-	mmc->f_max	= 52000000;
+	mmc->f_min	= OMAP_MMC_MIN_CLOCK;
+	mmc->f_max	= OMAP_MMC_MAX_CLOCK;
 
 	spin_lock_init(&host->irq_lock);
 
-- 
1.7.0.4

