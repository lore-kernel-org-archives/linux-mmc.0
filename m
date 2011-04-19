From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] mmc: sdhci: Fix SDHCI_QUIRK_TIMEOUT_USES_SDCLK
Date: Tue, 19 Apr 2011 18:44:17 +0100
Message-ID: <1303235057-4745-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:43874 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752378Ab1DSRp5 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 19 Apr 2011 13:45:57 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>, Andrei Warkentin <andreiw@motorola.com>, patches@opensource.wolfsonmicro.com
Cc: linux-mmc@vger.kernel.org, Mark Brown <broonie@opensource.wolfsonmicro.com>

Commit 373e6a (mmc: sdhci: R1B command handling + MMC_CAP_ERASE) moved the
handling of SDHCI_QUIRK_TIMEOUT_USES_SDCLK from sdhci_calc_timeout() to
sdhci_add_host(). This causes division by zero errors on at least the S3C
SDHCI controller as the quirk implementation needs host->clock set to work
but host->clock has not been set when sdhci_add_host() is called.

Fix this by backing out that portion of the change, the clock may vary at
runtime anyway. It does occur to me that we may want to move the quirk to
where we set the clock but this seems more invasive and I'm concerned
about undesirable side effects.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 drivers/mmc/host/sdhci.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index f79dead..da57bdb 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -616,6 +616,9 @@ static u8 sdhci_calc_timeout(struct sdhci_host *host, struct mmc_command *cmd)
 		target_timeout = data->timeout_ns / 1000 +
 			data->timeout_clks / host->clock;
 
+	if (host->quirks & SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK)
+		host->timeout_clk = host->clock / 1000;
+
 	/*
 	 * Figure out needed cycles.
 	 * We do this in steps in order to fit inside a 32 bit int.
@@ -626,6 +629,7 @@ static u8 sdhci_calc_timeout(struct sdhci_host *host, struct mmc_command *cmd)
 	 *     =>
 	 *     (1) / (2) > 2^6
 	 */
+	BUG_ON(!host->timeout_clk);
 	count = 0;
 	current_timeout = (1 << 13) * 1000 / host->timeout_clk;
 	while (current_timeout < target_timeout) {
@@ -1894,9 +1898,6 @@ int sdhci_add_host(struct sdhci_host *host)
 	if (caps & SDHCI_TIMEOUT_CLK_UNIT)
 		host->timeout_clk *= 1000;
 
-	if (host->quirks & SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK)
-		host->timeout_clk = host->clock / 1000;
-
 	/*
 	 * Set host parameters.
 	 */
-- 
1.7.4.1

