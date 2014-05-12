From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH 5/5] mmc: dw_mmc: use the mmc regulator API into core.c
Date: Mon, 12 May 2014 20:14:16 +0900
Message-ID: <1399893256-7071-6-git-send-email-jh80.chung@samsung.com>
References: <1399893256-7071-1-git-send-email-jh80.chung@samsung.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:33041 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754647AbaELLOb (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 12 May 2014 07:14:31 -0400
Received: from epcpsbgr4.samsung.com
 (u144.gpu120.samsung.co.kr [203.254.230.144])
 by mailout3.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0N5G00BQKKK6SHA0@mailout3.samsung.com> for
 linux-mmc@vger.kernel.org; Mon, 12 May 2014 20:14:30 +0900 (KST)
In-reply-to: <1399893256-7071-1-git-send-email-jh80.chung@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: chris@printf.net, ulf.hansson@linaro.org, tgih.jun@samsung.com, zhangfei.gao@linaro.org, dinguyen@altera.com, Jaehoon Chung <jh80.chung@samsung.com>

Use the mmc regulator API into core.c instead of enabling locally.
It can use the "vmmc", and optional "vqmmc".

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
---
 drivers/mmc/host/dw_mmc.c |   61 ++++++++++++++++++---------------------------
 1 file changed, 24 insertions(+), 37 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index e0e933d..3ab7231 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -937,6 +937,7 @@ static void dw_mci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 	struct dw_mci_slot *slot = mmc_priv(mmc);
 	const struct dw_mci_drv_data *drv_data = slot->host->drv_data;
 	u32 regs;
+	int ret;
 
 	switch (ios->bus_width) {
 	case MMC_BUS_WIDTH_4:
@@ -975,16 +976,36 @@ static void dw_mci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 
 	switch (ios->power_mode) {
 	case MMC_POWER_UP:
+		if (!IS_ERR(mmc->supply.vmmc))
+			mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, ios->vdd);
+
 		set_bit(DW_MMC_CARD_NEED_INIT, &slot->flags);
 		regs = mci_readl(slot->host, PWREN);
 		regs |= (1 << slot->id);
 		mci_writel(slot->host, PWREN, regs);
+
 		break;
 	case MMC_POWER_OFF:
+		if (!IS_ERR(mmc->supply.vmmc))
+			mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, 0);
+
+		if (!IS_ERR(mmc->supply.vqmmc) &&
+				regulator_is_enabled(mmc->supply.vqmmc))
+			regulator_disable(mmc->supply.vqmmc);
+
 		regs = mci_readl(slot->host, PWREN);
 		regs &= ~(1 << slot->id);
 		mci_writel(slot->host, PWREN, regs);
 		break;
+	case MMC_POWER_ON:
+		if (!IS_ERR(mmc->supply.vqmmc) &&
+				!regulator_is_enabled(mmc->supply.vqmmc)) {
+			ret = regulator_enable(mmc->supply.vqmmc);
+			if (ret < 0)
+				dev_err(&slot->mmc->class_dev,
+						"failed to enable vqmmc\n");
+		}
+		break;
 	default:
 		break;
 	}
@@ -2067,7 +2088,9 @@ static int dw_mci_init_slot(struct dw_mci *host, unsigned int id)
 		mmc->f_max = freq[1];
 	}
 
-	mmc->ocr_avail = MMC_VDD_32_33 | MMC_VDD_33_34;
+	mmc_regulator_get_supply(mmc);
+	if (!mmc->ocr_avail)
+		mmc->ocr_avail = MMC_VDD_32_33 | MMC_VDD_33_34;
 
 	if (host->pdata->caps)
 		mmc->caps = host->pdata->caps;
@@ -2375,24 +2398,6 @@ int dw_mci_probe(struct dw_mci *host)
 		}
 	}
 
-	host->vmmc = devm_regulator_get_optional(host->dev, "vmmc");
-	if (IS_ERR(host->vmmc)) {
-		ret = PTR_ERR(host->vmmc);
-		if (ret == -EPROBE_DEFER)
-			goto err_clk_ciu;
-
-		dev_info(host->dev, "no vmmc regulator found: %d\n", ret);
-		host->vmmc = NULL;
-	} else {
-		ret = regulator_enable(host->vmmc);
-		if (ret) {
-			if (ret != -EPROBE_DEFER)
-				dev_err(host->dev,
-					"regulator_enable fail: %d\n", ret);
-			goto err_clk_ciu;
-		}
-	}
-
 	host->quirks = host->pdata->quirks;
 
 	spin_lock_init(&host->lock);
@@ -2536,9 +2541,6 @@ err_workqueue:
 err_dmaunmap:
 	if (host->use_dma && host->dma_ops->exit)
 		host->dma_ops->exit(host);
-	if (host->vmmc)
-		regulator_disable(host->vmmc);
-
 err_clk_ciu:
 	if (!IS_ERR(host->ciu_clk))
 		clk_disable_unprepare(host->ciu_clk);
@@ -2573,9 +2575,6 @@ void dw_mci_remove(struct dw_mci *host)
 	if (host->use_dma && host->dma_ops->exit)
 		host->dma_ops->exit(host);
 
-	if (host->vmmc)
-		regulator_disable(host->vmmc);
-
 	if (!IS_ERR(host->ciu_clk))
 		clk_disable_unprepare(host->ciu_clk);
 
@@ -2592,9 +2591,6 @@ EXPORT_SYMBOL(dw_mci_remove);
  */
 int dw_mci_suspend(struct dw_mci *host)
 {
-	if (host->vmmc)
-		regulator_disable(host->vmmc);
-
 	return 0;
 }
 EXPORT_SYMBOL(dw_mci_suspend);
@@ -2603,15 +2599,6 @@ int dw_mci_resume(struct dw_mci *host)
 {
 	int i, ret;
 
-	if (host->vmmc) {
-		ret = regulator_enable(host->vmmc);
-		if (ret) {
-			dev_err(host->dev,
-				"failed to enable regulator: %d\n", ret);
-			return ret;
-		}
-	}
-
 	if (!dw_mci_ctrl_all_reset(host)) {
 		ret = -ENODEV;
 		return ret;
-- 
1.7.9.5

