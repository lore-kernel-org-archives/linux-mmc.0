From: Ulf Hansson <ulf.hansson@stericsson.com>
Subject: [PATCH 11/14] mmc: mmci: Fixup use of runtime PM and use autosuspend
Date: Mon, 5 Dec 2011 18:35:57 +0100
Message-ID: <1323106560-5218-12-git-send-email-ulf.hansson@stericsson.com>
References: <1323106560-5218-1-git-send-email-ulf.hansson@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog106.obsmtp.com ([207.126.144.121]:49727 "EHLO
	eu1sys200aog106.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932613Ab1LERgq (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 5 Dec 2011 12:36:46 -0500
In-Reply-To: <1323106560-5218-1-git-send-email-ulf.hansson@stericsson.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Russell King <linux@arm.linux.org.uk>, Ulf Hansson <ulf.hansson@stericsson.com>, Lee Jones <lee.jones@linaro.org>

Added use of runtime PM autosuspend feature, with a fixed
timeout of 50 ms. This will prevent adding a latency,
although very minor, for _every_ request.

Moreover the runtime_get_sync is now also used in set_ios and
suspend since the runtime resourses are needed here as well.

Signed-off-by: Ulf Hansson <ulf.hansson@stericsson.com>
---
 drivers/mmc/host/mmci.c |   19 ++++++++++++++++---
 1 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 45e794a..8971157 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -200,8 +200,10 @@ mmci_request_end(struct mmci_host *host, struct mmc_request *mrq)
 	host->mrq = NULL;
 	host->cmd = NULL;
 
-	pm_runtime_put(mmc_dev(host->mmc));
 	mmc_request_done(host->mmc, mrq);
+
+	pm_runtime_mark_last_busy(mmc_dev(host->mmc));
+	pm_runtime_put_autosuspend(mmc_dev(host->mmc));
 }
 
 static void mmci_set_mask1(struct mmci_host *host, unsigned int mask)
@@ -1044,6 +1046,8 @@ static void mmci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 	unsigned long flags;
 	int ret;
 
+	pm_runtime_get_sync(mmc_dev(mmc));
+
 	if (host->plat->ios_handler &&
 		host->plat->ios_handler(mmc_dev(mmc), ios))
 			dev_err(mmc_dev(mmc), "platform ios_handler failed\n");
@@ -1064,7 +1068,7 @@ static void mmci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 				 * power should be rare so we print an error
 				 * and return here.
 				 */
-				return;
+				goto out;
 			}
 		}
 		/*
@@ -1114,6 +1118,10 @@ static void mmci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 	mmci_write_pwrreg(host, pwr);
 
 	spin_unlock_irqrestore(&host->lock, flags);
+
+ out:
+	pm_runtime_mark_last_busy(mmc_dev(mmc));
+	pm_runtime_put_autosuspend(mmc_dev(mmc));
 }
 
 static int mmci_get_ro(struct mmc_host *mmc)
@@ -1388,6 +1396,8 @@ static int __devinit mmci_probe(struct amba_device *dev,
 
 	mmci_dma_setup(host);
 
+	pm_runtime_set_autosuspend_delay(&dev->dev, 50);
+	pm_runtime_use_autosuspend(&dev->dev);
 	pm_runtime_put(&dev->dev);
 
 	mmc_add_host(mmc);
@@ -1483,8 +1493,10 @@ static int mmci_suspend(struct device *dev)
 		struct mmci_host *host = mmc_priv(mmc);
 
 		ret = mmc_suspend_host(mmc);
-		if (ret == 0)
+		if (ret == 0) {
+			pm_runtime_get_sync(dev);
 			writel(0, host->base + MMCIMASK0);
+		}
 	}
 
 	return ret;
@@ -1500,6 +1512,7 @@ static int mmci_resume(struct device *dev)
 		struct mmci_host *host = mmc_priv(mmc);
 
 		writel(MCI_IRQENABLE, host->base + MMCIMASK0);
+		pm_runtime_put(dev);
 
 		ret = mmc_resume_host(mmc);
 	}
-- 
1.7.5.4

