From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH 1/4] Revert "mmc: sdhci: Fix SDHCI_QUIRK_TIMEOUT_USES_SDCLK"
Date: Wed,  3 Aug 2011 18:35:58 +0300
Message-ID: <ea979210cfeb01092be834debe22f473cd00ea19.1312385378.git.andriy.shevchenko@linux.intel.com>
References: <cover.1312385378.git.andriy.shevchenko@linux.intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:17967 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753021Ab1HCPgm (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 3 Aug 2011 11:36:42 -0400
In-Reply-To: <cover.1312385378.git.andriy.shevchenko@linux.intel.com>
In-Reply-To: <cover.1312385378.git.andriy.shevchenko@linux.intel.com>
References: <cover.1312385378.git.andriy.shevchenko@linux.intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

This reverts commit 4b01681c77642c62a833187066c35e71e59caaf5.
---
 drivers/mmc/host/sdhci.c |    7 +++----
 1 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 51c3b3f..aef7982 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -633,9 +633,6 @@ static u8 sdhci_calc_timeout(struct sdhci_host *host, struct mmc_command *cmd)
 		target_timeout = data->timeout_ns / 1000 +
 			data->timeout_clks / host->clock;
 
-	if (host->quirks & SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK)
-		host->timeout_clk = host->clock / 1000;
-
 	/*
 	 * Figure out needed cycles.
 	 * We do this in steps in order to fit inside a 32 bit int.
@@ -646,7 +643,6 @@ static u8 sdhci_calc_timeout(struct sdhci_host *host, struct mmc_command *cmd)
 	 *     =>
 	 *     (1) / (2) > 2^6
 	 */
-	BUG_ON(!host->timeout_clk);
 	count = 0;
 	current_timeout = (1 << 13) * 1000 / host->timeout_clk;
 	while (current_timeout < target_timeout) {
@@ -2475,6 +2471,9 @@ int sdhci_add_host(struct sdhci_host *host)
 	if (caps[0] & SDHCI_TIMEOUT_CLK_UNIT)
 		host->timeout_clk *= 1000;
 
+	if (host->quirks & SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK)
+		host->timeout_clk = host->clock / 1000;
+
 	/*
 	 * In case of Host Controller v3.00, find out whether clock
 	 * multiplier is supported.
-- 
1.7.5.4

