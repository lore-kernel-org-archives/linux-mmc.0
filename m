From: Jeremie Samuel <jeremie.samuel.ext@parrot.com>
Subject: [PATCH 4/8] sdhci: Use threaded IRQ handler
Date: Tue, 9 Jul 2013 17:44:08 +0200
Message-ID: <1373384652-21958-5-git-send-email-jeremie.samuel.ext@parrot.com>
References: <1373384652-21958-1-git-send-email-jeremie.samuel.ext@parrot.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from co202.xi-lite.net ([149.6.83.202]:45921 "EHLO co202.xi-lite.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751653Ab3GIPop (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 9 Jul 2013 11:44:45 -0400
In-Reply-To: <1373384652-21958-1-git-send-email-jeremie.samuel.ext@parrot.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, matthieu.castet@parrot.com, gregor.boirie@parrot.com, Jeremie Samuel <jeremie.samuel.ext@parrot.com>, Anton Vorontsov <avorontsov@mvista.com>

We only need atomic context to disable SDHCI interrupts, after that
we can run in a kernel thread.

Note that irq handler still grabs an irqsave spinlock, we'll deal
with it in a subsequent patch.

Patch based on: http://thread.gmane.org/gmane.linux.kernel.mmc/2579.

Signed-off-by: Anton Vorontsov <avorontsov@mvista.com>
Signed-off-by: Jeremie Samuel <jeremie.samuel.ext@parrot.com>
---
 drivers/mmc/host/sdhci.c |   46 ++++++++++++++++++++++++++++------------------
 1 file changed, 28 insertions(+), 18 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index ab635d5..21ef1e0 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2405,9 +2405,8 @@ static void sdhci_data_irq(struct sdhci_host *host, u32 intmask)
 	}
 }
 
-static irqreturn_t sdhci_irq(int irq, void *dev_id)
+static irqreturn_t sdhci_irq_thread(int irq, void *dev_id)
 {
-	irqreturn_t result;
 	struct sdhci_host *host = dev_id;
 	u32 intmask, unexpected = 0;
 	int cardint = 0, max_loops = 16;
@@ -2423,15 +2422,7 @@ static irqreturn_t sdhci_irq(int irq, void *dev_id)
 
 	intmask = sdhci_readl(host, SDHCI_INT_STATUS);
 
-	if (!intmask || intmask == 0xffffffff) {
-		result = IRQ_NONE;
-		goto out;
-	}
-
 again:
-	DBG("*** %s got interrupt: 0x%08x\n",
-		mmc_hostname(host->mmc), intmask);
-
 	if (intmask & (SDHCI_INT_CARD_INSERT | SDHCI_INT_CARD_REMOVE)) {
 		u32 present = sdhci_readl(host, SDHCI_PRESENT_STATE) &
 			      SDHCI_CARD_PRESENT;
@@ -2491,12 +2482,10 @@ again:
 		sdhci_writel(host, intmask, SDHCI_INT_STATUS);
 	}
 
-	result = IRQ_HANDLED;
-
 	intmask = sdhci_readl(host, SDHCI_INT_STATUS);
 	if (intmask && --max_loops)
 		goto again;
-out:
+
 	spin_unlock(&host->lock);
 
 	if (unexpected) {
@@ -2510,7 +2499,27 @@ out:
 	if (cardint)
 		mmc_signal_sdio_irq(host->mmc);
 
-	return result;
+	intmask = sdhci_readl(host, SDHCI_INT_ENABLE);
+	sdhci_writel(host, intmask, SDHCI_SIGNAL_ENABLE);
+
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t sdhci_irq(int irq, void *dev_id)
+{
+	struct sdhci_host *host = dev_id;
+	u32 intmask = sdhci_readl(host, SDHCI_INT_STATUS);
+
+	if (!intmask || intmask == 0xffffffff)
+		return IRQ_NONE;
+
+	/* Disable interrupts */
+	sdhci_writel(host, 0, SDHCI_SIGNAL_ENABLE);
+
+	DBG("*** %s got interrupt: 0x%08x\n",
+		mmc_hostname(host->mmc), intmask);
+
+	return IRQ_WAKE_THREAD;
 }
 
 /*****************************************************************************\
@@ -2597,8 +2606,9 @@ int sdhci_resume_host(struct sdhci_host *host)
 	}
 
 	if (!device_may_wakeup(mmc_dev(host->mmc))) {
-		ret = request_irq(host->irq, sdhci_irq, IRQF_SHARED,
-				  mmc_hostname(host->mmc), host);
+		ret = request_threaded_irq(host->irq, sdhci_irq,
+			sdhci_irq_thread, IRQF_SHARED,
+			mmc_hostname(host->mmc), host);
 		if (ret)
 			return ret;
 	} else {
@@ -3213,8 +3223,8 @@ int sdhci_add_host(struct sdhci_host *host)
 					sdhci_tuning_timeout_work);
 	}
 
-	ret = request_irq(host->irq, sdhci_irq, IRQF_SHARED,
-		mmc_hostname(mmc), host);
+	ret = request_threaded_irq(host->irq, sdhci_irq, sdhci_irq_thread,
+			  IRQF_SHARED, mmc_hostname(host->mmc), host);
 	if (ret) {
 		pr_err("%s: Failed to request IRQ %d: %d\n",
 		       mmc_hostname(mmc), host->irq, ret);
-- 
1.7.10.4

