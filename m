From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 4/9] mmc: sdhci: Handle failure of enable_irq_wake()
Date: Wed, 20 Dec 2017 10:18:48 +0200
Message-ID: <1513757933-11232-5-git-send-email-adrian.hunter@intel.com>
References: <1513757933-11232-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:36192 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752128AbdLTIT0 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 20 Dec 2017 03:19:26 -0500
In-Reply-To: <1513757933-11232-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Haridhar Kalvala <haridhar.kalvala@intel.com>

Now that sdhci_enable_irq_wakeups() is a local function, change it to
return whether the IRQ wakeup was successfully enabled. This is in
preparation for adding more conditions for whether IRQ wakeup is enabled.

Note it is assumed, for SDHCI devices, that suspend is more important than
wakeup, so we continue to suspend regardless.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci.c | 24 +++++++++++++++---------
 drivers/mmc/host/sdhci.h |  1 +
 2 files changed, 16 insertions(+), 9 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 8b2ccf7795ec..a8129d091207 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2821,7 +2821,7 @@ static irqreturn_t sdhci_thread_irq(int irq, void *dev_id)
  * sdhci_disable_irq_wakeups() since it will be set by
  * sdhci_enable_card_detection() or sdhci_init().
  */
-static void sdhci_enable_irq_wakeups(struct sdhci_host *host)
+static bool sdhci_enable_irq_wakeups(struct sdhci_host *host)
 {
 	u8 val;
 	u8 mask = SDHCI_WAKE_ON_INSERT | SDHCI_WAKE_ON_REMOVE
@@ -2838,6 +2838,10 @@ static void sdhci_enable_irq_wakeups(struct sdhci_host *host)
 	}
 	sdhci_writeb(host, val, SDHCI_WAKE_UP_CONTROL);
 	sdhci_writel(host, irq_val, SDHCI_INT_ENABLE);
+
+	host->irq_wake_enabled = !enable_irq_wake(host->irq);
+
+	return host->irq_wake_enabled;
 }
 
 static void sdhci_disable_irq_wakeups(struct sdhci_host *host)
@@ -2849,6 +2853,10 @@ static void sdhci_disable_irq_wakeups(struct sdhci_host *host)
 	val = sdhci_readb(host, SDHCI_WAKE_UP_CONTROL);
 	val &= ~mask;
 	sdhci_writeb(host, val, SDHCI_WAKE_UP_CONTROL);
+
+	disable_irq_wake(host->irq);
+
+	host->irq_wake_enabled = false;
 }
 
 int sdhci_suspend_host(struct sdhci_host *host)
@@ -2857,15 +2865,14 @@ int sdhci_suspend_host(struct sdhci_host *host)
 
 	mmc_retune_timer_stop(host->mmc);
 
-	if (!device_may_wakeup(mmc_dev(host->mmc))) {
+	if (!device_may_wakeup(mmc_dev(host->mmc)) ||
+	    !sdhci_enable_irq_wakeups(host)) {
 		host->ier = 0;
 		sdhci_writel(host, 0, SDHCI_INT_ENABLE);
 		sdhci_writel(host, 0, SDHCI_SIGNAL_ENABLE);
 		free_irq(host->irq, host);
-	} else {
-		sdhci_enable_irq_wakeups(host);
-		enable_irq_wake(host->irq);
 	}
+
 	return 0;
 }
 
@@ -2893,15 +2900,14 @@ int sdhci_resume_host(struct sdhci_host *host)
 		mmiowb();
 	}
 
-	if (!device_may_wakeup(mmc_dev(host->mmc))) {
+	if (host->irq_wake_enabled) {
+		sdhci_disable_irq_wakeups(host);
+	} else {
 		ret = request_threaded_irq(host->irq, sdhci_irq,
 					   sdhci_thread_irq, IRQF_SHARED,
 					   mmc_hostname(host->mmc), host);
 		if (ret)
 			return ret;
-	} else {
-		sdhci_disable_irq_wakeups(host);
-		disable_irq_wake(host->irq);
 	}
 
 	sdhci_enable_card_detection(host);
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 7393b3a54772..afab26fd70e6 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -484,6 +484,7 @@ struct sdhci_host {
 	bool bus_on;		/* Bus power prevents runtime suspend */
 	bool preset_enabled;	/* Preset is enabled */
 	bool pending_reset;	/* Cmd/data reset is pending */
+	bool irq_wake_enabled;	/* IRQ wakeup is enabled */
 
 	struct mmc_request *mrqs_done[SDHCI_MAX_MRQS];	/* Requests done */
 	struct mmc_command *cmd;	/* Current command */
-- 
1.9.1

