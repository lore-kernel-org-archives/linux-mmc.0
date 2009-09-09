From: Adrian Hunter <adrian.hunter@nokia.com>
Subject: [PATCH V3 11/30] omap_hsmmc: keep track of power mode
Date: Wed, 09 Sep 2009 14:57:55 +0300
Message-ID: <20090909115755.12833.10726.sendpatchset@ahunter-laptop>
References: <20090909115633.12833.39619.sendpatchset@ahunter-laptop>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:42834 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753161AbZIIL5j (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 9 Sep 2009 07:57:39 -0400
In-Reply-To: <20090909115633.12833.39619.sendpatchset@ahunter-laptop>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Jarkko Lavinen <jarkko.lavinen@nokia.com>, Adrian Hunter <adrian.hunter@nokia.com>, Madhusudhan Chikkature <madhu.cr@ti.com>, Pierre Ossman <pierre@ossman.eu>, linux-omap Mailing List <linux-omap@vger.kernel.org>, linux-mmc Mailing List <linux-mmc@vger.kernel.org>, Matt Fleming <matt@console-pimps.org>

>From c6da86a98f20740cf1c0944d92934322be6ab699 Mon Sep 17 00:00:00 2001
From: Adrian Hunter <adrian.hunter@nokia.com>
Date: Tue, 7 Jul 2009 16:44:11 +0300
Subject: [PATCH] omap_hsmmc: keep track of power mode

This patch is preparation for adding context save
and restore support.

Keep track of the current power mode so that the
context restore function can avoid restoring the
context for a card if the power has been switched
off.  If the power is off, the card must be
reinitialized anyway which will re-establish the
context.

Signed-off-by: Adrian Hunter <adrian.hunter@nokia.com>
---
 drivers/mmc/host/omap_hsmmc.c |   27 +++++++++++++++++++--------
 1 files changed, 19 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index b1bee52..8a41629 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -141,6 +141,7 @@ struct mmc_omap_host {
 	unsigned int		dma_len;
 	unsigned int		dma_sg_idx;
 	unsigned char		bus_mode;
+	unsigned char		power_mode;
 	u32			*buffer;
 	u32			bytesleft;
 	int			suspended;
@@ -856,16 +857,25 @@ static void omap_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 	unsigned long regval;
 	unsigned long timeout;
 	u32 con;
+	int do_send_init_stream = 0;
 
 	mmc_host_enable(host->mmc);
 
-	switch (ios->power_mode) {
-	case MMC_POWER_OFF:
-		mmc_slot(host).set_power(host->dev, host->slot_id, 0, 0);
-		break;
-	case MMC_POWER_UP:
-		mmc_slot(host).set_power(host->dev, host->slot_id, 1, ios->vdd);
-		break;
+	if (ios->power_mode != host->power_mode) {
+		switch (ios->power_mode) {
+		case MMC_POWER_OFF:
+			mmc_slot(host).set_power(host->dev, host->slot_id,
+						 0, 0);
+			break;
+		case MMC_POWER_UP:
+			mmc_slot(host).set_power(host->dev, host->slot_id,
+						 1, ios->vdd);
+			break;
+		case MMC_POWER_ON:
+			do_send_init_stream = 1;
+			break;
+		}
+		host->power_mode = ios->power_mode;
 	}
 
 	con = OMAP_HSMMC_READ(host->base, CON);
@@ -931,7 +941,7 @@ static void omap_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 	OMAP_HSMMC_WRITE(host->base, SYSCTL,
 		OMAP_HSMMC_READ(host->base, SYSCTL) | CEN);
 
-	if (ios->power_mode == MMC_POWER_ON)
+	if (do_send_init_stream)
 		send_init_stream(host);
 
 	if (ios->bus_mode == MMC_BUSMODE_OPENDRAIN)
@@ -1109,6 +1119,7 @@ static int __init omap_mmc_probe(struct platform_device *pdev)
 	host->slot_id	= 0;
 	host->mapbase	= res->start;
 	host->base	= ioremap(host->mapbase, SZ_4K);
+	host->power_mode = -1;
 
 	platform_set_drvdata(pdev, host);
 	INIT_WORK(&host->mmc_carddetect_work, mmc_omap_detect);
-- 
1.5.6.3

