From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 6/7] mmc: sdhci: Let a driver override timeout clock frequency
Date: Wed, 24 Sep 2014 10:27:32 +0300
Message-ID: <1411543653-3728-7-git-send-email-adrian.hunter@intel.com>
References: <1411543653-3728-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:49240 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752157AbaIXHiM (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 24 Sep 2014 03:38:12 -0400
In-Reply-To: <1411543653-3728-1-git-send-email-adrian.hunter@intel.com>
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
index abad5e5..6ada726 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2791,6 +2791,7 @@ int sdhci_add_host(struct sdhci_host *host)
 	u32 caps[2] = {0, 0};
 	u32 max_current_caps;
 	unsigned int ocr_avail;
+	unsigned int override_timeout_clk;
 	int ret;
 
 	WARN_ON(host == NULL);
@@ -2804,6 +2805,8 @@ int sdhci_add_host(struct sdhci_host *host)
 	if (debug_quirks2)
 		host->quirks2 = debug_quirks2;
 
+	override_timeout_clk = host->timeout_clk;
+
 	sdhci_do_reset(host, SDHCI_RESET_ALL);
 
 	host->version = sdhci_readw(host, SDHCI_HOST_VERSION);
@@ -2972,6 +2975,9 @@ int sdhci_add_host(struct sdhci_host *host)
 		mmc->max_busy_timeout /= host->timeout_clk;
 	}
 
+	if (override_timeout_clk)
+		host->timeout_clk = override_timeout_clk;
+
 	mmc->caps |= MMC_CAP_SDIO_IRQ | MMC_CAP_ERASE | MMC_CAP_CMD23;
 	mmc->caps2 |= MMC_CAP2_SDIO_IRQ_NOTHREAD;
 
-- 
1.8.3.2

