From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 3/9] mmc: sdhci: Stop exporting sdhci_enable_irq_wakeups()
Date: Wed, 20 Dec 2017 10:18:47 +0200
Message-ID: <1513757933-11232-4-git-send-email-adrian.hunter@intel.com>
References: <1513757933-11232-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:36192 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753760AbdLTITZ (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 20 Dec 2017 03:19:25 -0500
In-Reply-To: <1513757933-11232-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Haridhar Kalvala <haridhar.kalvala@intel.com>

Now that it is not being used by any drivers, stop exporting it.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci.c | 3 +--
 drivers/mmc/host/sdhci.h | 1 -
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index e9290a3439d5..8b2ccf7795ec 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2821,7 +2821,7 @@ static irqreturn_t sdhci_thread_irq(int irq, void *dev_id)
  * sdhci_disable_irq_wakeups() since it will be set by
  * sdhci_enable_card_detection() or sdhci_init().
  */
-void sdhci_enable_irq_wakeups(struct sdhci_host *host)
+static void sdhci_enable_irq_wakeups(struct sdhci_host *host)
 {
 	u8 val;
 	u8 mask = SDHCI_WAKE_ON_INSERT | SDHCI_WAKE_ON_REMOVE
@@ -2839,7 +2839,6 @@ void sdhci_enable_irq_wakeups(struct sdhci_host *host)
 	sdhci_writeb(host, val, SDHCI_WAKE_UP_CONTROL);
 	sdhci_writel(host, irq_val, SDHCI_INT_ENABLE);
 }
-EXPORT_SYMBOL_GPL(sdhci_enable_irq_wakeups);
 
 static void sdhci_disable_irq_wakeups(struct sdhci_host *host)
 {
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 54bc444c317f..7393b3a54772 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -718,7 +718,6 @@ int sdhci_start_signal_voltage_switch(struct mmc_host *mmc,
 #ifdef CONFIG_PM
 int sdhci_suspend_host(struct sdhci_host *host);
 int sdhci_resume_host(struct sdhci_host *host);
-void sdhci_enable_irq_wakeups(struct sdhci_host *host);
 int sdhci_runtime_suspend_host(struct sdhci_host *host);
 int sdhci_runtime_resume_host(struct sdhci_host *host);
 #endif
-- 
1.9.1

