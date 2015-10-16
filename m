From: Ludovic Desroches <ludovic.desroches@atmel.com>
Subject: [PATCH] mmc: sdhci at91: add suspend/resume
Date: Fri, 16 Oct 2015 17:01:27 +0200
Message-ID: <1445007687-1530-1-git-send-email-ludovic.desroches@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eusmtp01.atmel.com ([212.144.249.242]:16181 "EHLO
	eusmtp01.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932123AbbJPPBL (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 16 Oct 2015 11:01:11 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, nicolas.ferre@atmel.com, Ludovic Desroches <ludovic.desroches@atmel.com>

Add suspend and resume PM ops.

Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
---
 drivers/mmc/host/sdhci-of-at91.c | 55 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 54 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-of-at91.c b/drivers/mmc/host/sdhci-of-at91.c
index 06d0b50..b9751f2 100644
--- a/drivers/mmc/host/sdhci-of-at91.c
+++ b/drivers/mmc/host/sdhci-of-at91.c
@@ -51,6 +51,59 @@ static const struct of_device_id sdhci_at91_dt_match[] = {
 	{}
 };
 
+#ifdef CONFIG_PM_SLEEP
+static int sdhci_at91_suspend(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct sdhci_host *host = platform_get_drvdata(pdev);
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct sdhci_at91_priv *priv = pltfm_host->priv;
+	int ret;
+
+	ret = sdhci_suspend_host(host);
+	if (ret)
+		return ret;
+
+	clk_disable_unprepare(priv->gck);
+	clk_disable_unprepare(priv->hclock);
+	clk_disable_unprepare(priv->mainck);
+
+	return 0;
+}
+
+static int sdhci_at91_resume(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct sdhci_host *host = platform_get_drvdata(pdev);
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct sdhci_at91_priv *priv = pltfm_host->priv;
+	int ret;
+
+	ret = clk_prepare_enable(priv->mainck);
+	if (ret) {
+		dev_err(dev, "can't enable mainck\n");
+		return ret;
+	}
+
+	ret = clk_prepare_enable(priv->hclock);
+	if (ret) {
+		dev_err(dev, "can't enable hclock\n");
+		return ret;
+	}
+
+	ret = clk_prepare_enable(priv->gck);
+	if (ret) {
+		dev_err(dev, "can't enable gck\n");
+		return ret;
+	}
+
+	return sdhci_resume_host(host);
+}
+#endif /* CONFIG_PM_SLEEP */
+
+static SIMPLE_DEV_PM_OPS(sdhci_at91_dev_pm_ops, sdhci_at91_suspend,
+			 sdhci_at91_resume);
+
 static int sdhci_at91_probe(struct platform_device *pdev)
 {
 	const struct of_device_id	*match;
@@ -178,7 +231,7 @@ static struct platform_driver sdhci_at91_driver = {
 	.driver		= {
 		.name	= "sdhci-at91",
 		.of_match_table = sdhci_at91_dt_match,
-		.pm	= SDHCI_PLTFM_PMOPS,
+		.pm	= &sdhci_at91_dev_pm_ops,
 	},
 	.probe		= sdhci_at91_probe,
 	.remove		= sdhci_at91_remove,
-- 
2.5.0

