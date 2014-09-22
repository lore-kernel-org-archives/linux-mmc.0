From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 11/13] mmc: sdhci: Let a driver override timeout clock frequency
Date: Mon, 22 Sep 2014 13:17:42 +0300
Message-ID: <1411381064-1703-12-git-send-email-adrian.hunter@intel.com>
References: <1411381064-1703-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:45567 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751058AbaIVKTd (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 22 Sep 2014 06:19:33 -0400
In-Reply-To: <1411381064-1703-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <chris@printf.net>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

Let a driver override the timeout clock frequency by
populating it before calling sdhci_add_host().  Note
the value will otherwise be zero because sdhci_host is
zeroed when allocated.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index d20d104..8588550 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2790,6 +2790,7 @@ int sdhci_add_host(struct sdhci_host *host)
 	u32 caps[2] = {0, 0};
 	u32 max_current_caps;
 	unsigned int ocr_avail;
+	unsigned int override_timeout_clk;
 	int ret;
 
 	WARN_ON(host == NULL);
@@ -2803,6 +2804,8 @@ int sdhci_add_host(struct sdhci_host *host)
 	if (debug_quirks2)
 		host->quirks2 = debug_quirks2;
 
+	override_timeout_clk = host->timeout_clk;
+
 	sdhci_do_reset(host, SDHCI_RESET_ALL);
 
 	host->version = sdhci_readw(host, SDHCI_HOST_VERSION);
@@ -2971,6 +2974,9 @@ int sdhci_add_host(struct sdhci_host *host)
 		mmc->max_busy_timeout /= host->timeout_clk;
 	}
 
+	if (override_timeout_clk)
+		host->timeout_clk = override_timeout_clk;
+
 	mmc->caps |= MMC_CAP_SDIO_IRQ | MMC_CAP_ERASE | MMC_CAP_CMD23;
 	mmc->caps2 |= MMC_CAP2_SDIO_IRQ_NOTHREAD;
 
-- 
1.8.3.2

