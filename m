From: Lucas Stach <dev-8ppwABl0HbeELgA04lAiVw@public.gmane.org>
Subject: [PATCH 4/5] mmc: tegra: enable UHS-I modes
Date: Sat, 19 Dec 2015 20:16:03 +0100
Message-ID: <1450552564-32697-5-git-send-email-dev@lynxeye.de>
References: <1450552564-32697-1-git-send-email-dev@lynxeye.de>
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1450552564-32697-1-git-send-email-dev-8ppwABl0HbeELgA04lAiVw@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

Keep the quirk bits, as Tegra30 and Tegra114 host have different levels
of support for UHS-I modes and so need different spare bits to be set,
but change the logic to be positive.

Signed-off-by: Lucas Stach <dev-8ppwABl0HbeELgA04lAiVw@public.gmane.org>
---
 drivers/mmc/host/sdhci-tegra.c | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
index fd0529c..b5374d7 100644
--- a/drivers/mmc/host/sdhci-tegra.c
+++ b/drivers/mmc/host/sdhci-tegra.c
@@ -45,9 +45,9 @@
 #define NVQUIRK_FORCE_SDHCI_SPEC_200	BIT(0)
 #define NVQUIRK_ENABLE_BLOCK_GAP_DET	BIT(1)
 #define NVQUIRK_ENABLE_SDHCI_SPEC_300	BIT(2)
-#define NVQUIRK_DISABLE_SDR50		BIT(3)
-#define NVQUIRK_DISABLE_SDR104		BIT(4)
-#define NVQUIRK_DISABLE_DDR50		BIT(5)
+#define NVQUIRK_ENABLE_SDR50		BIT(3)
+#define NVQUIRK_ENABLE_SDR104		BIT(4)
+#define NVQUIRK_ENABLE_DDR50		BIT(5)
 
 struct sdhci_tegra_soc_data {
 	const struct sdhci_pltfm_data *pdata;
@@ -144,18 +144,18 @@ static void tegra_sdhci_reset(struct sdhci_host *host, u8 mask)
 	/* Erratum: Enable SDHCI spec v3.00 support */
 	if (soc_data->nvquirks & NVQUIRK_ENABLE_SDHCI_SPEC_300)
 		misc_ctrl |= SDHCI_MISC_CTRL_ENABLE_SDHCI_SPEC_300;
-	/* Don't advertise UHS modes which aren't supported yet */
-	if (soc_data->nvquirks & NVQUIRK_DISABLE_SDR50)
-		misc_ctrl &= ~SDHCI_MISC_CTRL_ENABLE_SDR50;
-	if (soc_data->nvquirks & NVQUIRK_DISABLE_DDR50)
-		misc_ctrl &= ~SDHCI_MISC_CTRL_ENABLE_DDR50;
-	if (soc_data->nvquirks & NVQUIRK_DISABLE_SDR104)
-		misc_ctrl &= ~SDHCI_MISC_CTRL_ENABLE_SDR104;
+	/* Advertise UHS modes as supported by host */
+	if (soc_data->nvquirks & NVQUIRK_ENABLE_SDR50)
+		misc_ctrl |= SDHCI_MISC_CTRL_ENABLE_SDR50;
+	if (soc_data->nvquirks & NVQUIRK_ENABLE_DDR50)
+		misc_ctrl |= SDHCI_MISC_CTRL_ENABLE_DDR50;
+	if (soc_data->nvquirks & NVQUIRK_ENABLE_SDR104)
+		misc_ctrl |= SDHCI_MISC_CTRL_ENABLE_SDR104;
 	sdhci_writew(host, misc_ctrl, SDHCI_TEGRA_VENDOR_MISC_CTRL);
 
 	clk_ctrl = sdhci_readl(host, SDHCI_TEGRA_VENDOR_CLOCK_CTRL);
 	clk_ctrl &= ~SDHCI_CLOCK_CTRL_SPI_MODE_CLKEN_OVERRIDE;
-	if (!(soc_data->nvquirks & NVQUIRK_DISABLE_SDR50))
+	if (soc_data->nvquirks & SDHCI_MISC_CTRL_ENABLE_SDR50)
 		clk_ctrl |= SDHCI_CLOCK_CTRL_SDR50_TUNING_OVERRIDE;
 	sdhci_writel(host, clk_ctrl, SDHCI_TEGRA_VENDOR_CLOCK_CTRL);
 
@@ -302,8 +302,8 @@ static const struct sdhci_pltfm_data sdhci_tegra30_pdata = {
 static struct sdhci_tegra_soc_data soc_data_tegra30 = {
 	.pdata = &sdhci_tegra30_pdata,
 	.nvquirks = NVQUIRK_ENABLE_SDHCI_SPEC_300 |
-		    NVQUIRK_DISABLE_SDR50 |
-		    NVQUIRK_DISABLE_SDR104,
+		    NVQUIRK_ENABLE_SDR50 |
+		    NVQUIRK_ENABLE_SDR104,
 };
 
 static const struct sdhci_ops tegra114_sdhci_ops = {
@@ -332,9 +332,9 @@ static const struct sdhci_pltfm_data sdhci_tegra114_pdata = {
 
 static struct sdhci_tegra_soc_data soc_data_tegra114 = {
 	.pdata = &sdhci_tegra114_pdata,
-	.nvquirks = NVQUIRK_DISABLE_SDR50 |
-		    NVQUIRK_DISABLE_DDR50 |
-		    NVQUIRK_DISABLE_SDR104,
+	.nvquirks = NVQUIRK_ENABLE_SDR50 |
+		    NVQUIRK_ENABLE_DDR50 |
+		    NVQUIRK_ENABLE_SDR104,
 };
 
 static const struct of_device_id sdhci_tegra_dt_match[] = {
@@ -380,7 +380,7 @@ static int sdhci_tegra_probe(struct platform_device *pdev)
 	if (rc)
 		goto err_parse_dt;
 
-	if (!(tegra_host->soc_data->nvquirks & NVQUIRK_DISABLE_DDR50))
+	if (tegra_host->soc_data->nvquirks & NVQUIRK_ENABLE_DDR50)
 		host->mmc->caps |= MMC_CAP_1_8V_DDR;
 
 	tegra_host->power_gpio = devm_gpiod_get_optional(&pdev->dev, "power",
-- 
2.5.0
