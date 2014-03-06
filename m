From: Markus Mayer <markus.mayer@linaro.org>
Subject: [PATCH] mmc: sdhci-bcm-kona: Fix locking in sdhci_bcm_kona_sd_card_emulate()
Date: Thu,  6 Mar 2014 12:25:58 +0800
Message-ID: <1394079958-11697-1-git-send-email-markus.mayer@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Chris Ball <chris@printf.net>, Matt Porter <matt.porter@linaro.org>, Christian Daudt <bcm@fixthebug.org>
Cc: Linux MMC List <linux-mmc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

Since sdhci_bcm_kona_sd_card_emulate() can be called from interrupt
context, we must use a spinlock instead of a mutex. This change
essentially restores the way things worked before the change to
mutexes in http://www.spinics.net/lists/linux-mmc/msg20276.html.

Without this change, we see "scheduling while atomic" errors.

Signed-off-by: Markus Mayer <markus.mayer@linaro.org>
---
 drivers/mmc/host/sdhci-bcm-kona.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/host/sdhci-bcm-kona.c b/drivers/mmc/host/sdhci-bcm-kona.c
index 7a190fe..f1b0a62 100644
--- a/drivers/mmc/host/sdhci-bcm-kona.c
+++ b/drivers/mmc/host/sdhci-bcm-kona.c
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2013 Broadcom Corporation
+ * Copyright (C) 2013-2014 Broadcom Corporation
  *
  * This program is free software; you can redistribute it and/or
  * modify it under the terms of the GNU General Public License as
@@ -53,7 +53,7 @@
 #define KONA_MMC_AUTOSUSPEND_DELAY		(50)
 
 struct sdhci_bcm_kona_dev {
-	struct mutex	write_lock; /* protect back to back writes */
+	spinlock_t write_lock; /* protect back to back writes */
 };
 
 
@@ -135,7 +135,7 @@ static int sdhci_bcm_kona_sd_card_emulate(struct sdhci_host *host, int insert)
 	 * insert-removal.
 	 * We keep 20uS
 	 */
-	mutex_lock(&kona_dev->write_lock);
+	spin_lock_bh(&kona_dev->write_lock);
 	udelay(20);
 	val = sdhci_readl(host, KONA_SDHOST_CORESTAT);
 
@@ -153,7 +153,7 @@ static int sdhci_bcm_kona_sd_card_emulate(struct sdhci_host *host, int insert)
 		val &= ~KONA_SDHOST_CD_SW;
 		sdhci_writel(host, val, KONA_SDHOST_CORESTAT);
 	}
-	mutex_unlock(&kona_dev->write_lock);
+	spin_unlock_bh(&kona_dev->write_lock);
 
 	return 0;
 }
@@ -247,7 +247,7 @@ static int sdhci_bcm_kona_probe(struct platform_device *pdev)
 	pltfm_priv = sdhci_priv(host);
 
 	kona_dev = sdhci_pltfm_priv(pltfm_priv);
-	mutex_init(&kona_dev->write_lock);
+	spin_lock_init(&kona_dev->write_lock);
 
 	mmc_of_parse(host->mmc);
 
-- 
1.9.0
