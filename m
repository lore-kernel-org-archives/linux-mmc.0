From: akpm@linux-foundation.org
Subject: [patch 057/232] omap_hsmmc: ensure workqueues are empty before suspend
Date: Tue, 22 Sep 2009 16:44:45 -0700
Message-ID: <200909222344.n8MNikuQ012811@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:60968 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753478AbZIVXpb (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 22 Sep 2009 19:45:31 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, adrian.hunter@nokia.com, ext-denis.2.karpov@nokia.com, ian@mnementh.co.uk, jarkko.lavinen@nokia.com, linux-mmc@vger.kernel.org, madhu.cr@ti.com, matt@console-pimps.org, philipl@overt.org, pierre@ossman.eu, roberto.foglietta@gmail.com

From: Adrian Hunter <adrian.hunter@nokia.com>

Signed-off-by: Adrian Hunter <adrian.hunter@nokia.com>
Acked-by: Matt Fleming <matt@console-pimps.org>
Cc: Ian Molton <ian@mnementh.co.uk>
Cc: "Roberto A. Foglietta" <roberto.foglietta@gmail.com>
Cc: Jarkko Lavinen <jarkko.lavinen@nokia.com>
Cc: Denis Karpov <ext-denis.2.karpov@nokia.com>
Cc: Pierre Ossman <pierre@ossman.eu>
Cc: Philip Langdale <philipl@overt.org>
Cc: "Madhusudhan" <madhu.cr@ti.com>
Cc: <linux-mmc@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/mmc/host/omap_hsmmc.c |   50 +++++++++++++++++++++-----------
 1 file changed, 34 insertions(+), 16 deletions(-)

diff -puN drivers/mmc/host/omap_hsmmc.c~omap_hsmmc-ensure-workqueues-are-empty-before-suspend drivers/mmc/host/omap_hsmmc.c
--- a/drivers/mmc/host/omap_hsmmc.c~omap_hsmmc-ensure-workqueues-are-empty-before-suspend
+++ a/drivers/mmc/host/omap_hsmmc.c
@@ -151,7 +151,6 @@ struct mmc_omap_host {
 	u32			bytesleft;
 	int			suspended;
 	int			irq;
-	int			carddetect;
 	int			use_dma, dma_ch;
 	int			dma_line_tx, dma_line_rx;
 	int			slot_id;
@@ -761,14 +760,19 @@ static void mmc_omap_detect(struct work_
 	struct mmc_omap_host *host = container_of(work, struct mmc_omap_host,
 						mmc_carddetect_work);
 	struct omap_mmc_slot_data *slot = &mmc_slot(host);
+	int carddetect;
+
+	if (host->suspended)
+		return;
+
+	sysfs_notify(&host->mmc->class_dev.kobj, NULL, "cover_switch");
 
 	if (mmc_slot(host).card_detect)
-		host->carddetect = slot->card_detect(slot->card_detect_irq);
+		carddetect = slot->card_detect(slot->card_detect_irq);
 	else
-		host->carddetect = -ENOSYS;
+		carddetect = -ENOSYS;
 
-	sysfs_notify(&host->mmc->class_dev.kobj, NULL, "cover_switch");
-	if (host->carddetect) {
+	if (carddetect) {
 		mmc_detect_change(host->mmc, (HZ * 200) / 1000);
 	} else {
 		mmc_host_enable(host->mmc);
@@ -785,6 +789,8 @@ static irqreturn_t omap_mmc_cd_handler(i
 {
 	struct mmc_omap_host *host = (struct mmc_omap_host *)dev_id;
 
+	if (host->suspended)
+		return IRQ_HANDLED;
 	schedule_work(&host->mmc_carddetect_work);
 
 	return IRQ_HANDLED;
@@ -1524,30 +1530,42 @@ static int omap_mmc_suspend(struct platf
 		return 0;
 
 	if (host) {
+		host->suspended = 1;
+		if (host->pdata->suspend) {
+			ret = host->pdata->suspend(&pdev->dev,
+							host->slot_id);
+			if (ret) {
+				dev_dbg(mmc_dev(host->mmc),
+					"Unable to handle MMC board"
+					" level suspend\n");
+				host->suspended = 0;
+				return ret;
+			}
+		}
+		cancel_work_sync(&host->mmc_carddetect_work);
 		mmc_host_enable(host->mmc);
 		ret = mmc_suspend_host(host->mmc, state);
 		if (ret == 0) {
-			host->suspended = 1;
-
 			OMAP_HSMMC_WRITE(host->base, ISE, 0);
 			OMAP_HSMMC_WRITE(host->base, IE, 0);
 
-			if (host->pdata->suspend) {
-				ret = host->pdata->suspend(&pdev->dev,
-								host->slot_id);
-				if (ret)
-					dev_dbg(mmc_dev(host->mmc),
-						"Unable to handle MMC board"
-						" level suspend\n");
-			}
 
 			OMAP_HSMMC_WRITE(host->base, HCTL,
 					 OMAP_HSMMC_READ(host->base, HCTL) & ~SDBP);
 			mmc_host_disable(host->mmc);
 			clk_disable(host->iclk);
 			clk_disable(host->dbclk);
-		} else
+		} else {
+			host->suspended = 0;
+			if (host->pdata->resume) {
+				ret = host->pdata->resume(&pdev->dev,
+							  host->slot_id);
+				if (ret)
+					dev_dbg(mmc_dev(host->mmc),
+						"Unmask interrupt failed\n");
+			}
 			mmc_host_disable(host->mmc);
+		}
 
 	}
 	return ret;
_
