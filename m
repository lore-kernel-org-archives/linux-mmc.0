From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 17/27] mmc: wmt-sdmmc: Move away from using deprecated APIs
Date: Thu, 26 Sep 2013 16:54:42 +0200
Message-ID: <1380207292-16968-18-git-send-email-ulf.hansson@linaro.org>
References: <1380207292-16968-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1380207292-16968-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Tony Prisk <linux@prisktech.co.nz>, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

Suspend and resume of cards are being handled from the protocol layer
and consequently the mmc_suspend|resume_host APIs are deprecated.

This means we can simplify the suspend|resume callbacks by removing the
use of the deprecated APIs.

Cc: Tony Prisk <linux@prisktech.co.nz>
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/host/wmt-sdmmc.c |   27 ++++++++++-----------------
 1 file changed, 10 insertions(+), 17 deletions(-)

diff --git a/drivers/mmc/host/wmt-sdmmc.c b/drivers/mmc/host/wmt-sdmmc.c
index 34231d5..be94470 100644
--- a/drivers/mmc/host/wmt-sdmmc.c
+++ b/drivers/mmc/host/wmt-sdmmc.c
@@ -939,28 +939,23 @@ static int wmt_mci_suspend(struct device *dev)
 	struct platform_device *pdev = to_platform_device(dev);
 	struct mmc_host *mmc = platform_get_drvdata(pdev);
 	struct wmt_mci_priv *priv;
-	int ret;
 
 	if (!mmc)
 		return 0;
 
 	priv = mmc_priv(mmc);
-	ret = mmc_suspend_host(mmc);
-
-	if (!ret) {
-		reg_tmp = readb(priv->sdmmc_base + SDMMC_BUSMODE);
-		writeb(reg_tmp | BM_SOFT_RESET, priv->sdmmc_base +
-		       SDMMC_BUSMODE);
+	reg_tmp = readb(priv->sdmmc_base + SDMMC_BUSMODE);
+	writeb(reg_tmp | BM_SOFT_RESET, priv->sdmmc_base +
+	       SDMMC_BUSMODE);
 
-		reg_tmp = readw(priv->sdmmc_base + SDMMC_BLKLEN);
-		writew(reg_tmp & 0x5FFF, priv->sdmmc_base + SDMMC_BLKLEN);
+	reg_tmp = readw(priv->sdmmc_base + SDMMC_BLKLEN);
+	writew(reg_tmp & 0x5FFF, priv->sdmmc_base + SDMMC_BLKLEN);
 
-		writeb(0xFF, priv->sdmmc_base + SDMMC_STS0);
-		writeb(0xFF, priv->sdmmc_base + SDMMC_STS1);
+	writeb(0xFF, priv->sdmmc_base + SDMMC_STS0);
+	writeb(0xFF, priv->sdmmc_base + SDMMC_STS1);
 
-		clk_disable(priv->clk_sdmmc);
-	}
-	return ret;
+	clk_disable(priv->clk_sdmmc);
+	return 0;
 }
 
 static int wmt_mci_resume(struct device *dev)
@@ -969,7 +964,6 @@ static int wmt_mci_resume(struct device *dev)
 	struct platform_device *pdev = to_platform_device(dev);
 	struct mmc_host *mmc = platform_get_drvdata(pdev);
 	struct wmt_mci_priv *priv;
-	int ret = 0;
 
 	if (mmc) {
 		priv = mmc_priv(mmc);
@@ -987,10 +981,9 @@ static int wmt_mci_resume(struct device *dev)
 		writeb(reg_tmp | INT0_DI_INT_EN, priv->sdmmc_base +
 		       SDMMC_INTMASK0);
 
-		ret = mmc_resume_host(mmc);
 	}
 
-	return ret;
+	return 0;
 }
 
 static const struct dev_pm_ops wmt_mci_pm = {
-- 
1.7.9.5
