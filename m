From: Yuvaraj Kumar C D <yuvaraj.cd@gmail.com>
Subject: [PATCH 1/3] mmc: dw_mmc: use mmc_regulator_get_supply to handle regulators
Date: Mon, 23 Jun 2014 16:15:19 +0530
Message-ID: <1403520321-2431-2-git-send-email-yuvaraj.cd@samsung.com>
References: <1403520321-2431-1-git-send-email-yuvaraj.cd@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1403520321-2431-1-git-send-email-yuvaraj.cd@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, jh80.chung@samsung.com, cjb@laptop.org, tgih.jun@samsung.com, linux-mmc@vger.kernel.org, ulf.hansson@linaro.org
Cc: sonnyrao@chromium.org, t.figa@samsung.com, kgene.kim@samsung.com, joshi@samsung.com, ks.giri@samsung.com, prashanth.g@samsung.com, alim.akhtar@samsung.com, Yuvaraj Kumar C D <yuvaraj.cd@samsung.com>
List-Id: linux-mmc@vger.kernel.org

This patch makes use of mmc_regulator_get_supply() to handle
the vmmc and vqmmc regulators.Also it moves the code handling
the these regulators to dw_mci_set_ios().It turned on the vmmc
and vqmmc during MMC_POWER_UP and MMC_POWER_ON,and turned off
during MMC_POWER_OFF.

Signed-off-by: Yuvaraj Kumar C D <yuvaraj.cd@samsung.com>
---
 drivers/mmc/host/dw_mmc.c |   71 ++++++++++++++++++++++-----------------------
 drivers/mmc/host/dw_mmc.h |    2 ++
 2 files changed, 36 insertions(+), 37 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 1ac227c..f5cabce 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -937,6 +937,7 @@ static void dw_mci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 	struct dw_mci_slot *slot = mmc_priv(mmc);
 	const struct dw_mci_drv_data *drv_data = slot->host->drv_data;
 	u32 regs;
+	int ret;
 
 	switch (ios->bus_width) {
 	case MMC_BUS_WIDTH_4:
@@ -975,16 +976,41 @@ static void dw_mci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 
 	switch (ios->power_mode) {
 	case MMC_POWER_UP:
+		if ((!IS_ERR(mmc->supply.vmmc)) &&
+				!test_bit(DW_MMC_CARD_POWERED, &slot->flags)) {
+			ret = regulator_enable(mmc->supply.vmmc);
+			if (!ret)
+				set_bit(DW_MMC_CARD_POWERED, &slot->flags);
+		}
 		set_bit(DW_MMC_CARD_NEED_INIT, &slot->flags);
 		regs = mci_readl(slot->host, PWREN);
 		regs |= (1 << slot->id);
 		mci_writel(slot->host, PWREN, regs);
 		break;
 	case MMC_POWER_OFF:
+		if (!IS_ERR(mmc->supply.vqmmc) &&
+				test_bit(DW_MMC_IO_POWERED, &slot->flags)) {
+			ret = regulator_disable(mmc->supply.vqmmc);
+			if (!ret)
+				clear_bit(DW_MMC_IO_POWERED, &slot->flags);
+		}
+		if (!IS_ERR(mmc->supply.vmmc) &&
+				test_bit(DW_MMC_CARD_POWERED, &slot->flags)) {
+			ret = regulator_disable(mmc->supply.vmmc);
+			if (!ret)
+				clear_bit(DW_MMC_CARD_POWERED, &slot->flags);
+		}
 		regs = mci_readl(slot->host, PWREN);
 		regs &= ~(1 << slot->id);
 		mci_writel(slot->host, PWREN, regs);
 		break;
+	case MMC_POWER_ON:
+		if (!IS_ERR(mmc->supply.vqmmc) &&
+				!test_bit(DW_MMC_IO_POWERED, &slot->flags)) {
+			ret = regulator_enable(mmc->supply.vqmmc);
+			if (!ret)
+				set_bit(DW_MMC_IO_POWERED, &slot->flags);
+		}
 	default:
 		break;
 	}
@@ -2067,7 +2093,13 @@ static int dw_mci_init_slot(struct dw_mci *host, unsigned int id)
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
@@ -2133,7 +2165,7 @@ static int dw_mci_init_slot(struct dw_mci *host, unsigned int id)
 
 err_setup_bus:
 	mmc_free_host(mmc);
-	return -EINVAL;
+	return ret;
 }
 
 static void dw_mci_cleanup_slot(struct dw_mci_slot *slot, unsigned int id)
@@ -2375,24 +2407,6 @@ int dw_mci_probe(struct dw_mci *host)
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
@@ -2536,8 +2550,6 @@ err_workqueue:
 err_dmaunmap:
 	if (host->use_dma && host->dma_ops->exit)
 		host->dma_ops->exit(host);
-	if (host->vmmc)
-		regulator_disable(host->vmmc);
 
 err_clk_ciu:
 	if (!IS_ERR(host->ciu_clk))
@@ -2573,9 +2585,6 @@ void dw_mci_remove(struct dw_mci *host)
 	if (host->use_dma && host->dma_ops->exit)
 		host->dma_ops->exit(host);
 
-	if (host->vmmc)
-		regulator_disable(host->vmmc);
-
 	if (!IS_ERR(host->ciu_clk))
 		clk_disable_unprepare(host->ciu_clk);
 
@@ -2592,9 +2601,6 @@ EXPORT_SYMBOL(dw_mci_remove);
  */
 int dw_mci_suspend(struct dw_mci *host)
 {
-	if (host->vmmc)
-		regulator_disable(host->vmmc);
-
 	return 0;
 }
 EXPORT_SYMBOL(dw_mci_suspend);
@@ -2603,15 +2609,6 @@ int dw_mci_resume(struct dw_mci *host)
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
diff --git a/drivers/mmc/host/dw_mmc.h b/drivers/mmc/host/dw_mmc.h
index 738fa24..5c95d00 100644
--- a/drivers/mmc/host/dw_mmc.h
+++ b/drivers/mmc/host/dw_mmc.h
@@ -225,6 +225,8 @@ struct dw_mci_slot {
 	unsigned long		flags;
 #define DW_MMC_CARD_PRESENT	0
 #define DW_MMC_CARD_NEED_INIT	1
+#define DW_MMC_CARD_POWERED    2
+#define DW_MMC_IO_POWERED      3
 	int			id;
 	int			last_detect_state;
 };
-- 
1.7.10.4
