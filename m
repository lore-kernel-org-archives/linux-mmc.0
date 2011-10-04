From: Thomas Abraham <thomas.abraham@linaro.org>
Subject: [PATCH 1/3] mmc: sdhci-s3c: Remove usage of clk_type member in
 platform data
Date: Tue, 04 Oct 2011 12:58:33 +0530
Message-ID: <1317713315-5830-2-git-send-email-thomas.abraham@linaro.org>
References: <1317713315-5830-1-git-send-email-thomas.abraham@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:29590 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754581Ab1JDH2e (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 4 Oct 2011 03:28:34 -0400
In-reply-to: <1317713315-5830-1-git-send-email-thomas.abraham@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Cc: cjb@laptop.org, kgene.kim@samsung.com, linux-arm-kernel@lists.infradead.org, ben-linux@fluff.org, Jeongbae Seo <jeongbae.seo@samsung.com>

SDHCI controllers on Exynos4 do not include the sdclk divider as per the
sdhci controller specification. This case can be represented using the
sdhci quirk SDHCI_QUIRK_NONSTANDARD_CLOCK instead of using an additional
enum type definition 'clk_types'.

Hence, usage of clk_type member in platform data is removed and the sdhci
quirk is used. In addition to that, since this qurik is SoC specific,
driver data is introduced to represent controllers on SoC's that require
this quirk.

Cc: Ben Dooks <ben-linux@fluff.org>
Cc: Jeongbae Seo <jeongbae.seo@samsung.com>
Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
---
In the function 'sdhci_cmu_set_clock', the code that waits for a stable
sdclk clock is replicated from 'sdhci_set_clock' function. This portion
of code is replicated in sdhci-cns3xxx driver as well. This duplication
could have been avoid by adding a new function in sdhci host controller
driver that waits for stable sdclk and sdhci-s3c/sdhci-cns3xxx can be
the users of the new function. If adding a new function in sdhci host
controller driver is acceptable, an additional patch in this series
can be added that creates the new function that waits for stable sdclk.

 drivers/mmc/host/sdhci-s3c.c |   74 +++++++++++++++++++++++++++++++++++++++--
 1 files changed, 70 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
index 82709b6..b29e734 100644
--- a/drivers/mmc/host/sdhci-s3c.c
+++ b/drivers/mmc/host/sdhci-s3c.c
@@ -53,6 +53,18 @@ struct sdhci_s3c {
 	struct clk		*clk_bus[MAX_BUS_CLK];
 };
 
+/**
+ * struct sdhci_s3c_driver_data - S3C SDHCI platform specific driver data
+ * @sdhci_quirks: sdhci host specific quirks.
+ *
+ * Specifies platform specific configuration of sdhci controller.
+ * Note: A structure for driver specific platform data is used for future
+ * expansion of its usage.
+ */
+struct sdhci_s3c_drv_data {
+	unsigned int	sdhci_quirks;
+};
+
 static inline struct sdhci_s3c *to_s3c(struct sdhci_host *host)
 {
 	return sdhci_priv(host);
@@ -132,10 +144,10 @@ static unsigned int sdhci_s3c_consider_clock(struct sdhci_s3c *ourhost,
 		return UINT_MAX;
 
 	/*
-	 * Clock divider's step is different as 1 from that of host controller
-	 * when 'clk_type' is S3C_SDHCI_CLK_DIV_EXTERNAL.
+	 * If controller uses a non-standard clock division, find the best clock
+	 * speed possible with selected clock source and skip the division.
 	 */
-	if (ourhost->pdata->clk_type) {
+	if (ourhost->host->quirks & SDHCI_QUIRK_NONSTANDARD_CLOCK) {
 		rate = clk_round_rate(clksrc, wanted);
 		return wanted - rate;
 	}
@@ -272,6 +284,8 @@ static unsigned int sdhci_cmu_get_min_clock(struct sdhci_host *host)
 static void sdhci_cmu_set_clock(struct sdhci_host *host, unsigned int clock)
 {
 	struct sdhci_s3c *ourhost = to_s3c(host);
+	unsigned long timeout;
+	u16 clk = 0;
 
 	/* don't bother if the clock is going off */
 	if (clock == 0)
@@ -282,6 +296,25 @@ static void sdhci_cmu_set_clock(struct sdhci_host *host, unsigned int clock)
 	clk_set_rate(ourhost->clk_bus[ourhost->cur_clk], clock);
 
 	host->clock = clock;
+
+	clk = SDHCI_CLOCK_INT_EN;
+	sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
+
+	/* Wait max 20 ms */
+	timeout = 20;
+	while (!((clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL))
+		& SDHCI_CLOCK_INT_STABLE)) {
+		if (timeout == 0) {
+			printk(KERN_ERR "%s: Internal clock never "
+				"stabilised.\n", mmc_hostname(host->mmc));
+			return;
+		}
+		timeout--;
+		mdelay(1);
+	}
+
+	clk |= SDHCI_CLOCK_CARD_EN;
+	sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
 }
 
 /**
@@ -382,9 +415,17 @@ static void sdhci_s3c_setup_card_detect_gpio(struct sdhci_s3c *sc)
 	}
 }
 
+static inline struct sdhci_s3c_drv_data *sdhci_s3c_get_driver_data(
+			struct platform_device *pdev)
+{
+	return (struct sdhci_s3c_drv_data *)
+			platform_get_device_id(pdev)->driver_data;
+}
+
 static int __devinit sdhci_s3c_probe(struct platform_device *pdev)
 {
 	struct s3c_sdhci_platdata *pdata = pdev->dev.platform_data;
+	struct sdhci_s3c_drv_data *drv_data;
 	struct device *dev = &pdev->dev;
 	struct sdhci_host *host;
 	struct sdhci_s3c *sc;
@@ -414,6 +455,7 @@ static int __devinit sdhci_s3c_probe(struct platform_device *pdev)
 		return PTR_ERR(host);
 	}
 
+	drv_data = sdhci_s3c_get_driver_data(pdev);
 	sc = sdhci_priv(host);
 
 	sc->host = host;
@@ -494,6 +536,8 @@ static int __devinit sdhci_s3c_probe(struct platform_device *pdev)
 	/* Setup quirks for the controller */
 	host->quirks |= SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC;
 	host->quirks |= SDHCI_QUIRK_NO_HISPD_BIT;
+	if (drv_data)
+		host->quirks |= drv_data->sdhci_quirks;
 
 #ifndef CONFIG_MMC_SDHCI_S3C_DMA
 
@@ -534,7 +578,7 @@ static int __devinit sdhci_s3c_probe(struct platform_device *pdev)
 	 * If controller does not have internal clock divider,
 	 * we can use overriding functions instead of default.
 	 */
-	if (pdata->clk_type) {
+	if (host->quirks & SDHCI_QUIRK_NONSTANDARD_CLOCK) {
 		sdhci_s3c_ops.set_clock = sdhci_cmu_set_clock;
 		sdhci_s3c_ops.get_min_clock = sdhci_cmu_get_min_clock;
 		sdhci_s3c_ops.get_max_clock = sdhci_cmu_get_max_clock;
@@ -639,9 +683,31 @@ static int sdhci_s3c_resume(struct platform_device *dev)
 #define sdhci_s3c_resume NULL
 #endif
 
+#if defined(CONFIG_CPU_EXYNOS4210) || defined(CONFIG_SOC_EXYNOS4212)
+static struct sdhci_s3c_drv_data exynos4_sdhci_drv_data = {
+	.sdhci_quirks = SDHCI_QUIRK_NONSTANDARD_CLOCK,
+};
+#define EXYNOS4_SDHCI_DRV_DATA ((kernel_ulong_t)&exynos4_sdhci_drv_data)
+#else
+#define EXYNOS4_SDHCI_DRV_DATA (kernel_ulong_t)NULL
+#endif
+
+static struct platform_device_id sdhci_s3c_driver_ids[] = {
+	{
+		.name		= "s3c-sdhci",
+		.driver_data	= (kernel_ulong_t)NULL,
+	},
+	{
+		.name		= "exynos4-sdhci",
+		.driver_data	= EXYNOS4_SDHCI_DRV_DATA,
+	},
+};
+MODULE_DEVICE_TABLE(platform, sdhci_s3c_driver_ids);
+
 static struct platform_driver sdhci_s3c_driver = {
 	.probe		= sdhci_s3c_probe,
 	.remove		= __devexit_p(sdhci_s3c_remove),
+	.id_table	= sdhci_s3c_driver_ids,
 	.suspend	= sdhci_s3c_suspend,
 	.resume	        = sdhci_s3c_resume,
 	.driver		= {
-- 
1.6.6.rc2

