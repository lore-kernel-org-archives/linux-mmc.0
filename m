From: Kevin Liu <kliu5@marvell.com>
Subject: [PATCH 1/2] mmc: sdhci: add pm runtime protection
Date: Thu, 20 Dec 2012 19:11:26 +0800
Message-ID: <1356001887-31793-1-git-send-email-kliu5@marvell.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog118.obsmtp.com ([74.125.149.244]:33844 "EHLO
	na3sys009aog118.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751775Ab2LTLMf (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 20 Dec 2012 06:12:35 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>
Cc: Philip Rakity <prakity@nvidia.com>, Aaron Lu <aaron.lu@amd.com>, Shawn Guo <shawn.guo@linaro.org>, Ulf Hansson <ulf.hansson@linaro.org>, Johan Rudholm <johan.rudholm@stericsson.com>, Daniel Drake <dsd@laptop.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Adrian Hunter <adrian.hunter@intel.com>, Jerry Huang <Chang-Ming.Huang@freescale.com>, Alexander Stein <alexander.stein@systec-electronic.com>, Girish K S <girish.shivananjappa@linaro.org>, Haijun Zhang <Haijun.Zhang@freescale.com>, Viresh Kumar <viresh.kumar@linaro.org>, Heiko Stuebner <heiko@sntech.de>, Thomas Abraham <thomas.abraham@linaro.org>, Chander Kashyap <chander.kashyap@linaro.com>, Jaehoon Chung <jh80.chung@samsung.com>, Sebastian Hesselbarth <sebastian.hesselbarth@googlemail.com>, Al Cooper <acooper@gmail.com>, Zhangfei Gao <zhangfei.gao@gmail.com>, Haojian Zhuang <haojian.zhuang@gmail.com>Cha

Added pm runtime protection for suspend/resume and add/remove functions.
When these functions called, pm runtime may have suspended.

Signed-off-by: Jialing Fu <jlfu@marvell.com>
Signed-off-by: Kevin Liu <kliu5@marvell.com>
---
 drivers/mmc/host/sdhci.c |   22 ++++++++++++++++++----
 1 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 6f0bfc0..ec7da59 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2460,6 +2460,7 @@ int sdhci_suspend_host(struct sdhci_host *host)
 {
 	int ret;
 
+	sdhci_runtime_pm_get(host);
 	if (host->ops->platform_suspend)
 		host->ops->platform_suspend(host);
 
@@ -2480,12 +2481,13 @@ int sdhci_suspend_host(struct sdhci_host *host)
 		}
 
 		sdhci_enable_card_detection(host);
-
+		sdhci_runtime_pm_put(host);
 		return ret;
 	}
 
 	free_irq(host->irq, host);
 
+	sdhci_runtime_pm_put(host);
 	return ret;
 }
 
@@ -2495,6 +2497,7 @@ int sdhci_resume_host(struct sdhci_host *host)
 {
 	int ret;
 
+	sdhci_runtime_pm_get(host);
 	if (host->flags & (SDHCI_USE_SDMA | SDHCI_USE_ADMA)) {
 		if (host->ops->enable_dma)
 			host->ops->enable_dma(host);
@@ -2502,8 +2505,10 @@ int sdhci_resume_host(struct sdhci_host *host)
 
 	ret = request_irq(host->irq, sdhci_irq, IRQF_SHARED,
 			  mmc_hostname(host->mmc), host);
-	if (ret)
+	if (ret) {
+		sdhci_runtime_pm_put(host);
 		return ret;
+	}
 
 	if ((host->mmc->pm_flags & MMC_PM_KEEP_POWER) &&
 	    (host->quirks2 & SDHCI_QUIRK2_HOST_OFF_CARD_ON)) {
@@ -2527,6 +2532,7 @@ int sdhci_resume_host(struct sdhci_host *host)
 	if (host->flags & SDHCI_USING_RETUNING_TIMER)
 		host->flags |= SDHCI_NEEDS_RETUNING;
 
+	sdhci_runtime_pm_put(host);
 	return ret;
 }
 
@@ -2664,6 +2670,7 @@ int sdhci_add_host(struct sdhci_host *host)
 	if (host == NULL)
 		return -EINVAL;
 
+	sdhci_runtime_pm_get(host);
 	mmc = host->mmc;
 
 	if (debug_quirks)
@@ -2766,6 +2773,7 @@ int sdhci_add_host(struct sdhci_host *host)
 		if (!host->ops->get_max_clock) {
 			pr_err("%s: Hardware doesn't specify base clock "
 			       "frequency.\n", mmc_hostname(mmc));
+			sdhci_runtime_pm_put(host);
 			return -ENODEV;
 		}
 		host->max_clk = host->ops->get_max_clock(host);
@@ -2812,6 +2820,7 @@ int sdhci_add_host(struct sdhci_host *host)
 				SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK)) {
 			pr_err("%s: Hardware doesn't specify timeout clock "
 			       "frequency.\n", mmc_hostname(mmc));
+			sdhci_runtime_pm_put(host);
 			return -ENODEV;
 		}
 	}
@@ -3015,6 +3024,7 @@ int sdhci_add_host(struct sdhci_host *host)
 	if (mmc->ocr_avail == 0) {
 		pr_err("%s: Hardware doesn't report any "
 			"support voltages.\n", mmc_hostname(mmc));
+		sdhci_runtime_pm_put(host);
 		return -ENODEV;
 	}
 
@@ -3133,7 +3143,7 @@ int sdhci_add_host(struct sdhci_host *host)
 		(host->flags & SDHCI_USE_SDMA) ? "DMA" : "PIO");
 
 	sdhci_enable_card_detection(host);
-
+	sdhci_runtime_pm_put(host);
 	return 0;
 
 #ifdef SDHCI_USE_LEDS_CLASS
@@ -3144,7 +3154,7 @@ reset:
 untasklet:
 	tasklet_kill(&host->card_tasklet);
 	tasklet_kill(&host->finish_tasklet);
-
+	sdhci_runtime_pm_put(host);
 	return ret;
 }
 
@@ -3154,6 +3164,8 @@ void sdhci_remove_host(struct sdhci_host *host, int dead)
 {
 	unsigned long flags;
 
+	sdhci_runtime_pm_get(host);
+
 	if (dead) {
 		spin_lock_irqsave(&host->lock, flags);
 
@@ -3203,6 +3215,8 @@ void sdhci_remove_host(struct sdhci_host *host, int dead)
 
 	host->adma_desc = NULL;
 	host->align_buffer = NULL;
+
+	sdhci_runtime_pm_put(host);
 }
 
 EXPORT_SYMBOL_GPL(sdhci_remove_host);
-- 
1.7.0.4

