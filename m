From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 02/10 v3] mmc: tmio: calculate the native hotplug condition only once
Date: Thu,  9 Feb 2012 22:57:08 +0100
Message-ID: <1328824636-10553-3-git-send-email-g.liakhovetski@gmx.de>
References: <1328824636-10553-1-git-send-email-g.liakhovetski@gmx.de>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:63969 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932212Ab2BIV5V (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 9 Feb 2012 16:57:21 -0500
In-Reply-To: <1328824636-10553-1-git-send-email-g.liakhovetski@gmx.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Chris Ball <cjb@laptop.org>, Paul Mundt <lethal@linux-sh.org>, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>

The condition, whether we have to use the native TMIO card hotplug
detection interrupt, is rather complex, it is better to only calculate it
once and store in the private data.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 drivers/mmc/host/tmio_mmc.h     |    1 +
 drivers/mmc/host/tmio_mmc_pio.c |   11 +++++------
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/host/tmio_mmc.h b/drivers/mmc/host/tmio_mmc.h
index f96c536..8531d8d 100644
--- a/drivers/mmc/host/tmio_mmc.h
+++ b/drivers/mmc/host/tmio_mmc.h
@@ -86,6 +86,7 @@ struct tmio_mmc_host {
 	spinlock_t		lock;		/* protect host private data */
 	unsigned long		last_req_ts;
 	struct mutex		ios_lock;	/* protect set_ios() context */
+	bool			native_hotplug;
 };
 
 int tmio_mmc_host_probe(struct tmio_mmc_host **host,
diff --git a/drivers/mmc/host/tmio_mmc_pio.c b/drivers/mmc/host/tmio_mmc_pio.c
index 5f9ad74..a5d1052 100644
--- a/drivers/mmc/host/tmio_mmc_pio.c
+++ b/drivers/mmc/host/tmio_mmc_pio.c
@@ -912,6 +912,9 @@ int __devinit tmio_mmc_host_probe(struct tmio_mmc_host **host,
 	else
 		mmc->ocr_avail = MMC_VDD_32_33 | MMC_VDD_33_34;
 
+	_host->native_hotplug = !(pdata->flags & TMIO_MMC_HAS_COLD_CD ||
+				  mmc->caps & MMC_CAP_NEEDS_POLL ||
+				  mmc->caps & MMC_CAP_NONREMOVABLE);
 	pdata->power = false;
 	pm_runtime_enable(&pdev->dev);
 	ret = pm_runtime_resume(&pdev->dev);
@@ -930,9 +933,7 @@ int __devinit tmio_mmc_host_probe(struct tmio_mmc_host **host,
 	 *  additionally ensure that in case 2) the tmio mmc hardware stays
 	 *  powered on during runtime for the card detection to work.
 	 */
-	if (!(pdata->flags & TMIO_MMC_HAS_COLD_CD
-		|| mmc->caps & MMC_CAP_NEEDS_POLL
-		|| mmc->caps & MMC_CAP_NONREMOVABLE))
+	if (_host->native_hotplug)
 		pm_runtime_get_noresume(&pdev->dev);
 
 	tmio_mmc_clk_stop(_host);
@@ -988,9 +989,7 @@ void tmio_mmc_host_remove(struct tmio_mmc_host *host)
 	 * the controller, the runtime PM is suspended and pdata->power == false,
 	 * so, our .runtime_resume() will not try to detect a card in the slot.
 	 */
-	if (host->pdata->flags & TMIO_MMC_HAS_COLD_CD
-		|| host->mmc->caps & MMC_CAP_NEEDS_POLL
-		|| host->mmc->caps & MMC_CAP_NONREMOVABLE)
+	if (!host->native_hotplug)
 		pm_runtime_get_sync(&pdev->dev);
 
 	mmc_remove_host(host->mmc);
-- 
1.7.2.5

