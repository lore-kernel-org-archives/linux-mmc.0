From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 1/2] mmc: sdhci-esdhc-imx: Fixup ->remove()
Date: Fri, 19 Dec 2014 10:45:43 +0100
Message-ID: <1418982343-8023-1-git-send-email-ulf.hansson@linaro.org>
References: <0002-mmc-sdhci-esdhc-imx-Fixup-runtime-PM-conditions-duri.patch>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lb0-f170.google.com ([209.85.217.170]:39854 "EHLO
	mail-lb0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751243AbaLSJpu (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 19 Dec 2014 04:45:50 -0500
Received: by mail-lb0-f170.google.com with SMTP id 10so505502lbg.29
        for <linux-mmc@vger.kernel.org>; Fri, 19 Dec 2014 01:45:48 -0800 (PST)
In-Reply-To: <0002-mmc-sdhci-esdhc-imx-Fixup-runtime-PM-conditions-duri.patch>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <chris@printf.net>
Cc: Dong Aisheng <b29396@freescale.com>, Shawn Guo <shawn.guo@linaro.org>

Since sdhci_remove_host() access the device, we need to make sure it's
runtime PM resumed.

To handle clock gating properly in remove, we first have to make sure
the clocks are ungated.

To fix both these issues, by invoking pm_runtime_get_sync() early in
->remove() callback. Later once we disabled runtime PM, we can restore
the usage count.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/host/sdhci-esdhc-imx.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index af1f7c0..043866c 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -1103,16 +1103,15 @@ static int sdhci_esdhc_imx_remove(struct platform_device *pdev)
 	struct pltfm_imx_data *imx_data = pltfm_host->priv;
 	int dead = (readl(host->ioaddr + SDHCI_INT_STATUS) == 0xffffffff);
 
-	sdhci_remove_host(host, dead);
-
-	pm_runtime_dont_use_autosuspend(&pdev->dev);
+	pm_runtime_get_sync(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
+	pm_runtime_put_noidle(&pdev->dev);
 
-	if (!IS_ENABLED(CONFIG_PM)) {
-		clk_disable_unprepare(imx_data->clk_per);
-		clk_disable_unprepare(imx_data->clk_ipg);
-		clk_disable_unprepare(imx_data->clk_ahb);
-	}
+	sdhci_remove_host(host, dead);
+
+	clk_disable_unprepare(imx_data->clk_per);
+	clk_disable_unprepare(imx_data->clk_ipg);
+	clk_disable_unprepare(imx_data->clk_ahb);
 
 	sdhci_pltfm_free(pdev);
 
-- 
1.9.1

