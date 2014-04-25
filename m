From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [PATCH 23/32] mmc: sdhci: cache timing information locally
Date: Fri, 25 Apr 2014 14:26:38 +0100
Message-ID: <E1Wdg9G-00080L-3F@rmk-PC.arm.linux.org.uk>
References: <20140425132245.GO26756@n2100.arm.linux.org.uk>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from gw-1.arm.linux.org.uk ([78.32.30.217]:50660 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751311AbaDYN0m (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 25 Apr 2014 09:26:42 -0400
In-Reply-To: <20140425132245.GO26756@n2100.arm.linux.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <chris@printf.net>, linux-mmc@vger.kernel.org, Markus Pargmann <mpa@pengutronix.de>
Cc: Ulf Hansson <ulf.hansson@linaro.org>

Rather than reading back the timing information from the registers,
cache it locally.  This allows implementations to translate the UHS
timing by overriding the set_uhs_signaling() method as required
without also having to emulate the SDHCI_HOST_CONTROL2 register.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/mmc/host/sdhci.c  | 23 ++++++++++++-----------
 include/linux/mmc/sdhci.h |  2 ++
 2 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 1d88345f88cd..514a0b827620 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1083,24 +1083,23 @@ static void sdhci_finish_command(struct sdhci_host *host)
 
 static u16 sdhci_get_preset_value(struct sdhci_host *host)
 {
-	u16 ctrl, preset = 0;
+	u16 preset = 0;
 
-	ctrl = sdhci_readw(host, SDHCI_HOST_CONTROL2);
-
-	switch (ctrl & SDHCI_CTRL_UHS_MASK) {
-	case SDHCI_CTRL_UHS_SDR12:
+	switch (host->timing) {
+	case MMC_TIMING_UHS_SDR12:
 		preset = sdhci_readw(host, SDHCI_PRESET_FOR_SDR12);
 		break;
-	case SDHCI_CTRL_UHS_SDR25:
+	case MMC_TIMING_UHS_SDR25:
 		preset = sdhci_readw(host, SDHCI_PRESET_FOR_SDR25);
 		break;
-	case SDHCI_CTRL_UHS_SDR50:
+	case MMC_TIMING_UHS_SDR50:
 		preset = sdhci_readw(host, SDHCI_PRESET_FOR_SDR50);
 		break;
-	case SDHCI_CTRL_UHS_SDR104:
+	case MMC_TIMING_UHS_SDR104:
+	case MMC_TIMING_MMC_HS200:
 		preset = sdhci_readw(host, SDHCI_PRESET_FOR_SDR104);
 		break;
-	case SDHCI_CTRL_UHS_DDR50:
+	case MMC_TIMING_UHS_DDR50:
 		preset = sdhci_readw(host, SDHCI_PRESET_FOR_DDR50);
 		break;
 	default:
@@ -1535,6 +1534,7 @@ static void sdhci_do_set_ios(struct sdhci_host *host, struct mmc_ios *ios)
 		sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
 
 		host->ops->set_uhs_signaling(host, ios->timing);
+		host->timing = ios->timing;
 
 		if (!(host->quirks2 & SDHCI_QUIRK2_PRESET_VALUE_BROKEN) &&
 				((ios->timing == MMC_TIMING_UHS_SDR12) ||
@@ -1839,12 +1839,13 @@ static int sdhci_execute_tuning(struct mmc_host *mmc, u32 opcode)
 	 * If the Host Controller supports the HS200 mode then the
 	 * tuning function has to be executed.
 	 */
-	if (((ctrl & SDHCI_CTRL_UHS_MASK) == SDHCI_CTRL_UHS_SDR50) &&
+	if (host->timing == MMC_TIMING_UHS_SDR50 &&
 	    (host->flags & SDHCI_SDR50_NEEDS_TUNING ||
 	     host->flags & SDHCI_SDR104_NEEDS_TUNING))
 		requires_tuning_nonuhs = true;
 
-	if (((ctrl & SDHCI_CTRL_UHS_MASK) == SDHCI_CTRL_UHS_SDR104) ||
+	if (host->timing == MMC_TIMING_MMC_HS200 ||
+	    host->timing == MMC_TIMING_UHS_SDR104 ||
 	    requires_tuning_nonuhs)
 		ctrl |= SDHCI_CTRL_EXEC_TUNING;
 	else {
diff --git a/include/linux/mmc/sdhci.h b/include/linux/mmc/sdhci.h
index 72a90baf111f..7f3efbab8732 100644
--- a/include/linux/mmc/sdhci.h
+++ b/include/linux/mmc/sdhci.h
@@ -172,6 +172,8 @@ struct sdhci_host {
 	unsigned int            ocr_avail_mmc;
 	u32 ocr_mask;		/* available voltages */
 
+	unsigned		timing;		/* Current timing */
+
 	u32			thread_isr;
 
 	/* cached registers */
-- 
1.8.3.1

