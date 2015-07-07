From: Andreas Fenkart <afenkart@gmail.com>
Subject: [PATCH v2 1/2] mmc: omap_hsmmc: call omap_hsmmc_set_power directly
Date: Tue,  7 Jul 2015 20:38:43 +0200
Message-ID: <1436294324-18666-2-git-send-email-afenkart@gmail.com>
References: <1436294324-18666-1-git-send-email-afenkart@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wi0-f180.google.com ([209.85.212.180]:38636 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933282AbbGGSi4 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 7 Jul 2015 14:38:56 -0400
Received: by wibdq8 with SMTP id dq8so191594742wib.1
        for <linux-mmc@vger.kernel.org>; Tue, 07 Jul 2015 11:38:55 -0700 (PDT)
In-Reply-To: <1436294324-18666-1-git-send-email-afenkart@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Andreas Fenkart <afenkart@gmail.com>

If no pdata.set_power was set by the platform code, the driver
was updating pdata with its own fallback function. This is a no-no
since pdata shall be read-only.
This patch pushes the check 'pdata->set_power != NULL' down into
the fallback functions. If pdata.set_power is really set, it calls them
and exits, otherwise the fallback code is used.

Signed-off-by: Andreas Fenkart <afenkart@gmail.com>
---
 drivers/mmc/host/omap_hsmmc.c | 37 ++++++++++++++++++++++---------------
 1 file changed, 22 insertions(+), 15 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index b2b411d..806867b 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -213,7 +213,6 @@ struct omap_hsmmc_host {
 	int			context_loss;
 	int			protect_card;
 	int			reqs_blocked;
-	int			use_reg;
 	int			req_in_progress;
 	unsigned long		clk_rate;
 	unsigned int		flags;
@@ -262,6 +261,9 @@ static int omap_hsmmc_set_power(struct device *dev, int power_on, int vdd)
 		platform_get_drvdata(to_platform_device(dev));
 	int ret = 0;
 
+	if (mmc_pdata(host)->set_power)
+		return mmc_pdata(host)->set_power(dev, power_on, vdd);
+
 	/*
 	 * If we don't see a Vcc regulator, assume it's a fixed
 	 * voltage always-on regulator.
@@ -344,6 +346,9 @@ static int omap_hsmmc_reg_get(struct omap_hsmmc_host *host)
 	struct regulator *reg;
 	int ocr_value = 0;
 
+	if (mmc_pdata(host)->set_power)
+		return 0;
+
 	reg = devm_regulator_get(host->dev, "vmmc");
 	if (IS_ERR(reg)) {
 		dev_err(host->dev, "unable to get vmmc regulator %ld\n",
@@ -363,7 +368,6 @@ static int omap_hsmmc_reg_get(struct omap_hsmmc_host *host)
 			}
 		}
 	}
-	mmc_pdata(host)->set_power = omap_hsmmc_set_power;
 
 	/* Allow an aux regulator */
 	reg = devm_regulator_get_optional(host->dev, "vmmc_aux");
@@ -383,8 +387,8 @@ static int omap_hsmmc_reg_get(struct omap_hsmmc_host *host)
 	    (host->vcc_aux && regulator_is_enabled(host->vcc_aux))) {
 		int vdd = ffs(mmc_pdata(host)->ocr_mask) - 1;
 
-		mmc_pdata(host)->set_power(host->dev, 1, vdd);
-		mmc_pdata(host)->set_power(host->dev, 0, 0);
+		omap_hsmmc_set_power(host->dev, 1, vdd);
+		omap_hsmmc_set_power(host->dev, 0, 0);
 	}
 
 	return 0;
@@ -392,7 +396,8 @@ static int omap_hsmmc_reg_get(struct omap_hsmmc_host *host)
 
 static void omap_hsmmc_reg_put(struct omap_hsmmc_host *host)
 {
-	mmc_pdata(host)->set_power = NULL;
+	if (mmc_pdata(host)->set_power)
+		return;
 }
 
 static inline int omap_hsmmc_have_reg(void)
@@ -402,6 +407,11 @@ static inline int omap_hsmmc_have_reg(void)
 
 #else
 
+static int omap_hsmmc_set_power(struct device *dev, int power_on, int vdd)
+{
+	return 0;
+}
+
 static inline int omap_hsmmc_reg_get(struct omap_hsmmc_host *host)
 {
 	return -EINVAL;
@@ -1148,11 +1158,11 @@ static int omap_hsmmc_switch_opcond(struct omap_hsmmc_host *host, int vdd)
 		clk_disable_unprepare(host->dbclk);
 
 	/* Turn the power off */
-	ret = mmc_pdata(host)->set_power(host->dev, 0, 0);
+	ret = omap_hsmmc_set_power(host->dev, 0, 0);
 
 	/* Turn the power ON with given VDD 1.8 or 3.0v */
 	if (!ret)
-		ret = mmc_pdata(host)->set_power(host->dev, 1, vdd);
+		ret = omap_hsmmc_set_power(host->dev, 1, vdd);
 	pm_runtime_get_sync(host->dev);
 	if (host->dbclk)
 		clk_prepare_enable(host->dbclk);
@@ -1551,10 +1561,10 @@ static void omap_hsmmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 	if (ios->power_mode != host->power_mode) {
 		switch (ios->power_mode) {
 		case MMC_POWER_OFF:
-			mmc_pdata(host)->set_power(host->dev, 0, 0);
+			omap_hsmmc_set_power(host->dev, 0, 0);
 			break;
 		case MMC_POWER_UP:
-			mmc_pdata(host)->set_power(host->dev, 1, ios->vdd);
+			omap_hsmmc_set_power(host->dev, 1, ios->vdd);
 			break;
 		case MMC_POWER_ON:
 			do_send_init_stream = 1;
@@ -2077,11 +2087,10 @@ static int omap_hsmmc_probe(struct platform_device *pdev)
 		goto err_irq;
 	}
 
-	if (omap_hsmmc_have_reg() && !mmc_pdata(host)->set_power) {
+	if (omap_hsmmc_have_reg()) {
 		ret = omap_hsmmc_reg_get(host);
 		if (ret)
 			goto err_irq;
-		host->use_reg = 1;
 	}
 
 	mmc->ocr_avail = mmc_pdata(host)->ocr_mask;
@@ -2124,8 +2133,7 @@ static int omap_hsmmc_probe(struct platform_device *pdev)
 
 err_slot_name:
 	mmc_remove_host(mmc);
-	if (host->use_reg)
-		omap_hsmmc_reg_put(host);
+	omap_hsmmc_reg_put(host);
 err_irq:
 	device_init_wakeup(&pdev->dev, false);
 	if (host->tx_chan)
@@ -2149,8 +2157,7 @@ static int omap_hsmmc_remove(struct platform_device *pdev)
 
 	pm_runtime_get_sync(host->dev);
 	mmc_remove_host(host->mmc);
-	if (host->use_reg)
-		omap_hsmmc_reg_put(host);
+	omap_hsmmc_reg_put(host);
 
 	if (host->tx_chan)
 		dma_release_channel(host->tx_chan);
-- 
2.1.4

