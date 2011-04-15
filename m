From: Arindam Nath <arindam.nath@amd.com>
Subject: [PATCH v3 05/12] mmc: sdhci: reset sdclk before setting high speed enable
Date: Fri, 15 Apr 2011 16:08:55 +0530
Message-ID: <1302863942-1774-6-git-send-email-arindam.nath@amd.com>
References: <1302863942-1774-1-git-send-email-arindam.nath@amd.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-px0-f179.google.com ([209.85.212.179]:43166 "EHLO
	mail-px0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755735Ab1DOKlE (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 15 Apr 2011 06:41:04 -0400
Received: by pxi2 with SMTP id 2so1520921pxi.10
        for <linux-mmc@vger.kernel.org>; Fri, 15 Apr 2011 03:41:04 -0700 (PDT)
In-Reply-To: <1302863942-1774-1-git-send-email-arindam.nath@amd.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: cjb@laptop.org
Cc: linux-mmc@vger.kernel.org, subhashj@codeaurora.org, prakity@marvell.com, zhangfei.gao@gmail.com, henry.su@amd.com, aaron.lu@amd.com, anath.amd@gmail.com, Arindam Nath <arindam.nath@amd.com>

As per Host Controller spec v3.00, we reset SDCLK before setting
High Speed Enable, and then set it back to avoid generating clock
gliches. Before enabling SDCLK again, we make sure the clock is
stable, so we use sdhci_set_clock().

Signed-off-by: Arindam Nath <arindam.nath@amd.com>
---
 drivers/mmc/host/sdhci.c |   27 ++++++++++++++++++++++++---
 1 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index fa18b4b..858cdb8 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1286,13 +1286,12 @@ static void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
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
@@ -1304,8 +1303,30 @@ static void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
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

