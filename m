From: Kevin Liu <keyuan.liu@gmail.com>
Subject: [PATCH v6 03/14] mmc: sdhci: refine code for sd clock disable/enable in set ios
Date: Wed, 17 Oct 2012 19:04:42 +0800
Message-ID: <1350471893-29633-4-git-send-email-keyuan.liu@gmail.com>
References: <1350471893-29633-1-git-send-email-keyuan.liu@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog128.obsmtp.com ([74.125.149.141]:34549 "EHLO
	na3sys009aog128.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755580Ab2JQLFL (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 17 Oct 2012 07:05:11 -0400
In-Reply-To: <1350471893-29633-1-git-send-email-keyuan.liu@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, cjb@laptop.org, pierre@ossman.eu, ulf.hansson@linaro.org, zgao6@marvell.com
Cc: hzhuang1@marvell.com, cxie4@marvell.com, prakity@marvell.com, kliu5@marvell.com

From: Kevin Liu <kliu5@marvell.com>

With preset value enabled, there are two continuous times
of sd clock disable/enable. They can be combined into one
to save time and make code cleaner.

Signed-off-by: Kevin Liu <kliu5@marvell.com>
---
 drivers/mmc/host/sdhci.c |   29 +++++++++--------------------
 1 files changed, 9 insertions(+), 20 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 94dab9c..eb621dd 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1449,33 +1449,22 @@ static void sdhci_do_set_ios(struct sdhci_host *host, struct mmc_ios *ios)
 				ctrl_2 |= SDHCI_CTRL_DRV_TYPE_C;
 
 			sdhci_writew(host, ctrl_2, SDHCI_HOST_CONTROL2);
-		} else {
-			/*
-			 * According to SDHC Spec v3.00, if the Preset Value
-			 * Enable in the Host Control 2 register is set, we
-			 * need to reset SD Clock Enable before changing High
-			 * Speed Enable to avoid generating clock gliches.
-			 */
-
-			/* Reset SD Clock Enable */
-			clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
-			clk &= ~SDHCI_CLOCK_CARD_EN;
-			sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
-
-			sdhci_writeb(host, ctrl, SDHCI_HOST_CONTROL);
-
-			/* Re-enable SD Clock */
-			clock = host->clock;
-			host->clock = 0;
-			sdhci_set_clock(host, clock);
 		}
 
-
 		/* Reset SD Clock Enable */
 		clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
 		clk &= ~SDHCI_CLOCK_CARD_EN;
 		sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
 
+		/*
+		 * According to SDHC Spec v3.00, if the Preset Value
+		 * Enable in the Host Control 2 register is set, we
+		 * need to reset SD Clock Enable before changing High
+		 * Speed Enable to avoid generating clock gliches.
+		 */
+		if (ctrl_2 & SDHCI_CTRL_PRESET_VAL_ENABLE)
+			sdhci_writeb(host, ctrl, SDHCI_HOST_CONTROL);
+
 		if (host->ops->set_uhs_signaling)
 			host->ops->set_uhs_signaling(host, ios->timing);
 		else {
-- 
1.7.0.4

