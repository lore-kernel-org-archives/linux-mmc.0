From: Peter Griffin <peter.griffin@linaro.org>
Subject: [PATCH v3 2/9] mmc: sdhci-st: Add support for de-asserting reset signal and top regs resource
Date: Mon, 30 Mar 2015 15:39:55 +0100
Message-ID: <1427726402-7513-3-git-send-email-peter.griffin@linaro.org>
References: <1427726402-7513-1-git-send-email-peter.griffin@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wg0-f41.google.com ([74.125.82.41]:35040 "EHLO
	mail-wg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752709AbbC3OkN (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 30 Mar 2015 10:40:13 -0400
Received: by wgdm6 with SMTP id m6so177614011wgd.2
        for <linux-mmc@vger.kernel.org>; Mon, 30 Mar 2015 07:40:12 -0700 (PDT)
In-Reply-To: <1427726402-7513-1-git-send-email-peter.griffin@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, maxime.coquelin@st.com, patrice.chotard@st.com, srinivas.kandagatla@gmail.com, chris@printf.net, ulf.hansson@linaro.org
Cc: peter.griffin@linaro.org, lee.jones@linaro.org, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, peppe.cavallaro@st.com

STiH407 family SoC's can have a reset signal for the controller which needs to
be managed. Also the eMMC controller has some additional 'top' memory mapped
registers which are used to manage the dynamic and static delay required for
UHS modes. This patch adds support for creating the mapping, which will be used
by subsequent patches.

Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
Signed-off-by: Giuseppe Cavallaro <peppe.cavallaro@st.com>
Acked-by: Maxime Coquelin <maxime.coquelin@st.com>
---
 drivers/mmc/host/sdhci-st.c | 52 ++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 49 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/sdhci-st.c b/drivers/mmc/host/sdhci-st.c
index a31ac04..697c609 100644
--- a/drivers/mmc/host/sdhci-st.c
+++ b/drivers/mmc/host/sdhci-st.c
@@ -23,9 +23,14 @@
 #include <linux/module.h>
 #include <linux/err.h>
 #include <linux/mmc/host.h>
-
+#include <linux/reset.h>
 #include "sdhci-pltfm.h"
 
+struct st_mmc_platform_data {
+	struct  reset_control *rstc;
+	void __iomem *top_ioaddr;
+};
+
 /* MMCSS glue logic to setup the HC on some ST SoCs (e.g. STiH407 family) */
 
 #define ST_MMC_CCONFIG_REG_1		0x400
@@ -151,10 +156,16 @@ static const struct sdhci_pltfm_data sdhci_st_pdata = {
 static int sdhci_st_probe(struct platform_device *pdev)
 {
 	struct sdhci_host *host;
+	struct st_mmc_platform_data *pdata;
 	struct sdhci_pltfm_host *pltfm_host;
 	struct clk *clk;
 	int ret = 0;
 	u16 host_version;
+	struct resource *res;
+
+	pdata = devm_kzalloc(&pdev->dev, sizeof(*pdata), GFP_KERNEL);
+	if (!pdata)
+		return -ENOMEM;
 
 	clk =  devm_clk_get(&pdev->dev, "mmc");
 	if (IS_ERR(clk)) {
@@ -162,10 +173,17 @@ static int sdhci_st_probe(struct platform_device *pdev)
 		return PTR_ERR(clk);
 	}
 
+	pdata->rstc = devm_reset_control_get(&pdev->dev, NULL);
+	if (IS_ERR(pdata->rstc))
+		pdata->rstc = NULL;
+	else
+		reset_control_deassert(pdata->rstc);
+
 	host = sdhci_pltfm_init(pdev, &sdhci_st_pdata, 0);
 	if (IS_ERR(host)) {
 		dev_err(&pdev->dev, "Failed sdhci_pltfm_init\n");
-		return PTR_ERR(host);
+		ret = PTR_ERR(host);
+		goto err_pltfm_init;
 	}
 
 	ret = mmc_of_parse(host->mmc);
@@ -176,7 +194,17 @@ static int sdhci_st_probe(struct platform_device *pdev)
 
 	clk_prepare_enable(clk);
 
+	/* Configure the FlashSS Top registers for setting eMMC TX/RX delay */
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
+					   "top-mmc-delay");
+	pdata->top_ioaddr = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(pdata->top_ioaddr)) {
+		dev_warn(&pdev->dev, "FlashSS Top Dly registers not available");
+		pdata->top_ioaddr = NULL;
+	}
+
 	pltfm_host = sdhci_priv(host);
+	pltfm_host->priv = pdata;
 	pltfm_host->clk = clk;
 
 	ret = sdhci_add_host(host);
@@ -200,6 +228,9 @@ err_out:
 	clk_disable_unprepare(clk);
 err_of:
 	sdhci_pltfm_free(pdev);
+err_pltfm_init:
+	if (pdata->rstc)
+		reset_control_assert(pdata->rstc);
 
 	return ret;
 }
@@ -208,10 +239,17 @@ static int sdhci_st_remove(struct platform_device *pdev)
 {
 	struct sdhci_host *host = platform_get_drvdata(pdev);
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct st_mmc_platform_data *pdata = pltfm_host->priv;
+	int ret;
 
 	clk_disable_unprepare(pltfm_host->clk);
 
-	return sdhci_pltfm_unregister(pdev);
+	ret = sdhci_pltfm_unregister(pdev);
+
+	if (pdata->rstc)
+		reset_control_assert(pdata->rstc);
+
+	return ret;
 }
 
 #ifdef CONFIG_PM_SLEEP
@@ -219,11 +257,15 @@ static int sdhci_st_suspend(struct device *dev)
 {
 	struct sdhci_host *host = dev_get_drvdata(dev);
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct st_mmc_platform_data *pdata = pltfm_host->priv;
 	int ret = sdhci_suspend_host(host);
 
 	if (ret)
 		goto out;
 
+	if (pdata->rstc)
+		reset_control_assert(pdata->rstc);
+
 	clk_disable_unprepare(pltfm_host->clk);
 out:
 	return ret;
@@ -233,9 +275,13 @@ static int sdhci_st_resume(struct device *dev)
 {
 	struct sdhci_host *host = dev_get_drvdata(dev);
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct st_mmc_platform_data *pdata = pltfm_host->priv;
 
 	clk_prepare_enable(pltfm_host->clk);
 
+	if (pdata->rstc)
+		reset_control_deassert(pdata->rstc);
+
 	return sdhci_resume_host(host);
 }
 #endif
-- 
1.9.1

