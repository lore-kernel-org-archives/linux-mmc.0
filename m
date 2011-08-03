From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH 4/4] mmc: sdhci: use f_max instead of host->clock for timeouts
Date: Wed,  3 Aug 2011 18:36:01 +0300
Message-ID: <942bc1c79e26fb6ff095b03f03e408ac1e9b0638.1312385378.git.andriy.shevchenko@linux.intel.com>
References: <cover.1312385378.git.andriy.shevchenko@linux.intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:9125 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753634Ab1HCPhY (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 3 Aug 2011 11:37:24 -0400
In-Reply-To: <cover.1312385378.git.andriy.shevchenko@linux.intel.com>
In-Reply-To: <cover.1312385378.git.andriy.shevchenko@linux.intel.com>
References: <cover.1312385378.git.andriy.shevchenko@linux.intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>

When timeout_clk is calculated the host->clock could be zero. So, instead of
host->clock the calculation uses mmc->f_max.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 drivers/mmc/host/sdhci.c |    7 ++-----
 1 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 4a7dd06..56619f4 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2506,12 +2506,9 @@ int sdhci_add_host(struct sdhci_host *host)
 		host->timeout_clk *= 1000;
 
 	if (host->quirks & SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK)
-		host->timeout_clk = host->clock / 1000;
+		host->timeout_clk = mmc->f_max / 1000;
 
-	if (host->quirks & SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK)
-		mmc->max_discard_to = (1 << 27) / (mmc->f_max / 1000);
-	else
-		mmc->max_discard_to = (1 << 27) / host->timeout_clk;
+	mmc->max_discard_to = (1 << 27) / host->timeout_clk;
 
 	mmc->caps |= MMC_CAP_SDIO_IRQ | MMC_CAP_ERASE | MMC_CAP_CMD23;
 
-- 
1.7.5.4

