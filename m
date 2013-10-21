From: Jeremie Samuel <jeremie.samuel.ext@parrot.com>
Subject: [PATCH v2 4/8] sdhci: Use threaded IRQ handler
Date: Mon, 21 Oct 2013 17:25:53 +0200
Message-ID: <1382369157-16129-5-git-send-email-jeremie.samuel.ext@parrot.com>
References: <1382369157-16129-1-git-send-email-jeremie.samuel.ext@parrot.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from co202.xi-lite.net ([149.6.83.202]:36391 "EHLO co202.xi-lite.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753745Ab3JUP11 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 21 Oct 2013 11:27:27 -0400
In-Reply-To: <1382369157-16129-1-git-send-email-jeremie.samuel.ext@parrot.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, =?UTF-8?q?Gr=C3=A9gor=20Boirie?= <gregor.boirie@parrot.com>, Matthieu Castet <matthieu.castet@parrot.com>, Jeremie Samuel <jeremie.samuel.ext@parrot.com>, Anton Vorontsov <avorontsov@mvista.com>

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
index 362a838..0bb892c 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2413,9 +2413,8 @@ static void sdhci_data_irq(struct sdhci_host *host, u32 intmask)
 	}
 }
 
-static irqreturn_t sdhci_irq(int irq, void *dev_id)
+static irqreturn_t sdhci_irq_thread(int irq, void *dev_id)
 {
-	irqreturn_t result;
 	struct sdhci_host *host = dev_id;
 	u32 intmask, unexpected = 0;
 	int cardint = 0, max_loops = 16;
@@ -2431,15 +2430,7 @@ static irqreturn_t sdhci_irq(int irq, void *dev_id)
 
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
@@ -2499,12 +2490,10 @@ again:
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
@@ -2518,7 +2507,27 @@ out:
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
@@ -2605,8 +2614,9 @@ int sdhci_resume_host(struct sdhci_host *host)
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
@@ -3226,8 +3236,8 @@ int sdhci_add_host(struct sdhci_host *host)
 
 	sdhci_init(host, 0);
 
-	ret = request_irq(host->irq, sdhci_irq, IRQF_SHARED,
-		mmc_hostname(mmc), host);
+	ret = request_threaded_irq(host->irq, sdhci_irq, sdhci_irq_thread,
+			  IRQF_SHARED, mmc_hostname(host->mmc), host);
 	if (ret) {
 		pr_err("%s: Failed to request IRQ %d: %d\n",
 		       mmc_hostname(mmc), host->irq, ret);
-- 
1.7.10.4

