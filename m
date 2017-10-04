From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH 3/7] mmc: sdhci-s3c: Fix driver data for Exynos4 SoCs
Date: Wed, 04 Oct 2017 08:38:24 +0200
Message-ID: <20171004063828.22068-4-m.szyprowski@samsung.com>
References: <20171004063828.22068-1-m.szyprowski@samsung.com>
        <CGME20171004063835eucas1p1082954a0113f374f11ff364cf4b95408@eucas1p1.samsung.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.w1.samsung.com ([210.118.77.11]:32952 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751249AbdJDGij (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 4 Oct 2017 02:38:39 -0400
In-reply-to: <20171004063828.22068-1-m.szyprowski@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-samsung-soc@vger.kernel.org, linux-mmc@vger.kernel.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Jaehoon Chung <jh80.chung@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>

Support for non-dt based initialization for Exynos SoCs has been removed,
so there is no need to keep driver IDs for this case. While touching this,
replace odd conditional code for instantiating driver data for Exynos4
SoCs with a simple reference and move that driver data under CONFIG_OF.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/mmc/host/sdhci-s3c.c | 18 +++++-------------
 1 file changed, 5 insertions(+), 13 deletions(-)

diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
index d328fcf284d1..cda83ccb2702 100644
--- a/drivers/mmc/host/sdhci-s3c.c
+++ b/drivers/mmc/host/sdhci-s3c.c
@@ -761,32 +761,24 @@ static const struct dev_pm_ops sdhci_s3c_pmops = {
 			   NULL)
 };
 
-#if defined(CONFIG_CPU_EXYNOS4210) || defined(CONFIG_SOC_EXYNOS4212)
-static struct sdhci_s3c_drv_data exynos4_sdhci_drv_data = {
-	.no_divider = true,
-};
-#define EXYNOS4_SDHCI_DRV_DATA ((kernel_ulong_t)&exynos4_sdhci_drv_data)
-#else
-#define EXYNOS4_SDHCI_DRV_DATA ((kernel_ulong_t)NULL)
-#endif
-
 static const struct platform_device_id sdhci_s3c_driver_ids[] = {
 	{
 		.name		= "s3c-sdhci",
 		.driver_data	= (kernel_ulong_t)NULL,
-	}, {
-		.name		= "exynos4-sdhci",
-		.driver_data	= EXYNOS4_SDHCI_DRV_DATA,
 	},
 	{ }
 };
 MODULE_DEVICE_TABLE(platform, sdhci_s3c_driver_ids);
 
 #ifdef CONFIG_OF
+static struct sdhci_s3c_drv_data exynos4_sdhci_drv_data = {
+	.no_divider = true,
+};
+
 static const struct of_device_id sdhci_s3c_dt_match[] = {
 	{ .compatible = "samsung,s3c6410-sdhci", },
 	{ .compatible = "samsung,exynos4210-sdhci",
-		.data = (void *)EXYNOS4_SDHCI_DRV_DATA },
+		.data = &exynos4_sdhci_drv_data },
 	{},
 };
 MODULE_DEVICE_TABLE(of, sdhci_s3c_dt_match);
-- 
2.14.2

