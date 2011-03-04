From: Arindam Nath <arindam.nath@amd.com>
Subject: [PATCH v2 05/12] mmc: sdhci: reset sdclk before setting high speed enable
Date: Fri,  4 Mar 2011 17:02:42 +0530
Message-ID: <1299238369-1768-6-git-send-email-arindam.nath@amd.com>
References: <1299238369-1768-1-git-send-email-arindam.nath@amd.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:46653 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752011Ab1CDLeK (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 4 Mar 2011 06:34:10 -0500
Received: by iyb26 with SMTP id 26so1806477iyb.19
        for <linux-mmc@vger.kernel.org>; Fri, 04 Mar 2011 03:34:10 -0800 (PST)
In-Reply-To: <1299238369-1768-1-git-send-email-arindam.nath@amd.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: cjb@laptop.org
Cc: zhangfei.gao@gmail.com, prakity@marvell.com, subhashj@codeaurora.org, linux-mmc@vger.kernel.org, henry.su@amd.com, aaron.lu@amd.com, anath.amd@gmail.com, Arindam Nath <arindam.nath@amd.com>

As per Host Controller spec v3.00, we reset SDCLK before setting
High Speed Enable, and then set it back to avoid generating clock
gliches.

Signed-off-by: Arindam Nath <arindam.nath@amd.com>
---
 drivers/mmc/host/sdhci.c |   25 ++++++++++++++++++++++---
 1 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 1645687..5d3bb11 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1277,13 +1277,12 @@ static void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
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
@@ -1294,8 +1293,28 @@ static void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
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
+
+			/* Reset SD Clock Enable */
+			clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
+			clk &= ~SDHCI_CLOCK_CARD_EN;
+			sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
+
+			sdhci_writeb(host, ctrl, SDHCI_HOST_CONTROL1);
+
+			/* Re-enable SD Clock */
+			clk |= SDHCI_CLOCK_CARD_EN;
+			sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
 		}
-	}
+	} else
+		sdhci_writeb(host, ctrl, SDHCI_HOST_CONTROL1);
 
 	/*
 	 * Some (ENE) controllers go apeshit on some ios operation,
-- 
1.7.1

