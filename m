From: Bing Zhao <bzhao@marvell.com>
Subject: [PATCH] sdio: add MMC_PM_SKIP_RESUME_PROBE to workaround powered resume
Date: Wed, 21 Jul 2010 18:46:55 -0700
Message-ID: <1279763215-17574-1-git-send-email-bzhao@marvell.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from dakia2.marvell.com ([65.219.4.35]:40267 "EHLO
	dakia2.marvell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753106Ab0GVBUZ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 21 Jul 2010 21:20:25 -0400
Received: from maili.marvell.com (maili.marvell.com [10.68.76.51]) by dakia2.marvell.com with ESMTP id oMSCanCDndAMP3k4 for <linux-mmc@vger.kernel.org>; Wed, 21 Jul 2010 18:20:25 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Bing Zhao <bzhao@marvell.com>, Nicolas Pitre <nico@marvell.com>

Marvell 8686/8688 device will not respond to re-probe attemps
in powered resume, if the card is in sleep mode.
The added MMC_PM_SKIP_RESUME_PROBE flag is checked so that
call to mmc_sdio_init_card() can be skipped.

Signed-off-by: Bing Zhao <bzhao@marvell.com>
---
 drivers/mmc/core/sdio.c      |   18 +++++++++++++++---
 drivers/mmc/host/sdhci-pci.c |    3 ++-
 include/linux/mmc/pm.h       |    1 +
 3 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
index bd2755e..dc03939 100644
--- a/drivers/mmc/core/sdio.c
+++ b/drivers/mmc/core/sdio.c
@@ -606,15 +606,27 @@ static int mmc_sdio_suspend(struct mmc_host *host)
 
 static int mmc_sdio_resume(struct mmc_host *host)
 {
-	int i, err;
+	int i, err = 0;
 
 	BUG_ON(!host);
 	BUG_ON(!host->card);
 
 	/* Basic card reinitialization. */
 	mmc_claim_host(host);
-	err = mmc_sdio_init_card(host, host->ocr, host->card,
-				 (host->pm_flags & MMC_PM_KEEP_POWER));
+
+	/*
+	 * For a powered resume, Marvell 8686/8688 device will not respond
+	 * to re-initialization attemps if the card is in sleep mode.
+	 * The MMC_PM_SKIP_RESUME_PROBE flag is added as a workaround here.
+	 * This is a temporary measure until a fully thought-through
+	 * solution is elaborated.
+	 */
+	if (!(host->pm_flags & MMC_PM_KEEP_POWER) ||
+		!(host->pm_flags & MMC_PM_SKIP_RESUME_PROBE)) {
+			err = mmc_sdio_init_card(host, host->ocr, host->card,
+					host->pm_flags & MMC_PM_KEEP_POWER);
+	}
+
 	if (!err) {
 		/* We may have switched to 1-bit mode during suspend. */
 		err = sdio_enable_4bit_bus(host->card);
diff --git a/drivers/mmc/host/sdhci-pci.c b/drivers/mmc/host/sdhci-pci.c
index e021431..4f793f8 100644
--- a/drivers/mmc/host/sdhci-pci.c
+++ b/drivers/mmc/host/sdhci-pci.c
@@ -703,7 +703,8 @@ static struct sdhci_pci_slot * __devinit sdhci_pci_probe_slot(
 			goto unmap;
 	}
 
-	host->mmc->pm_caps = MMC_PM_KEEP_POWER | MMC_PM_WAKE_SDIO_IRQ;
+	host->mmc->pm_caps = MMC_PM_KEEP_POWER | MMC_PM_WAKE_SDIO_IRQ
+				| MMC_PM_SKIP_RESUME_PROBE;
 
 	ret = sdhci_add_host(host);
 	if (ret)
diff --git a/include/linux/mmc/pm.h b/include/linux/mmc/pm.h
index d37aac4..7dbb630 100644
--- a/include/linux/mmc/pm.h
+++ b/include/linux/mmc/pm.h
@@ -26,5 +26,6 @@ typedef unsigned int mmc_pm_flag_t;
 
 #define MMC_PM_KEEP_POWER	(1 << 0)	/* preserve card power during suspend */
 #define MMC_PM_WAKE_SDIO_IRQ	(1 << 1)	/* wake up host system on SDIO IRQ assertion */
+#define MMC_PM_SKIP_RESUME_PROBE	(1 << 2)	/* skip the attempt to reidentify the card in powered resume */
 
 #endif
-- 
1.5.3.6

