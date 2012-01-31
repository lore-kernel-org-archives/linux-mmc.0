From: Thomas Abraham <thomas.abraham@linaro.org>
Subject: [PATCH v3 1/6] mmc: sdhci-s3c: Remove usage of clk_type member in
 platform data
Date: Tue, 31 Jan 2012 23:26:11 +0530
Message-ID: <1328032576-9269-2-git-send-email-thomas.abraham@linaro.org>
References: <1328032576-9269-1-git-send-email-thomas.abraham@linaro.org>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1328032576-9269-1-git-send-email-thomas.abraham@linaro.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org
Cc: linux-arm-kernel@lists.infradead.org, cjb@laptop.org, grant.likely@secretlab.ca, rob.herring@calxeda.com, linux-samsung-soc@vger.kernel.org, kgene.kim@samsung.com, ben-linux@fluff.org, patches@linaro.org, Jeongbae Seo <jeongbae.seo@samsung.com>
List-Id: linux-mmc@vger.kernel.org

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
 drivers/mmc/host/sdhci-s3c.c |   74 +++++++++++++++++++++++++++++++++++++++--
 1 files changed, 70 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
index 1af756e..e1b685d 100644
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
@@ -491,6 +533,8 @@ static int __devinit sdhci_s3c_probe(struct platform_device *pdev)
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
@@ -647,9 +691,31 @@ static const struct dev_pm_ops sdhci_s3c_pmops = {
 #define SDHCI_S3C_PMOPS NULL
 #endif
 
+#if defined(CONFIG_CPU_EXYNOS4210) || defined(CONFIG_SOC_EXYNOS4212)
+static struct sdhci_s3c_drv_data exynos4_sdhci_drv_data = {
+	.sdhci_quirks = SDHCI_QUIRK_NONSTANDARD_CLOCK,
+};
+#define EXYNOS4_SDHCI_DRV_DATA ((kernel_ulong_t)&exynos4_sdhci_drv_data)
+#else
+#define EXYNOS4_SDHCI_DRV_DATA ((kernel_ulong_t)NULL)
+#endif
+
+static struct platform_device_id sdhci_s3c_driver_ids[] = {
+	{
+		.name		= "s3c-sdhci",
+		.driver_data	= (kernel_ulong_t)NULL,
+	}, {
+		.name		= "exynos4-sdhci",
+		.driver_data	= EXYNOS4_SDHCI_DRV_DATA,
+	},
+	{ }
+};
+MODULE_DEVICE_TABLE(platform, sdhci_s3c_driver_ids);
+
 static struct platform_driver sdhci_s3c_driver = {
 	.probe		= sdhci_s3c_probe,
 	.remove		= __devexit_p(sdhci_s3c_remove),
+	.id_table	= sdhci_s3c_driver_ids,
 	.driver		= {
 		.owner	= THIS_MODULE,
 		.name	= "s3c-sdhci",
-- 
1.6.6.rc2
