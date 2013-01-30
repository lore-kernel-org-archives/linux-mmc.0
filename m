From: Kevin Liu <kliu5@marvell.com>
Subject: [PATCH 3/7] mmc: sdhci: remove redundant clock disable/enable in set ios
Date: Wed, 30 Jan 2013 16:59:44 +0800
Message-ID: <1359536388-7896-4-git-send-email-kliu5@marvell.com>
References: <1359536388-7896-1-git-send-email-kliu5@marvell.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:49277 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752422Ab3A3I7L (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 30 Jan 2013 03:59:11 -0500
In-Reply-To: <1359536388-7896-1-git-send-email-kliu5@marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Sujit Reddy Thumma <sthumma@codeaurora.org>, Jaehoon Chung <jh80.chung@samsung.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Aaron Lu <aaron.lu@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, Alexander Stein <alexander.stein@systec-electronic.com>
Cc: Nicolas Pitre <nico@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Philip Rakity <prakity@nvidia.com>, Shawn Guo <shawn.guo@linaro.org>, Johan Rudholm <johan.rudholm@stericsson.com>, Daniel Drake <dsd@laptop.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Jerry Huang <Chang-Ming.Huang@freescale.com>, Girish K S <girish.shivananjappa@linaro.org>, Haijun Zhang <Haijun.Zhang@freescale.com>, Viresh Kumar <viresh.kumar@linaro.org>, Heiko Stuebner <heiko@sntech.de>, Thomas Abraham <thomas.abraham@linaro.org>, Chander Kashyap <chander.kashyap@linaro.com>, Sebastian Hesselbarth <sebastian.hesselbarth@googlemail.com>, Zhangfei Gao <zhangfei.gao@gmail.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Chao Xie <cxie4@marvell.com>, Kevin Liu <keyuan.liu@gmail.com>, Kevin Liu <kliu5@marvell.com>

With preset value enabled, SD clock should be reset before enable
both high speed and UHS-I mode. Current code enable them one by one
and do two continuous times of clock disable/enable. The operation
can be combined into once to save time and make code cleaner.

1. disable clock ->
2. enable high speed (Host Control 1 Register, 0x28<2>) ->
3. enable clock ->
4. disable clock ->
5. enable UHS-I mode (Host Control 2 Register, 0x3E<2:0>) ->
6. enable clock

This patch removed above step 3 and 4.

Signed-off-by: Kevin Liu <kliu5@marvell.com>
---
 drivers/mmc/host/sdhci.c |   27 +++++++++------------------
 1 file changed, 9 insertions(+), 18 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index e6da79f..7784756 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1450,31 +1450,22 @@ static void sdhci_do_set_ios(struct sdhci_host *host, struct mmc_ios *ios)
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
-			sdhci_update_clock(host);
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
1.7.9.5

