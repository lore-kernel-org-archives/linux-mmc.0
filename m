From: Yuvaraj Kumar C D <yuvaraj.cd@gmail.com>
Subject: [PATCH V2 1/3] mmc: dw_mmc: use mmc_regulator_get_supply to handle regulators
Date: Fri, 22 Aug 2014 19:17:50 +0530
Message-ID: <1408715272-13833-2-git-send-email-yuvaraj.cd@samsung.com>
References: <1408715272-13833-1-git-send-email-yuvaraj.cd@samsung.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pd0-f172.google.com ([209.85.192.172]:51009 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756319AbaHVNsS (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 22 Aug 2014 09:48:18 -0400
In-Reply-To: <1408715272-13833-1-git-send-email-yuvaraj.cd@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, dianders@google.com, dianders@chromium.org, jh80.chung@samsung.com, cjb@laptop.org, tgih.jun@samsung.com, linux-mmc@vger.kernel.org, ulf.hansson@linaro.org
Cc: sonnyrao@chromium.org, t.figa@samsung.com, kgene.kim@samsung.com, joshi@samsung.com, prashanth.g@samsung.com, alim.akhtar@samsung.com, javier.martinez@collabora.co.uk, a.kesavan@samsung.com, Yuvaraj Kumar C D <yuvaraj.cd@samsung.com>

This patch makes use of mmc_regulator_get_supply() to handle
the vmmc and vqmmc regulators.Also it moves the code handling
the these regulators to dw_mci_set_ios().It turned on the vmmc
and vqmmc during MMC_POWER_UP and MMC_POWER_ON,and turned off
during MMC_POWER_OFF.

Signed-off-by: Yuvaraj Kumar C D <yuvaraj.cd@samsung.com>
---
changes from v1:
	1.Used mmc_regulator_set_ocr() instead of regulator_enable() for vmmc.
	2.Turned on vmmc and vqmmc during MMC_POWER_UP.
	3. Removed the flags DW_MMC_CARD_POWERED and DW_MMC_IO_POWERED which
	   added during the initial version of this patch.
	4. Added error message, if it failed to turn on regulator's.

 drivers/mmc/host/dw_mmc.c  |   72 +++++++++++++++++++++-----------------------
 include/linux/mmc/dw_mmc.h |    2 +-
 2 files changed, 36 insertions(+), 38 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 7f227e9..aadb0d6 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -936,6 +936,7 @@ static void dw_mci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 	struct dw_mci_slot *slot = mmc_priv(mmc);
 	const struct dw_mci_drv_data *drv_data = slot->host->drv_data;
 	u32 regs;
+	int ret;
 
 	switch (ios->bus_width) {
 	case MMC_BUS_WIDTH_4:
@@ -974,12 +975,38 @@ static void dw_mci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 
 	switch (ios->power_mode) {
 	case MMC_POWER_UP:
+		if (!IS_ERR(mmc->supply.vmmc)) {
+			ret = mmc_regulator_set_ocr(mmc, mmc->supply.vmmc,
+					ios->vdd);
+			if (ret) {
+				dev_err(slot->host->dev,
+					"failed to enable vmmc regulator\n");
+				/*return, if failed turn on vmmc*/
+				return;
+			}
+		}
+		if (!IS_ERR(mmc->supply.vqmmc) && !slot->host->vqmmc_enabled) {
+			ret = regulator_enable(mmc->supply.vqmmc);
+			if (ret < 0)
+				dev_err(slot->host->dev,
+					"failed to enable vqmmc regulator\n");
+			else
+				slot->host->vqmmc_enabled = true;
+		}
 		set_bit(DW_MMC_CARD_NEED_INIT, &slot->flags);
 		regs = mci_readl(slot->host, PWREN);
 		regs |= (1 << slot->id);
 		mci_writel(slot->host, PWREN, regs);
 		break;
 	case MMC_POWER_OFF:
+		if (!IS_ERR(mmc->supply.vmmc))
+			mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, 0);
+
+		if (!IS_ERR(mmc->supply.vqmmc) && slot->host->vqmmc_enabled) {
+			regulator_disable(mmc->supply.vqmmc);
+			slot->host->vqmmc_enabled = false;
+		}
+
 		regs = mci_readl(slot->host, PWREN);
 		regs &= ~(1 << slot->id);
 		mci_writel(slot->host, PWREN, regs);
@@ -2110,7 +2137,13 @@ static int dw_mci_init_slot(struct dw_mci *host, unsigned int id)
 		mmc->f_max = freq[1];
 	}
 
-	mmc->ocr_avail = MMC_VDD_32_33 | MMC_VDD_33_34;
+	/*if there are external regulators, get them*/
+	ret = mmc_regulator_get_supply(mmc);
+	if (ret == -EPROBE_DEFER)
+		goto err_setup_bus;
+
+	if (!mmc->ocr_avail)
+		mmc->ocr_avail = MMC_VDD_32_33 | MMC_VDD_33_34;
 
 	if (host->pdata->caps)
 		mmc->caps = host->pdata->caps;
@@ -2176,7 +2209,7 @@ static int dw_mci_init_slot(struct dw_mci *host, unsigned int id)
 
 err_setup_bus:
 	mmc_free_host(mmc);
-	return -EINVAL;
+	return ret;
 }
 
 static void dw_mci_cleanup_slot(struct dw_mci_slot *slot, unsigned int id)
@@ -2469,24 +2502,6 @@ int dw_mci_probe(struct dw_mci *host)
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
@@ -2630,8 +2645,6 @@ err_workqueue:
 err_dmaunmap:
 	if (host->use_dma && host->dma_ops->exit)
 		host->dma_ops->exit(host);
-	if (host->vmmc)
-		regulator_disable(host->vmmc);
 
 err_clk_ciu:
 	if (!IS_ERR(host->ciu_clk))
@@ -2667,9 +2680,6 @@ void dw_mci_remove(struct dw_mci *host)
 	if (host->use_dma && host->dma_ops->exit)
 		host->dma_ops->exit(host);
 
-	if (host->vmmc)
-		regulator_disable(host->vmmc);
-
 	if (!IS_ERR(host->ciu_clk))
 		clk_disable_unprepare(host->ciu_clk);
 
@@ -2686,9 +2696,6 @@ EXPORT_SYMBOL(dw_mci_remove);
  */
 int dw_mci_suspend(struct dw_mci *host)
 {
-	if (host->vmmc)
-		regulator_disable(host->vmmc);
-
 	return 0;
 }
 EXPORT_SYMBOL(dw_mci_suspend);
@@ -2697,15 +2704,6 @@ int dw_mci_resume(struct dw_mci *host)
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
 	if (!dw_mci_ctrl_reset(host, SDMMC_CTRL_ALL_RESET_FLAGS)) {
 		ret = -ENODEV;
 		return ret;
diff --git a/include/linux/mmc/dw_mmc.h b/include/linux/mmc/dw_mmc.h
index 29ce014..84e2827 100644
--- a/include/linux/mmc/dw_mmc.h
+++ b/include/linux/mmc/dw_mmc.h
@@ -188,7 +188,7 @@ struct dw_mci {
 	/* Workaround flags */
 	u32			quirks;
 
-	struct regulator	*vmmc;	/* Power regulator */
+	bool			vqmmc_enabled;
 	unsigned long		irq_flags; /* IRQ flags */
 	int			irq;
 };
-- 
1.7.10.4

