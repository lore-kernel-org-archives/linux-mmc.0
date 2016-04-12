From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 4/5] mmc: sdhci: Fix error paths in sdhci_add_host()
Date: Tue, 12 Apr 2016 14:25:08 +0300
Message-ID: <1460460309-13619-5-git-send-email-adrian.hunter@intel.com>
References: <1460460309-13619-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:9541 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932393AbcDLL3J (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 12 Apr 2016 07:29:09 -0400
In-Reply-To: <1460460309-13619-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

Some error paths in sdhci_add_host() simply returned without
cleaning up.  Also the return value from mmc_add_host()
was not being checked.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci.c | 36 +++++++++++++++++++++++++++---------
 1 file changed, 27 insertions(+), 9 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 3e221e9a7b52..be5b5c95138c 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2955,7 +2955,8 @@ int sdhci_add_host(struct sdhci_host *host)
 		if (!host->ops->get_max_clock) {
 			pr_err("%s: Hardware doesn't specify base clock frequency.\n",
 			       mmc_hostname(mmc));
-			return -ENODEV;
+			ret = -ENODEV;
+			goto undma;
 		}
 		host->max_clk = host->ops->get_max_clock(host);
 	}
@@ -3005,7 +3006,8 @@ int sdhci_add_host(struct sdhci_host *host)
 			} else {
 				pr_err("%s: Hardware doesn't specify timeout clock frequency.\n",
 					mmc_hostname(mmc));
-				return -ENODEV;
+				ret = -ENODEV;
+				goto undma;
 			}
 		}
 
@@ -3059,8 +3061,9 @@ int sdhci_add_host(struct sdhci_host *host)
 		mmc->caps |= MMC_CAP_NEEDS_POLL;
 
 	/* If there are external regulators, get them */
-	if (mmc_regulator_get_supply(mmc) == -EPROBE_DEFER)
-		return -EPROBE_DEFER;
+	ret = mmc_regulator_get_supply(mmc);
+	if (ret == -EPROBE_DEFER)
+		goto undma;
 
 	/* If vqmmc regulator and no 1.8V signalling, then there's no UHS */
 	if (!IS_ERR(mmc->supply.vqmmc)) {
@@ -3217,7 +3220,8 @@ int sdhci_add_host(struct sdhci_host *host)
 	if (mmc->ocr_avail == 0) {
 		pr_err("%s: Hardware doesn't report any support voltages.\n",
 		       mmc_hostname(mmc));
-		return -ENODEV;
+		ret = -ENODEV;
+		goto unreg;
 	}
 
 	spin_lock_init(&host->lock);
@@ -3313,13 +3317,15 @@ int sdhci_add_host(struct sdhci_host *host)
 	if (ret) {
 		pr_err("%s: Failed to register LED device: %d\n",
 		       mmc_hostname(mmc), ret);
-		goto reset;
+		goto unirq;
 	}
 #endif
 
 	mmiowb();
 
-	mmc_add_host(mmc);
+	ret = mmc_add_host(mmc);
+	if (ret)
+		goto unled;
 
 	pr_info("%s: SDHCI controller on %s [%s] using %s\n",
 		mmc_hostname(mmc), host->hw_name, dev_name(mmc_dev(mmc)),
@@ -3331,15 +3337,27 @@ int sdhci_add_host(struct sdhci_host *host)
 
 	return 0;
 
+unled:
 #ifdef SDHCI_USE_LEDS_CLASS
-reset:
+	led_classdev_unregister(&host->led);
+unirq:
+#endif
 	sdhci_do_reset(host, SDHCI_RESET_ALL);
 	sdhci_writel(host, 0, SDHCI_INT_ENABLE);
 	sdhci_writel(host, 0, SDHCI_SIGNAL_ENABLE);
 	free_irq(host->irq, host);
-#endif
 untasklet:
 	tasklet_kill(&host->finish_tasklet);
+unreg:
+	if (!IS_ERR(mmc->supply.vqmmc))
+		regulator_disable(mmc->supply.vqmmc);
+undma:
+	if (host->align_buffer)
+		dma_free_coherent(mmc_dev(mmc), host->align_buffer_sz +
+				  host->adma_table_sz, host->align_buffer,
+				  host->align_addr);
+	host->adma_table = NULL;
+	host->align_buffer = NULL;
 
 	return ret;
 }
-- 
1.9.1

