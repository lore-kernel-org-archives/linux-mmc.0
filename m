From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH V2 1/4] mmc: sdhci: Allow override of mmc host operations
Date: Tue,  9 Feb 2016 16:12:35 +0200
Message-ID: <1455027158-21564-2-git-send-email-adrian.hunter@intel.com>
References: <1455027158-21564-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:45280 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757315AbcBIOQa (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 9 Feb 2016 09:16:30 -0500
In-Reply-To: <1455027158-21564-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Russell King <linux@arm.linux.org.uk>

In the past, fixes for specific hardware devices were implemented
in sdhci using quirks.  That approach is no longer accepted because
the growing number of quirks was starting to make the code difficult
to understand and maintain.

One alternative to quirks, is to allow drivers to override the default
mmc host operations.  This patch makes it easy to do that, and it is
needed for a subsequent bug fix, for which separate patches are
provided.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: stable@vger.kernel.org # v4.4+
---
 drivers/mmc/host/sdhci.c | 3 ++-
 drivers/mmc/host/sdhci.h | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index d622435d1bcc..9bfa66df963a 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2849,6 +2849,8 @@ struct sdhci_host *sdhci_alloc_host(struct device *dev,
 
 	host = mmc_priv(mmc);
 	host->mmc = mmc;
+	host->mmc_host_ops = sdhci_ops;
+	mmc->ops = &host->mmc_host_ops;
 
 	return host;
 }
@@ -3037,7 +3039,6 @@ int sdhci_add_host(struct sdhci_host *host)
 	/*
 	 * Set host parameters.
 	 */
-	mmc->ops = &sdhci_ops;
 	max_clk = host->max_clk;
 
 	if (host->ops->get_min_clock)
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 7654ae5d2b4e..0115e9907bf8 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -430,6 +430,7 @@ struct sdhci_host {
 
 	/* Internal data */
 	struct mmc_host *mmc;	/* MMC structure */
+	struct mmc_host_ops mmc_host_ops;	/* MMC host ops */
 	u64 dma_mask;		/* custom DMA mask */
 
 #if defined(CONFIG_LEDS_CLASS) || defined(CONFIG_LEDS_CLASS_MODULE)
-- 
1.9.1

