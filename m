From: Arindam Nath <arindam.nath@amd.com>
Subject: [PATCH 05/12] mmc: sdhci: reset sdclk before setting high speed enable
Date: Tue, 15 Feb 2011 15:05:03 +0530
Message-ID: <1297762510-2696-6-git-send-email-arindam.nath@amd.com>
References: <1297762510-2696-1-git-send-email-arindam.nath@amd.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:52231 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753787Ab1BOJhJ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 15 Feb 2011 04:37:09 -0500
Received: by iyj8 with SMTP id 8so5729998iyj.19
        for <linux-mmc@vger.kernel.org>; Tue, 15 Feb 2011 01:37:09 -0800 (PST)
In-Reply-To: <1297762510-2696-1-git-send-email-arindam.nath@amd.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: cjb@laptop.org
Cc: linux-mmc@vger.kernel.org, henry.su@amd.com, aaron.lu@amd.com, anath.amd@gmail.com, Arindam Nath <arindam.nath@amd.com>

As per Host Controller spec v3.00, we reset SDCLK before setting
High Speed Enable, and then set it back to avoid generating clock
gliches.

Signed-off-by: Arindam Nath <arindam.nath@amd.com>
---
 drivers/mmc/host/sdhci.c |   25 ++++++++++++++++++++++---
 1 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index b768839..5db0109 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1280,13 +1280,12 @@ static void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
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
@@ -1297,8 +1296,28 @@ static void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
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

