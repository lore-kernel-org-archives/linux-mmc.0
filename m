From: Arindam Nath <arindam.nath@amd.com>
Subject: [PATCH v3 04/11] mmc: sdhci: reset sdclk before setting high speed enable
Date: Wed, 20 Apr 2011 15:00:54 +0530
Message-ID: <1303291861-1788-5-git-send-email-arindam.nath@amd.com>
References: <1303291861-1788-1-git-send-email-arindam.nath@amd.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:33405 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753597Ab1DTJcP (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 20 Apr 2011 05:32:15 -0400
Received: by pvg12 with SMTP id 12so288395pvg.19
        for <linux-mmc@vger.kernel.org>; Wed, 20 Apr 2011 02:32:15 -0700 (PDT)
In-Reply-To: <1303291861-1788-1-git-send-email-arindam.nath@amd.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: cjb@laptop.org
Cc: linux-mmc@vger.kernel.org, prakity@marvell.com, subhashj@codeaurora.org, zhangfei.gao@gmail.com, henry.su@amd.com, aaron.lu@amd.com, anath.amd@gmail.com, Arindam Nath <arindam.nath@amd.com>

As per Host Controller spec v3.00, we reset SDCLK before setting
High Speed Enable, and then set it back to avoid generating clock
gliches. Before enabling SDCLK again, we make sure the clock is
stable, so we use sdhci_set_clock().

Signed-off-by: Arindam Nath <arindam.nath@amd.com>
---
 drivers/mmc/host/sdhci.c |   27 ++++++++++++++++++++++++---
 1 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index faf332f..175f858 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1237,13 +1237,12 @@ static void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 	else
 		ctrl &= ~SDHCI_CTRL_HISPD;
 
-	sdhci_writeb(host, ctrl, SDHCI_HOST_CONTROL1);
-
 	if (host->version >= SDHCI_SPEC_300) {
 		u16 ctrl_2;
 
 		ctrl_2 = sdhci_readw(host, SDHCI_HOST_CONTROL2);
 		if (!(ctrl_2 & SDHCI_CTRL_PRESET_VAL_ENABLE)) {
+			sdhci_writeb(host, ctrl, SDHCI_HOST_CONTROL1);
 			/*
 			 * We only need to set Driver Strength if the
 			 * preset value enable is not set.
@@ -1255,8 +1254,30 @@ static void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 				ctrl_2 |= SDHCI_CTRL_DRV_TYPE_C;
 
 			sdhci_writew(host, ctrl_2, SDHCI_HOST_CONTROL2);
+		} else {
+			/*
+			 * According to SDHC Spec v3.00, if the Preset Value
+			 * Enable in the Host Control 2 register is set, we
+			 * need to reset SD Clock Enable before changing High
+			 * Speed Enable to avoid generating clock gliches.
+			 */
+			u16 clk;
+			unsigned int clock;
+
+			/* Reset SD Clock Enable */
+			clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
+			clk &= ~SDHCI_CLOCK_CARD_EN;
+			sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
+
+			sdhci_writeb(host, ctrl, SDHCI_HOST_CONTROL1);
+
+			/* Re-enable SD Clock */
+			clock = host->clock;
+			host->clock = 0;
+			sdhci_set_clock(host, clock);
 		}
-	}
+	} else
+		sdhci_writeb(host, ctrl, SDHCI_HOST_CONTROL1);
 
 	/*
 	 * Some (ENE) controllers go apeshit on some ios operation,
-- 
1.7.1

