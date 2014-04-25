From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [PATCH 26/32] mmc: sdhci-of-esdhc: remove
 platform_suspend/platform_resume callbacks
Date: Fri, 25 Apr 2014 14:26:53 +0100
Message-ID: <E1Wdg9V-00080X-DR@rmk-PC.arm.linux.org.uk>
References: <20140425132245.GO26756@n2100.arm.linux.org.uk>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from gw-1.arm.linux.org.uk ([78.32.30.217]:50680 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751311AbaDYN06 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 25 Apr 2014 09:26:58 -0400
In-Reply-To: <20140425132245.GO26756@n2100.arm.linux.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <chris@printf.net>, linux-mmc@vger.kernel.org, Markus Pargmann <mpa@pengutronix.de>
Cc: Ulf Hansson <ulf.hansson@linaro.org>

We don't need these hooks in order to insert code in these paths, we
can just provide our own handlers and call the main sdhci handlers as
appropriate.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/mmc/host/sdhci-of-esdhc.c | 55 +++++++++++++++++++++++++--------------
 1 file changed, 36 insertions(+), 19 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
index fcaeae5f55b8..605815e52f5f 100644
--- a/drivers/mmc/host/sdhci-of-esdhc.c
+++ b/drivers/mmc/host/sdhci-of-esdhc.c
@@ -241,20 +241,6 @@ static void esdhc_of_set_clock(struct sdhci_host *host, unsigned int clock)
 	mdelay(1);
 }
 
-#ifdef CONFIG_PM
-static u32 esdhc_proctl;
-static void esdhc_of_suspend(struct sdhci_host *host)
-{
-	esdhc_proctl = sdhci_be32bs_readl(host, SDHCI_HOST_CONTROL);
-}
-
-static void esdhc_of_resume(struct sdhci_host *host)
-{
-	esdhc_of_enable_dma(host);
-	sdhci_be32bs_writel(host, esdhc_proctl, SDHCI_HOST_CONTROL);
-}
-#endif
-
 static void esdhc_of_platform_init(struct sdhci_host *host)
 {
 	u32 vvn;
@@ -302,16 +288,47 @@ static const struct sdhci_ops sdhci_esdhc_ops = {
 	.get_max_clock = esdhc_of_get_max_clock,
 	.get_min_clock = esdhc_of_get_min_clock,
 	.platform_init = esdhc_of_platform_init,
-#ifdef CONFIG_PM
-	.platform_suspend = esdhc_of_suspend,
-	.platform_resume = esdhc_of_resume,
-#endif
 	.adma_workaround = esdhci_of_adma_workaround,
 	.set_bus_width = esdhc_pltfm_set_bus_width,
 	.reset = sdhci_reset,
 	.set_uhs_signaling = sdhci_set_uhs_signaling,
 };
 
+#ifdef CONFIG_PM
+
+static u32 esdhc_proctl;
+static int esdhc_of_suspend(struct device *dev)
+{
+	struct sdhci_host *host = dev_get_drvdata(dev);
+
+	esdhc_proctl = sdhci_be32bs_readl(host, SDHCI_HOST_CONTROL);
+
+	return sdhci_suspend_host(host);
+}
+
+static void esdhc_of_resume(device *dev)
+{
+	struct sdhci_host *host = dev_get_drvdata(dev);
+	int ret = sdhci_resume_host(host);
+
+	if (ret == 0) {
+		/* Isn't this already done by sdhci_resume_host() ? --rmk */
+		esdhc_of_enable_dma(host);
+		sdhci_be32bs_writel(host, esdhc_proctl, SDHCI_HOST_CONTROL);
+	}
+
+	return ret;
+}
+
+static const struct dev_pm_ops esdhc_pmops = {
+	.suspend	= esdhci_of_suspend,
+	.resume		= esdhci_of_resume,
+};
+#define ESDHC_PMOPS (&esdhc_pmops)
+#else
+#define ESDHC_PMOPS NULL
+#endif
+
 static const struct sdhci_pltfm_data sdhci_esdhc_pdata = {
 	/*
 	 * card detection could be handled via GPIO
@@ -373,7 +390,7 @@ static struct platform_driver sdhci_esdhc_driver = {
 		.name = "sdhci-esdhc",
 		.owner = THIS_MODULE,
 		.of_match_table = sdhci_esdhc_of_match,
-		.pm = SDHCI_PLTFM_PMOPS,
+		.pm = ESDHC_PMOPS,
 	},
 	.probe = sdhci_esdhc_probe,
 	.remove = sdhci_esdhc_remove,
-- 
1.8.3.1

