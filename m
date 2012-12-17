From: Kevin Liu <kliu5@marvell.com>
Subject: [PATCH v10 02/12] mmc: sdhci: refine code for clock disable/enable in set ios
Date: Mon, 17 Dec 2012 19:21:58 +0800
Message-ID: <1355743328-17758-3-git-send-email-kliu5@marvell.com>
References: <1355743328-17758-1-git-send-email-kliu5@marvell.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog137.obsmtp.com ([74.125.149.18]:52245 "EHLO
	na3sys009aog137.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752294Ab2LQLWl (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 17 Dec 2012 06:22:41 -0500
In-Reply-To: <1355743328-17758-1-git-send-email-kliu5@marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, cjb@laptop.org, arindam.nath@amd.com, peppe.cavallaro@st.com, ulf.hansson@linaro.org, andriy.shevchenko@linux.intel.com, prakity@nvidia.com
Cc: zhangfei.gao@gmail.com, haojian.zhuang@gmail.com, cxie4@marvell.com, keyuan.liu@gmail.com, Kevin Liu <kliu5@marvell.com>

With preset value enabled, there are two continuous times
of clock disable/enable. They can be combined into one
to save time and make code cleaner.

Signed-off-by: Kevin Liu <kliu5@marvell.com>
---
 drivers/mmc/host/sdhci.c |   29 +++++++++--------------------
 1 files changed, 9 insertions(+), 20 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 44f4ecb..b678a08 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1452,33 +1452,22 @@ static void sdhci_do_set_ios(struct sdhci_host *host, struct mmc_ios *ios)
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

