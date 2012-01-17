From: Ulf Hansson <ulf.hansson@stericsson.com>
Subject: [PATCH 4/8] mmc: mmci: Use ios_handler to save power
Date: Tue, 17 Jan 2012 15:34:23 +0100
Message-ID: <1326810867-5346-5-git-send-email-ulf.hansson@stericsson.com>
References: <1326810867-5346-1-git-send-email-ulf.hansson@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog104.obsmtp.com ([207.126.144.117]:35091 "EHLO
	eu1sys200aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754199Ab2AQOe5 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 17 Jan 2012 09:34:57 -0500
In-Reply-To: <1326810867-5346-1-git-send-email-ulf.hansson@stericsson.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Russell King <linux@arm.linux.org.uk>, Ulf Hansson <ulf.hansson@stericsson.com>, Lee Jones <lee.jones@linaro.org>, Per Forlin <per.forlin@stericsson.com>, Johan Rudholm <johan.rudholm@stericsson.com>, Linus Walleij <linus.walleij@linaro.org>

To disable a levelshifter when we are in an idle state will
decrease current consumption. We make use of the ios_handler
at runtime suspend and at regular suspend to accomplish this.

Of course depending on the used levelshifter the decrease of
current differs. For ST6G3244ME the value is up to ~200 uA.

Tested-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Ulf Hansson <ulf.hansson@stericsson.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/mmc/host/mmci.c |   19 ++++++++++++++++++-
 1 files changed, 18 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index a7c8f8f..76ce2cd 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -1505,10 +1505,22 @@ static int mmci_save(struct amba_device *dev)
 {
 	struct mmc_host *mmc = amba_get_drvdata(dev);
 	unsigned long flags;
+	struct mmc_ios ios;
+	int ret = 0;
 
 	if (mmc) {
 		struct mmci_host *host = mmc_priv(mmc);
 
+		/* Let the ios_handler act on a POWER_OFF to save power. */
+		if (host->plat->ios_handler) {
+			memcpy(&ios, &mmc->ios, sizeof(struct mmc_ios));
+			ios.power_mode = MMC_POWER_OFF;
+			ret = host->plat->ios_handler(mmc_dev(mmc),
+						      &ios);
+			if (ret)
+				return ret;
+		}
+
 		spin_lock_irqsave(&host->lock, flags);
 
 		/*
@@ -1527,7 +1539,7 @@ static int mmci_save(struct amba_device *dev)
 		amba_vcore_disable(dev);
 	}
 
-	return 0;
+	return ret;
 }
 
 static int mmci_restore(struct amba_device *dev)
@@ -1550,6 +1562,11 @@ static int mmci_restore(struct amba_device *dev)
 		writel(MCI_IRQENABLE, host->base + MMCIMASK0);
 
 		spin_unlock_irqrestore(&host->lock, flags);
+
+		/* Restore settings done by the ios_handler. */
+		if (host->plat->ios_handler)
+			host->plat->ios_handler(mmc_dev(mmc),
+						&mmc->ios);
 	}
 
 	return 0;
-- 
1.7.5.4

