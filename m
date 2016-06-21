From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH v2 3/3] mmc: dw_mmc: prevent to set the wrong value
Date: Tue, 21 Jun 2016 14:35:39 +0900
Message-ID: <1466487339-13211-3-git-send-email-jh80.chung@samsung.com>
References: <1466487339-13211-1-git-send-email-jh80.chung@samsung.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:44134 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752385AbcFUFqq (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 21 Jun 2016 01:46:46 -0400
Received: from epcpsbgr2.samsung.com
 (u142.gpu120.samsung.co.kr [203.254.230.142])
 by mailout2.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0
 64bit (built May  5 2014))
 with ESMTP id <0O9301SKTWVKTUB0@mailout2.samsung.com> for
 linux-mmc@vger.kernel.org; Tue, 21 Jun 2016 14:35:44 +0900 (KST)
In-reply-to: <1466487339-13211-1-git-send-email-jh80.chung@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org, shawn.lin@rock-chips.com, Jaehoon Chung <jh80.chung@samsung.com>

If there ins no vqmmc, voltage should not be changed.
Then it nees to maintain the previous status for USH_REG register.
To use the standard spec, it should be returned error when voltage
can't switch.

Note:
Dwmmc controller will not make any exception case.(like exynos.)
If card isn't working well after appling this patch, it needs to check
the regulator side.

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
---
Changelog V2:
	-Fix the typo

 drivers/mmc/host/dw_mmc.c | 40 ++++++++++++++++++++++------------------
 1 file changed, 22 insertions(+), 18 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index ec3f0a8..56c48fb 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -1404,33 +1404,37 @@ static int dw_mci_switch_voltage(struct mmc_host *mmc, struct mmc_ios *ios)
 	struct dw_mci_slot *slot = mmc_priv(mmc);
 	struct dw_mci *host = slot->host;
 	const struct dw_mci_drv_data *drv_data = host->drv_data;
-	u32 uhs;
+	u32 uhs = 0;
 	u32 v18 = SDMMC_UHS_18V << slot->id;
 	int ret;
 
 	if (drv_data && drv_data->switch_voltage)
 		return drv_data->switch_voltage(mmc, ios);
 
-	/*
-	 * Program the voltage.  Note that some instances of dw_mmc may use
-	 * the UHS_REG for this.  For other instances (like exynos) the UHS_REG
-	 * does no harm but you need to set the regulator directly.  Try both.
-	 */
+	if (IS_ERR(mmc->supply.vqmmc)) {
+		dev_dbg(&mmc->class_dev,
+			"vqmmc not available.(Skip the switching voltage)\n");
+		return -EINVAL;
+	}
+
+	ret = mmc_regulator_set_vqmmc(mmc, ios);
+	if (ret) {
+		dev_err(&mmc->class_dev,
+				 "Regulator set error %d - %s V\n",
+				 ret, uhs & v18 ? "1.8" : "3.3");
+		return ret;
+	}
+
 	uhs = mci_readl(host, UHS_REG);
-	if (ios->signal_voltage == MMC_SIGNAL_VOLTAGE_330)
+	switch (ios->signal_voltage) {
+	case MMC_SIGNAL_VOLTAGE_330:
 		uhs &= ~v18;
-	else
+		break;
+	case MMC_SIGNAL_VOLTAGE_180:
 		uhs |= v18;
-
-	if (!IS_ERR(mmc->supply.vqmmc)) {
-		ret = mmc_regulator_set_vqmmc(mmc, ios);
-
-		if (ret) {
-			dev_dbg(&mmc->class_dev,
-					 "Regulator set error %d - %s V\n",
-					 ret, uhs & v18 ? "1.8" : "3.3");
-			return ret;
-		}
+		break;
+	default:
+		uhs &= ~v18;
 	}
 	mci_writel(host, UHS_REG, uhs);
 
-- 
1.9.1

