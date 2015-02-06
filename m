From: Kevin Hao <haokexin@gmail.com>
Subject: [PATCH 7/7] mmc: sdhci: set the .remove to sdhci_pltfm_unregister()
Date: Fri,  6 Feb 2015 11:15:22 +0800
Message-ID: <1423192522-6056-8-git-send-email-haokexin@gmail.com>
References: <1423192522-6056-1-git-send-email-haokexin@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yk0-f180.google.com ([209.85.160.180]:50266 "EHLO
	mail-yk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754398AbbBFDPz (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 5 Feb 2015 22:15:55 -0500
Received: by mail-yk0-f180.google.com with SMTP id 19so3317255ykq.11
        for <linux-mmc@vger.kernel.org>; Thu, 05 Feb 2015 19:15:54 -0800 (PST)
In-Reply-To: <1423192522-6056-1-git-send-email-haokexin@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hao <haokexin@gmail.com>

In these drivers, the driver specific .remove function just a simple
wrapper of function sdhci_pltfm_unregister(). So remove these wrappers
and just set .remove to sdhci_pltfm_unregister().

Signed-off-by: Kevin Hao <haokexin@gmail.com>
---
 drivers/mmc/host/sdhci-bcm-kona.c | 7 +------
 drivers/mmc/host/sdhci-bcm2835.c  | 7 +------
 drivers/mmc/host/sdhci-cns3xxx.c  | 7 +------
 drivers/mmc/host/sdhci-dove.c     | 7 +------
 drivers/mmc/host/sdhci-of-esdhc.c | 7 +------
 drivers/mmc/host/sdhci-of-hlwd.c  | 7 +------
 drivers/mmc/host/sdhci-sirf.c     | 9 +--------
 drivers/mmc/host/sdhci-st.c       | 7 +------
 drivers/mmc/host/sdhci-tegra.c    | 7 +------
 9 files changed, 9 insertions(+), 56 deletions(-)

diff --git a/drivers/mmc/host/sdhci-bcm-kona.c b/drivers/mmc/host/sdhci-bcm-kona.c
index 9313bf63d9b6..a773ff8be598 100644
--- a/drivers/mmc/host/sdhci-bcm-kona.c
+++ b/drivers/mmc/host/sdhci-bcm-kona.c
@@ -341,11 +341,6 @@ err_pltfm_free:
 	return ret;
 }
 
-static int sdhci_bcm_kona_remove(struct platform_device *pdev)
-{
-	return sdhci_pltfm_unregister(pdev);
-}
-
 static struct platform_driver sdhci_bcm_kona_driver = {
 	.driver		= {
 		.name	= "sdhci-kona",
@@ -353,7 +348,7 @@ static struct platform_driver sdhci_bcm_kona_driver = {
 		.of_match_table = sdhci_bcm_kona_of_match,
 	},
 	.probe		= sdhci_bcm_kona_probe,
-	.remove		= sdhci_bcm_kona_remove,
+	.remove		= sdhci_pltfm_unregister,
 };
 module_platform_driver(sdhci_bcm_kona_driver);
 
diff --git a/drivers/mmc/host/sdhci-bcm2835.c b/drivers/mmc/host/sdhci-bcm2835.c
index 439d259fdf1d..0ef0343c603a 100644
--- a/drivers/mmc/host/sdhci-bcm2835.c
+++ b/drivers/mmc/host/sdhci-bcm2835.c
@@ -180,11 +180,6 @@ err:
 	return ret;
 }
 
-static int bcm2835_sdhci_remove(struct platform_device *pdev)
-{
-	return sdhci_pltfm_unregister(pdev);
-}
-
 static const struct of_device_id bcm2835_sdhci_of_match[] = {
 	{ .compatible = "brcm,bcm2835-sdhci" },
 	{ }
@@ -198,7 +193,7 @@ static struct platform_driver bcm2835_sdhci_driver = {
 		.pm = SDHCI_PLTFM_PMOPS,
 	},
 	.probe = bcm2835_sdhci_probe,
-	.remove = bcm2835_sdhci_remove,
+	.remove = sdhci_pltfm_unregister,
 };
 module_platform_driver(bcm2835_sdhci_driver);
 
diff --git a/drivers/mmc/host/sdhci-cns3xxx.c b/drivers/mmc/host/sdhci-cns3xxx.c
index a7935a8d0922..59f2923f8054 100644
--- a/drivers/mmc/host/sdhci-cns3xxx.c
+++ b/drivers/mmc/host/sdhci-cns3xxx.c
@@ -98,18 +98,13 @@ static int sdhci_cns3xxx_probe(struct platform_device *pdev)
 	return sdhci_pltfm_register(pdev, &sdhci_cns3xxx_pdata, 0);
 }
 
-static int sdhci_cns3xxx_remove(struct platform_device *pdev)
-{
-	return sdhci_pltfm_unregister(pdev);
-}
-
 static struct platform_driver sdhci_cns3xxx_driver = {
 	.driver		= {
 		.name	= "sdhci-cns3xxx",
 		.pm	= SDHCI_PLTFM_PMOPS,
 	},
 	.probe		= sdhci_cns3xxx_probe,
-	.remove		= sdhci_cns3xxx_remove,
+	.remove		= sdhci_pltfm_unregister,
 };
 
 module_platform_driver(sdhci_cns3xxx_driver);
diff --git a/drivers/mmc/host/sdhci-dove.c b/drivers/mmc/host/sdhci-dove.c
index 2314ff88d942..407c21f152b2 100644
--- a/drivers/mmc/host/sdhci-dove.c
+++ b/drivers/mmc/host/sdhci-dove.c
@@ -108,11 +108,6 @@ err_sdhci_add:
 	return ret;
 }
 
-static int sdhci_dove_remove(struct platform_device *pdev)
-{
-	return sdhci_pltfm_unregister(pdev);
-}
-
 static const struct of_device_id sdhci_dove_of_match_table[] = {
 	{ .compatible = "marvell,dove-sdhci", },
 	{}
@@ -126,7 +121,7 @@ static struct platform_driver sdhci_dove_driver = {
 		.of_match_table = sdhci_dove_of_match_table,
 	},
 	.probe		= sdhci_dove_probe,
-	.remove		= sdhci_dove_remove,
+	.remove		= sdhci_pltfm_unregister,
 };
 
 module_platform_driver(sdhci_dove_driver);
diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
index 17fe02ed6672..22e9111b11ff 100644
--- a/drivers/mmc/host/sdhci-of-esdhc.c
+++ b/drivers/mmc/host/sdhci-of-esdhc.c
@@ -386,11 +386,6 @@ static int sdhci_esdhc_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int sdhci_esdhc_remove(struct platform_device *pdev)
-{
-	return sdhci_pltfm_unregister(pdev);
-}
-
 static const struct of_device_id sdhci_esdhc_of_match[] = {
 	{ .compatible = "fsl,mpc8379-esdhc" },
 	{ .compatible = "fsl,mpc8536-esdhc" },
@@ -406,7 +401,7 @@ static struct platform_driver sdhci_esdhc_driver = {
 		.pm = ESDHC_PMOPS,
 	},
 	.probe = sdhci_esdhc_probe,
-	.remove = sdhci_esdhc_remove,
+	.remove = sdhci_pltfm_unregister,
 };
 
 module_platform_driver(sdhci_esdhc_driver);
diff --git a/drivers/mmc/host/sdhci-of-hlwd.c b/drivers/mmc/host/sdhci-of-hlwd.c
index be479279a1d5..4079a96ad37e 100644
--- a/drivers/mmc/host/sdhci-of-hlwd.c
+++ b/drivers/mmc/host/sdhci-of-hlwd.c
@@ -75,11 +75,6 @@ static int sdhci_hlwd_probe(struct platform_device *pdev)
 	return sdhci_pltfm_register(pdev, &sdhci_hlwd_pdata, 0);
 }
 
-static int sdhci_hlwd_remove(struct platform_device *pdev)
-{
-	return sdhci_pltfm_unregister(pdev);
-}
-
 static const struct of_device_id sdhci_hlwd_of_match[] = {
 	{ .compatible = "nintendo,hollywood-sdhci" },
 	{ }
@@ -93,7 +88,7 @@ static struct platform_driver sdhci_hlwd_driver = {
 		.pm = SDHCI_PLTFM_PMOPS,
 	},
 	.probe = sdhci_hlwd_probe,
-	.remove = sdhci_hlwd_remove,
+	.remove = sdhci_pltfm_unregister,
 };
 
 module_platform_driver(sdhci_hlwd_driver);
diff --git a/drivers/mmc/host/sdhci-sirf.c b/drivers/mmc/host/sdhci-sirf.c
index 361952f958aa..e74e2fdcaeff 100644
--- a/drivers/mmc/host/sdhci-sirf.c
+++ b/drivers/mmc/host/sdhci-sirf.c
@@ -199,13 +199,6 @@ err_clk_prepare:
 	return ret;
 }
 
-static int sdhci_sirf_remove(struct platform_device *pdev)
-{
-	struct sdhci_host *host = platform_get_drvdata(pdev);
-
-	return sdhci_pltfm_unregister(pdev);
-}
-
 #ifdef CONFIG_PM_SLEEP
 static int sdhci_sirf_suspend(struct device *dev)
 {
@@ -255,7 +248,7 @@ static struct platform_driver sdhci_sirf_driver = {
 #endif
 	},
 	.probe		= sdhci_sirf_probe,
-	.remove		= sdhci_sirf_remove,
+	.remove		= sdhci_pltfm_unregister,
 };
 
 module_platform_driver(sdhci_sirf_driver);
diff --git a/drivers/mmc/host/sdhci-st.c b/drivers/mmc/host/sdhci-st.c
index 0019df452522..594a4ef3285b 100644
--- a/drivers/mmc/host/sdhci-st.c
+++ b/drivers/mmc/host/sdhci-st.c
@@ -113,11 +113,6 @@ err_of:
 	return ret;
 }
 
-static int sdhci_st_remove(struct platform_device *pdev)
-{
-	return sdhci_pltfm_unregister(pdev);
-}
-
 #ifdef CONFIG_PM_SLEEP
 static int sdhci_st_suspend(struct device *dev)
 {
@@ -155,7 +150,7 @@ MODULE_DEVICE_TABLE(of, st_sdhci_match);
 
 static struct platform_driver sdhci_st_driver = {
 	.probe = sdhci_st_probe,
-	.remove = sdhci_st_remove,
+	.remove = sdhci_pltfm_unregister,
 	.driver = {
 		   .name = "sdhci-st",
 		   .pm = &sdhci_st_pmops,
diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
index 12881e05ff30..2489bb753708 100644
--- a/drivers/mmc/host/sdhci-tegra.c
+++ b/drivers/mmc/host/sdhci-tegra.c
@@ -321,11 +321,6 @@ err_alloc_tegra_host:
 	return rc;
 }
 
-static int sdhci_tegra_remove(struct platform_device *pdev)
-{
-	return sdhci_pltfm_unregister(pdev);
-}
-
 static struct platform_driver sdhci_tegra_driver = {
 	.driver		= {
 		.name	= "sdhci-tegra",
@@ -333,7 +328,7 @@ static struct platform_driver sdhci_tegra_driver = {
 		.pm	= SDHCI_PLTFM_PMOPS,
 	},
 	.probe		= sdhci_tegra_probe,
-	.remove		= sdhci_tegra_remove,
+	.remove		= sdhci_pltfm_unregister,
 };
 
 module_platform_driver(sdhci_tegra_driver);
-- 
1.9.3

