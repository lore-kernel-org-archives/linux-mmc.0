From: Kyungmin Park <kmpark@infradead.org>
Subject: [PATCH] Samsung: MMC: Use the correct mutex and card detect	function
Date: Tue, 17 Aug 2010 13:08:24 +0900
Message-ID: <20100817040824.GA8376@july>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:64386 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750786Ab0HQEIb (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 17 Aug 2010 00:08:31 -0400
Received: from epmmp2 (mailout2.samsung.com [203.254.224.25])
 by mailout2.samsung.com
 (Sun Java(tm) System Messaging Server 7u3-15.01 64bit (built Feb 12 2010))
 with ESMTP id <0L7A002NR3I6L000@mailout2.samsung.com> for
 linux-mmc@vger.kernel.org; Tue, 17 Aug 2010 13:08:30 +0900 (KST)
Received: from TNRNDGASPAPP1.tn.corp.samsungelectronics.net ([165.213.149.150])
 by mmp2.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTPA id <0L7A00JST3I67K@mmp2.samsung.com> for
 linux-mmc@vger.kernel.org; Tue, 17 Aug 2010 13:08:30 +0900 (KST)
Content-disposition: inline
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, akpm@linux-foundation.org

From: Kyungmin Park <kyungmin.park@samsung.com>

There's some merge problem between sdhic core and sdhci-s3c host.
After mutex is changed to spinlock. it needs to use use spin lock functions
and use the correct card detection function.

Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
index 0a7f261..71ad416 100644
--- a/drivers/mmc/host/sdhci-s3c.c
+++ b/drivers/mmc/host/sdhci-s3c.c
@@ -242,7 +242,7 @@ static void sdhci_s3c_notify_change(struct platform_device *dev, int state)
 {
 	struct sdhci_host *host = platform_get_drvdata(dev);
 	if (host) {
-		mutex_lock(&host->lock);
+		spin_lock(&host->lock);
 		if (state) {
 			dev_dbg(&dev->dev, "card inserted.\n");
 			host->flags &= ~SDHCI_DEVICE_DEAD;
@@ -252,8 +252,8 @@ static void sdhci_s3c_notify_change(struct platform_device *dev, int state)
 			host->flags |= SDHCI_DEVICE_DEAD;
 			host->quirks &= ~SDHCI_QUIRK_BROKEN_CARD_DETECTION;
 		}
-		sdhci_card_detect(host);
-		mutex_unlock(&host->lock);
+		tasklet_schedule(&host->card_tasklet);
+		spin_unlock(&host->lock);
 	}
 }
 
