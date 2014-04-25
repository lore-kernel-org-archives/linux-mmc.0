From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [PATCH 31/32] mmc: sdhci: track whether preset mode is currently
 enabled in hardware
Date: Fri, 25 Apr 2014 14:27:18 +0100
Message-ID: <E1Wdg9u-00080s-UW@rmk-PC.arm.linux.org.uk>
References: <20140425132245.GO26756@n2100.arm.linux.org.uk>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from gw-1.arm.linux.org.uk ([78.32.30.217]:50710 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752815AbaDYN1W (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 25 Apr 2014 09:27:22 -0400
In-Reply-To: <20140425132245.GO26756@n2100.arm.linux.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <chris@printf.net>, linux-mmc@vger.kernel.org, Markus Pargmann <mpa@pengutronix.de>
Cc: Ulf Hansson <ulf.hansson@linaro.org>

Track whether preset mode is currently enabled in hardware, and use that
when making decisions elsewhere in the code rather than reading the
register and checking the bit.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/mmc/host/sdhci.c  | 44 ++++++++++++++++++++++++++------------------
 include/linux/mmc/sdhci.h |  1 +
 2 files changed, 27 insertions(+), 18 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index aad70ffa484e..a7dd667aaf95 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -205,9 +205,14 @@ static void sdhci_do_reset(struct sdhci_host *host, u8 mask)
 
 	host->ops->reset(host, mask);
 
-	if (host->flags & (SDHCI_USE_SDMA | SDHCI_USE_ADMA)) {
-		if ((host->ops->enable_dma) && (mask & SDHCI_RESET_ALL))
-			host->ops->enable_dma(host);
+	if (mask & SDHCI_RESET_ALL) {
+		if (host->flags & (SDHCI_USE_SDMA | SDHCI_USE_ADMA)) {
+			if (host->ops->enable_dma)
+				host->ops->enable_dma(host);
+		}
+
+		/* Resetting the controller clears many */
+		host->preset_enabled = false;
 	}
 }
 
@@ -1126,8 +1131,7 @@ void sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
 		return;
 
 	if (host->version >= SDHCI_SPEC_300) {
-		if (sdhci_readw(host, SDHCI_HOST_CONTROL2) &
-			SDHCI_CTRL_PRESET_VAL_ENABLE) {
+		if (host->preset_enabled) {
 			u16 pre_val;
 
 			clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
@@ -1491,13 +1495,13 @@ static void sdhci_do_set_ios(struct sdhci_host *host, struct mmc_ios *ios)
 		    (ios->timing == MMC_TIMING_UHS_SDR25))
 			ctrl |= SDHCI_CTRL_HISPD;
 
-		ctrl_2 = sdhci_readw(host, SDHCI_HOST_CONTROL2);
-		if (!(ctrl_2 & SDHCI_CTRL_PRESET_VAL_ENABLE)) {
+		if (!host->preset_enabled) {
 			sdhci_writeb(host, ctrl, SDHCI_HOST_CONTROL);
 			/*
 			 * We only need to set Driver Strength if the
 			 * preset value enable is not set.
 			 */
+			ctrl_2 = sdhci_readw(host, SDHCI_HOST_CONTROL2);
 			ctrl_2 &= ~SDHCI_CTRL_DRV_TYPE_MASK;
 			if (ios->drv_type == MMC_SET_DRIVER_TYPE_A)
 				ctrl_2 |= SDHCI_CTRL_DRV_TYPE_A;
@@ -2012,26 +2016,30 @@ static int sdhci_execute_tuning(struct mmc_host *mmc, u32 opcode)
 
 static void sdhci_enable_preset_value(struct sdhci_host *host, bool enable)
 {
-	u16 ctrl;
-
 	/* Host Controller v3.00 defines preset value registers */
 	if (host->version < SDHCI_SPEC_300)
 		return;
 
-	ctrl = sdhci_readw(host, SDHCI_HOST_CONTROL2);
-
 	/*
 	 * We only enable or disable Preset Value if they are not already
 	 * enabled or disabled respectively. Otherwise, we bail out.
 	 */
-	if (enable && !(ctrl & SDHCI_CTRL_PRESET_VAL_ENABLE)) {
-		ctrl |= SDHCI_CTRL_PRESET_VAL_ENABLE;
-		sdhci_writew(host, ctrl, SDHCI_HOST_CONTROL2);
-		host->flags |= SDHCI_PV_ENABLED;
-	} else if (!enable && (ctrl & SDHCI_CTRL_PRESET_VAL_ENABLE)) {
-		ctrl &= ~SDHCI_CTRL_PRESET_VAL_ENABLE;
+	if (host->preset_enabled != enable) {
+		u16 ctrl = sdhci_readw(host, SDHCI_HOST_CONTROL2);
+
+		if (enable)
+			ctrl |= SDHCI_CTRL_PRESET_VAL_ENABLE;
+		else
+			ctrl &= ~SDHCI_CTRL_PRESET_VAL_ENABLE;
+
 		sdhci_writew(host, ctrl, SDHCI_HOST_CONTROL2);
-		host->flags &= ~SDHCI_PV_ENABLED;
+
+		if (enable)
+			host->flags |= SDHCI_PV_ENABLED;
+		else
+			host->flags &= ~SDHCI_PV_ENABLED;
+
+		host->preset_enabled = enable;
 	}
 }
 
diff --git a/include/linux/mmc/sdhci.h b/include/linux/mmc/sdhci.h
index 7f3efbab8732..08abe9941884 100644
--- a/include/linux/mmc/sdhci.h
+++ b/include/linux/mmc/sdhci.h
@@ -143,6 +143,7 @@ struct sdhci_host {
 
 	bool runtime_suspended;	/* Host is runtime suspended */
 	bool bus_on;		/* Bus power prevents runtime suspend */
+	bool preset_enabled;	/* Preset is enabled */
 
 	struct mmc_request *mrq;	/* Current request */
 	struct mmc_command *cmd;	/* Current command */
-- 
1.8.3.1

