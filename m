From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH] sdhci-s3c: fix incorrect spinlock usage after merge
Date: Mon, 20 Sep 2010 15:03:42 +0200
Message-ID: <1284987822-17955-1-git-send-email-m.szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: m.szyprowski@samsung.com, kyungmin.park@samsung.com, kgene.kim@samsung.com, ben-linux@fluff.org, akpm@linux-foundation.org, w.sang@pengutronix.de
List-Id: linux-mmc@vger.kernel.org

In the commit f522886e202a34a2191dd5d471b3c4d46410a9a0 a merge conflict
in the sdhci-s3c driver been fixed. However the fix used incorrect
spinlock operation - it cause a race with sdhci interrupt service. The
correct way to solve it is to use spin_lock_irqsave/irqrestore() calls.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/mmc/host/sdhci-s3c.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
index 71ad416..735d431 100644
--- a/drivers/mmc/host/sdhci-s3c.c
+++ b/drivers/mmc/host/sdhci-s3c.c
@@ -241,8 +241,10 @@ static struct sdhci_ops sdhci_s3c_ops = {
 static void sdhci_s3c_notify_change(struct platform_device *dev, int state)
 {
 	struct sdhci_host *host = platform_get_drvdata(dev);
+	unsigned long flags;
+
 	if (host) {
-		spin_lock(&host->lock);
+		spin_lock_irqsave(&host->lock, flags);
 		if (state) {
 			dev_dbg(&dev->dev, "card inserted.\n");
 			host->flags &= ~SDHCI_DEVICE_DEAD;
@@ -253,7 +255,7 @@ static void sdhci_s3c_notify_change(struct platform_device *dev, int state)
 			host->quirks &= ~SDHCI_QUIRK_BROKEN_CARD_DETECTION;
 		}
 		tasklet_schedule(&host->card_tasklet);
-		spin_unlock(&host->lock);
+		spin_unlock_irqrestore(&host->lock, flags);
 	}
 }
 
-- 
1.7.1.569.g6f426
