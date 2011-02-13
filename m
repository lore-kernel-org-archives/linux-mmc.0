From: Philip Rakity <prakity@marvell.com>
Subject: [RFC}  sdhci.c set_ios -- disable global interrupts and Question on
 Power Management
Date: Sat, 12 Feb 2011 21:39:20 -0800
Message-ID: <7953F5A4-7BFA-4E40-8202-C682C0314F49@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:42791 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750816Ab1BMFjY convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sun, 13 Feb 2011 00:39:24 -0500
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Pierre Tardy <tardyp@gmail.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>


Pierre,

I am preparing a patch to just diable to interrupt line to the SD controller so global interrupts are not locked out.  This
will allow mdelay to work correctly in the routines the set_ios() calls.

The pm_ calls  remove the lock before being called and restore it afterwards.  Is this just to ensure interrupts are globally
enabled ?  If so, I can simplify my patch deleting the original spin_lock calls that surround the pm_ calls.

Philip


>From 782c474f1abe992a203ad76594db025414332e67 Mon Sep 17 00:00:00 2001
From: Philip Rakity <prakity@marvell.com>
Date: Tue, 25 Jan 2011 16:04:42 -0800
Subject: [PATCH 1/2] sdhci: sdhci.c: Do not disable global interrupts while waiting in set_ios

holding the spin_lock with all interrupts disabled
is not good form when doing mdelay.
set_ios calls routines that need to delay for power to
stabalize or for chip issues when quirks are defined.

disable only our interupt and spin_lock on the chip
instead of spin_lock with all interrupts disabled.

Signed-off-by: Philip Rakity <prakity@marvell.com>
Signed-off-by: Mark F. Brown <markb@marvell.com>
---
 drivers/mmc/host/sdhci.c |   15 ++++++++-------
 1 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 655617c..1a88303 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1161,13 +1161,13 @@ static void sdhci_request(struct mmc_host *mmc, struct mmc_request *mrq)
 static void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 {
 	struct sdhci_host *host;
-	unsigned long flags;
 	unsigned int lastclock;
 	u8 ctrl;
 
 	host = mmc_priv(mmc);
 
-	spin_lock_irqsave(&host->lock, flags);
+	disable_irq(host->irq);
+	spin_lock(&host->lock);
 
 	if (host->flags & SDHCI_DEVICE_DEAD)
 		goto out;
@@ -1180,14 +1180,14 @@ static void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 	lastclock = host->iosclock;
 	host->iosclock = ios->clock;
 	if (lastclock == 0 && ios->clock != 0) {
-		spin_unlock_irqrestore(&host->lock, flags);
+		spin_unlock(&host->lock);
 		pm_runtime_get_sync(host->mmc->parent);
-		spin_lock_irqsave(&host->lock, flags);
+		spin_lock(&host->lock);
 	} else if (lastclock != 0 && ios->clock == 0) {
-		spin_unlock_irqrestore(&host->lock, flags);
+		spin_unlock(&host->lock);
 		pm_runtime_mark_last_busy(host->mmc->parent);
 		pm_runtime_put_autosuspend(host->mmc->parent);
-		spin_lock_irqsave(&host->lock, flags);
+		spin_lock(&host->lock);
 	}
 	/* no need to configure the rest.. */
 	if (host->iosclock == 0)
@@ -1257,7 +1257,8 @@ static void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 
 out:
 	mmiowb();
-	spin_unlock_irqrestore(&host->lock, flags);
+	spin_unlock(&host->lock);
+	enable_irq(host->irq);
 }
 
 static int sdhci_get_ro(struct mmc_host *mmc)
-- 
1.7.0.4


