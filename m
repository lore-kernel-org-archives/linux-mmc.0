From: Dong Aisheng <b29396@freescale.com>
Subject: [PATCH 5/5] mmc: sdhci-esdhc-imx: add runtime pm support
Date: Wed, 30 Oct 2013 22:12:18 +0800
Message-ID: <1383142338-25062-6-git-send-email-b29396@freescale.com>
References: <1383142338-25062-1-git-send-email-b29396@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-db8lp0184.outbound.messaging.microsoft.com ([213.199.154.184]:43781
	"EHLO db8outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752899Ab3J3Obb (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 30 Oct 2013 10:31:31 -0400
In-Reply-To: <1383142338-25062-1-git-send-email-b29396@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, cjb@laptop.org, shawn.guo@linaro.org, s.hauer@pengutronix.de, b29396@freescale.com, wsa@the-dreams.de

The root clock will be disabled in runtime pm which can be used to save power.

Signed-off-by: Dong Aisheng <b29396@freescale.com>
---
 drivers/mmc/host/sdhci-esdhc-imx.c |   53 ++++++++++++++++++++++++++++++++++-
 1 files changed, 51 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index da8026b..60201fd 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -27,6 +27,7 @@
 #include <linux/of_gpio.h>
 #include <linux/pinctrl/consumer.h>
 #include <linux/platform_data/mmc-esdhc-imx.h>
+#include <linux/pm_runtime.h>
 #include "sdhci-pltfm.h"
 #include "sdhci-esdhc.h"
 
@@ -1117,9 +1118,17 @@ static int sdhci_esdhc_imx_probe(struct platform_device *pdev)
 		host->quirks2 |= SDHCI_QUIRK2_NO_1_8_V;
 	}
 
+	pm_runtime_enable(&pdev->dev);
+	pm_runtime_set_autosuspend_delay(&pdev->dev, 50);
+	pm_runtime_use_autosuspend(&pdev->dev);
+	pm_suspend_ignore_children(&pdev->dev, 1);
+
 	err = sdhci_add_host(host);
-	if (err)
+	if (err) {
+		pm_runtime_forbid(&pdev->dev);
+		pm_runtime_get_noresume(&pdev->dev);
 		goto disable_clk;
+	}
 
 	return 0;
 
@@ -1141,6 +1150,9 @@ static int sdhci_esdhc_imx_remove(struct platform_device *pdev)
 
 	sdhci_remove_host(host, dead);
 
+	pm_runtime_dont_use_autosuspend(&pdev->dev);
+	pm_runtime_disable(&pdev->dev);
+
 	clk_disable_unprepare(imx_data->clk_per);
 	clk_disable_unprepare(imx_data->clk_ipg);
 	clk_disable_unprepare(imx_data->clk_ahb);
@@ -1150,12 +1162,49 @@ static int sdhci_esdhc_imx_remove(struct platform_device *pdev)
 	return 0;
 }
 
+#ifdef CONFIG_PM_RUNTIME
+static int sdhci_esdhc_runtime_suspend(struct device *dev)
+{
+	struct sdhci_host *host = dev_get_drvdata(dev);
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct pltfm_imx_data *imx_data = pltfm_host->priv;
+	int ret;
+
+	ret = sdhci_runtime_suspend_host(host);
+
+	clk_disable_unprepare(imx_data->clk_per);
+	clk_disable_unprepare(imx_data->clk_ipg);
+	clk_disable_unprepare(imx_data->clk_ahb);
+
+	return ret;
+}
+
+static int sdhci_esdhc_runtime_resume(struct device *dev)
+{
+	struct sdhci_host *host = dev_get_drvdata(dev);
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct pltfm_imx_data *imx_data = pltfm_host->priv;
+
+	clk_prepare_enable(imx_data->clk_per);
+	clk_prepare_enable(imx_data->clk_ipg);
+	clk_prepare_enable(imx_data->clk_ahb);
+
+	return sdhci_runtime_resume_host(host);
+}
+#endif
+
+static const struct dev_pm_ops sdhci_esdhc_pmops = {
+	SET_SYSTEM_SLEEP_PM_OPS(sdhci_pltfm_suspend, sdhci_pltfm_resume)
+	SET_RUNTIME_PM_OPS(sdhci_esdhc_runtime_suspend,
+				sdhci_esdhc_runtime_resume, NULL)
+};
+
 static struct platform_driver sdhci_esdhc_imx_driver = {
 	.driver		= {
 		.name	= "sdhci-esdhc-imx",
 		.owner	= THIS_MODULE,
 		.of_match_table = imx_esdhc_dt_ids,
-		.pm	= SDHCI_PLTFM_PMOPS,
+		.pm	= &sdhci_esdhc_pmops,
 	},
 	.id_table	= imx_esdhc_devtype,
 	.probe		= sdhci_esdhc_imx_probe,
-- 
1.7.2.rc3


