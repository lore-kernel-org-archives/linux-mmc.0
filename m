From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH] mmc: tmio_mmc: Hotplug code regrouping
Date: Fri, 23 Dec 2011 23:03:13 +0100 (CET)
Message-ID: <Pine.LNX.4.64.1112232301310.1911@axis700.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:56222 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754468Ab1LWWDT (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 23 Dec 2011 17:03:19 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Chris Ball <cjb@laptop.org>

From: Bastian Hecht <hechtb@googlemail.com>

This patch regroups the code slightly, adds documentation and allows
the rtpm counter of MMC_CAP_NEEDS_POLL devices to reach 0 again.

Signed-off-by: Bastian Hecht <hechtb@gmail.com>
[g.liakhovetski@gmx.de: restore pm_runtime_get_noresume()]
Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 drivers/mmc/host/tmio_mmc_pio.c |   30 +++++++++++++++++++++---------
 1 files changed, 21 insertions(+), 9 deletions(-)

diff --git a/drivers/mmc/host/tmio_mmc_pio.c b/drivers/mmc/host/tmio_mmc_pio.c
index 4208b39..abad01b 100644
--- a/drivers/mmc/host/tmio_mmc_pio.c
+++ b/drivers/mmc/host/tmio_mmc_pio.c
@@ -800,8 +800,7 @@ static void tmio_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 	} else if (ios->power_mode != MMC_POWER_UP) {
 		if (host->set_pwr && ios->power_mode == MMC_POWER_OFF)
 			host->set_pwr(host->pdev, 0);
-		if ((pdata->flags & TMIO_MMC_HAS_COLD_CD) &&
-		    pdata->power) {
+		if (pdata->power) {
 			pdata->power = false;
 			pm_runtime_put(&host->pdev->dev);
 		}
@@ -915,6 +914,23 @@ int __devinit tmio_mmc_host_probe(struct tmio_mmc_host **host,
 	if (ret < 0)
 		goto pm_disable;
 
+	/*
+	 * There are 4 different scenarios for the card detection:
+	 *  1) an external gpio irq handles the cd (best for power savings)
+	 *  2) internal sdhi irq handles the cd
+	 *  3) a worker thread polls the sdhi - indicated by MMC_CAP_NEEDS_POLL
+	 *  4) the medium is non-removable - indicated by MMC_CAP_NONREMOVABLE
+	 *
+	 *  While we increment the rtpm counter for all scenarios when the mmc
+	 *  core activates us by calling an appropriate set_ios(), we must
+	 *  additionally ensure that in case 2) the tmio mmc hardware stays
+	 *  powered on during runtime for the card detection to work.
+	 */
+	if (!(pdata->flags & TMIO_MMC_HAS_COLD_CD
+		|| mmc->caps & MMC_CAP_NEEDS_POLL
+		|| mmc->caps & MMC_CAP_NONREMOVABLE))
+		pm_runtime_get_noresume(&pdev->dev);
+
 	tmio_mmc_clk_stop(_host);
 	tmio_mmc_reset(_host);
 
@@ -933,12 +949,6 @@ int __devinit tmio_mmc_host_probe(struct tmio_mmc_host **host,
 	/* See if we also get DMA */
 	tmio_mmc_request_dma(_host, pdata);
 
-	/* We have to keep the device powered for its card detection to work */
-	if (!(pdata->flags & TMIO_MMC_HAS_COLD_CD)) {
-		pdata->power = true;
-		pm_runtime_get_noresume(&pdev->dev);
-	}
-
 	mmc_add_host(mmc);
 
 	/* Unmask the IRQs we want to know about */
@@ -974,7 +984,9 @@ void tmio_mmc_host_remove(struct tmio_mmc_host *host)
 	 * the controller, the runtime PM is suspended and pdata->power == false,
 	 * so, our .runtime_resume() will not try to detect a card in the slot.
 	 */
-	if (host->pdata->flags & TMIO_MMC_HAS_COLD_CD)
+	if (host->pdata->flags & TMIO_MMC_HAS_COLD_CD
+		|| host->mmc->caps & MMC_CAP_NEEDS_POLL
+		|| host->mmc->caps & MMC_CAP_NONREMOVABLE)
 		pm_runtime_get_sync(&pdev->dev);
 
 	mmc_remove_host(host->mmc);
-- 
1.7.2.5

