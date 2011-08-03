From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH 3/4] mmc: sdhci: move timeout_clk calculation a bit further
Date: Wed,  3 Aug 2011 18:36:00 +0300
Message-ID: <35f6468fc367a9f1366ec35e713385a3a512fc8e.1312385378.git.andriy.shevchenko@linux.intel.com>
References: <cover.1312385378.git.andriy.shevchenko@linux.intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:45215 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753101Ab1HCPhJ (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 3 Aug 2011 11:37:09 -0400
In-Reply-To: <cover.1312385378.git.andriy.shevchenko@linux.intel.com>
In-Reply-To: <cover.1312385378.git.andriy.shevchenko@linux.intel.com>
References: <cover.1312385378.git.andriy.shevchenko@linux.intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

We will need the f_max for our calculations in the next patch in the series.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/mmc/host/sdhci.c |   38 +++++++++++++++++++-------------------
 1 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 58bb15c..4a7dd06 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2457,25 +2457,6 @@ int sdhci_add_host(struct sdhci_host *host)
 		host->max_clk = host->ops->get_max_clock(host);
 	}
 
-	host->timeout_clk =
-		(caps[0] & SDHCI_TIMEOUT_CLK_MASK) >> SDHCI_TIMEOUT_CLK_SHIFT;
-	if (host->timeout_clk == 0) {
-		if (host->ops->get_timeout_clock) {
-			host->timeout_clk = host->ops->get_timeout_clock(host);
-		} else if (!(host->quirks &
-				SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK)) {
-			printk(KERN_ERR
-			       "%s: Hardware doesn't specify timeout clock "
-			       "frequency.\n", mmc_hostname(mmc));
-			return -ENODEV;
-		}
-	}
-	if (caps[0] & SDHCI_TIMEOUT_CLK_UNIT)
-		host->timeout_clk *= 1000;
-
-	if (host->quirks & SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK)
-		host->timeout_clk = host->clock / 1000;
-
 	/*
 	 * In case of Host Controller v3.00, find out whether clock
 	 * multiplier is supported.
@@ -2508,6 +2489,25 @@ int sdhci_add_host(struct sdhci_host *host)
 	} else
 		mmc->f_min = host->max_clk / SDHCI_MAX_DIV_SPEC_200;
 
+	host->timeout_clk =
+		(caps[0] & SDHCI_TIMEOUT_CLK_MASK) >> SDHCI_TIMEOUT_CLK_SHIFT;
+	if (host->timeout_clk == 0) {
+		if (host->ops->get_timeout_clock) {
+			host->timeout_clk = host->ops->get_timeout_clock(host);
+		} else if (!(host->quirks &
+				SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK)) {
+			printk(KERN_ERR
+			       "%s: Hardware doesn't specify timeout clock "
+			       "frequency.\n", mmc_hostname(mmc));
+			return -ENODEV;
+		}
+	}
+	if (caps[0] & SDHCI_TIMEOUT_CLK_UNIT)
+		host->timeout_clk *= 1000;
+
+	if (host->quirks & SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK)
+		host->timeout_clk = host->clock / 1000;
+
 	if (host->quirks & SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK)
 		mmc->max_discard_to = (1 << 27) / (mmc->f_max / 1000);
 	else
-- 
1.7.5.4

