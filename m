From: Haibo Chen <haibo.chen@freescale.com>
Subject: [PATCH] mmc: sdhci: call sdhci_init() before request irq
Date: Tue, 15 Sep 2015 18:32:58 +0800
Message-ID: <1442313178-31705-1-git-send-email-haibo.chen@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc: ivan.ivanov@linaro.org, sbranden@broadcom.com, vincent.yang.fujitsu@gmail.com, haibo.chen@freescale.com, andrew_gabbasov@mentor.com, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

sdhci_init() will clear all irqs and set the needed irqs. So
logically sdhci_init() should be called before request irq.

If not, some irqs may be triggled and handled wrongly. Take
the following into consideration, after request irq, if
SDIO card interrupt enabled, a sd card in the sd slot will
trigger a mass of interrupt(SDHCI_INT_CARD_INT), because at
this time, the vmmc-regulator still not restore, no voltage
supply for the sd card, so the pin of data0~data3 change and
keep low, interrupt(SDHCI_INT_CARD_INT) will rise up ceaselessly.
Due to we already reguest irq, system will be busy in handling
this endless irq, can't response to other event.

So we should call sdhci_init() before request irq in sd resume.

Signed-off-by: Haibo Chen <haibo.chen@freescale.com>
---
 drivers/mmc/host/sdhci.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 64b7fdb..6861573 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2714,17 +2714,6 @@ int sdhci_resume_host(struct sdhci_host *host)
 			host->ops->enable_dma(host);
 	}
 
-	if (!device_may_wakeup(mmc_dev(host->mmc))) {
-		ret = request_threaded_irq(host->irq, sdhci_irq,
-					   sdhci_thread_irq, IRQF_SHARED,
-					   mmc_hostname(host->mmc), host);
-		if (ret)
-			return ret;
-	} else {
-		sdhci_disable_irq_wakeups(host);
-		disable_irq_wake(host->irq);
-	}
-
 	if ((host->mmc->pm_flags & MMC_PM_KEEP_POWER) &&
 	    (host->quirks2 & SDHCI_QUIRK2_HOST_OFF_CARD_ON)) {
 		/* Card keeps power but host controller does not */
@@ -2737,6 +2726,17 @@ int sdhci_resume_host(struct sdhci_host *host)
 		mmiowb();
 	}
 
+	if (!device_may_wakeup(mmc_dev(host->mmc))) {
+		ret = request_threaded_irq(host->irq, sdhci_irq,
+					   sdhci_thread_irq, IRQF_SHARED,
+					   mmc_hostname(host->mmc), host);
+		if (ret)
+			return ret;
+	} else {
+		sdhci_disable_irq_wakeups(host);
+		disable_irq_wake(host->irq);
+	}
+
 	sdhci_enable_card_detection(host);
 
 	return ret;
-- 
1.9.1
