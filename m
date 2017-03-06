From: Piotr Sroka <piotrs@cadence.com>
Subject: [v2 PATCH 3/3] mmc: sdhci-cadence: Update PHY delay configuration
Date: Mon, 6 Mar 2017 13:39:47 +0000
Message-ID: <1488807587-5375-1-git-send-email-piotrs@cadence.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, linux-kernel@vger.kernel.org, Masahiro Yamada <yamada.masahiro@socionext.com>, Piotr Sroka <piotrs@cadence.com>
List-Id: linux-mmc@vger.kernel.org

PHY settings can be different for different platforms and SoCs.
Fixed PHY input delays was replaced with SoC specific compatible data.
DTS properties are used for configuration new PHY DLL delays.

Signed-off-by: Piotr Sroka <piotrs@cadence.com>
---
Changes for v2:
- dts part was removed from this patch
- most delays were moved from dts file 
  to data associated with an SoC specific compatible
- remove unrelated changes
---

 drivers/mmc/host/sdhci-cadence.c | 124 ++++++++++++++++++++++++++++++++++++---
 1 file changed, 116 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/host/sdhci-cadence.c b/drivers/mmc/host/sdhci-cadence.c
index b2334ec..29b5d11 100644
--- a/drivers/mmc/host/sdhci-cadence.c
+++ b/drivers/mmc/host/sdhci-cadence.c
@@ -18,6 +18,7 @@
 #include <linux/module.h>
 #include <linux/mmc/host.h>
 #include <linux/mmc/mmc.h>
+#include <linux/of.h>
 
 #include "sdhci-pltfm.h"
 
@@ -54,6 +55,9 @@
 #define SDHCI_CDNS_PHY_DLY_EMMC_LEGACY	0x06
 #define SDHCI_CDNS_PHY_DLY_EMMC_SDR	0x07
 #define SDHCI_CDNS_PHY_DLY_EMMC_DDR	0x08
+#define SDHCI_CDNS_PHY_DLY_SDCLK	0x0b
+#define SDHCI_CDNS_PHY_DLY_HSMMC	0x0c
+#define SDHCI_CDNS_PHY_DLY_STROBE	0x0d
 
 /*
  * The tuned val register is 6 bit-wide, but not the whole of the range is
@@ -62,10 +66,24 @@
  */
 #define SDHCI_CDNS_MAX_TUNING_LOOP	40
 
+static const struct of_device_id sdhci_cdns_match[];
+
 struct sdhci_cdns_priv {
 	void __iomem *hrs_addr;
 };
 
+struct sdhci_cdns_config {
+	u8 phy_dly_sd_highspeed;
+	u8 phy_dly_sd_legacy;
+	u8 phy_dly_sd_uhs_sdr12;
+	u8 phy_dly_sd_uhs_sdr25;
+	u8 phy_dly_sd_uhs_sdr50;
+	u8 phy_dly_sd_uhs_ddr50;
+	u8 phy_dly_emmc_legacy;
+	u8 phy_dly_emmc_sdr;
+	u8 phy_dly_emmc_ddr;
+};
+
 static int sdhci_cdns_write_phy_reg(struct sdhci_cdns_priv *priv,
 				    u8 addr, u8 data)
 {
@@ -90,13 +108,77 @@ static int sdhci_cdns_write_phy_reg(struct sdhci_cdns_priv *priv,
 	return 0;
 }
 
-static void sdhci_cdns_phy_init(struct sdhci_cdns_priv *priv)
+static int sdhci_cdns_phy_in_delay_init(struct sdhci_cdns_priv *priv,
+					const struct sdhci_cdns_config *config)
+{
+	int ret = 0;
+
+	ret = sdhci_cdns_write_phy_reg(priv, SDHCI_CDNS_PHY_DLY_SD_HS,
+				       config->phy_dly_sd_highspeed);
+	if (ret)
+		return ret;
+	ret = sdhci_cdns_write_phy_reg(priv, SDHCI_CDNS_PHY_DLY_SD_DEFAULT,
+				       config->phy_dly_sd_legacy);
+	if (ret)
+		return ret;
+	ret = sdhci_cdns_write_phy_reg(priv, SDHCI_CDNS_PHY_DLY_UHS_SDR12,
+				       config->phy_dly_sd_uhs_sdr12);
+	if (ret)
+		return ret;
+	ret = sdhci_cdns_write_phy_reg(priv, SDHCI_CDNS_PHY_DLY_UHS_SDR25,
+				       config->phy_dly_sd_uhs_sdr25);
+	if (ret)
+		return ret;
+	ret = sdhci_cdns_write_phy_reg(priv, SDHCI_CDNS_PHY_DLY_UHS_SDR50,
+				       config->phy_dly_sd_uhs_sdr50);
+	if (ret)
+		return ret;
+	ret = sdhci_cdns_write_phy_reg(priv, SDHCI_CDNS_PHY_DLY_UHS_DDR50,
+				       config->phy_dly_sd_uhs_ddr50);
+	if (ret)
+		return ret;
+	ret = sdhci_cdns_write_phy_reg(priv, SDHCI_CDNS_PHY_DLY_EMMC_LEGACY,
+				       config->phy_dly_emmc_legacy);
+	if (ret)
+		return ret;
+	ret = sdhci_cdns_write_phy_reg(priv, SDHCI_CDNS_PHY_DLY_EMMC_SDR,
+				       config->phy_dly_emmc_sdr);
+	if (ret)
+		return ret;
+	ret = sdhci_cdns_write_phy_reg(priv, SDHCI_CDNS_PHY_DLY_EMMC_DDR,
+				       config->phy_dly_emmc_ddr);
+	if (ret)
+		return ret;
+	return 0;
+}
+
+static int sdhci_cdns_phy_dll_delay_parse_dt(struct device_node *np,
+					     struct sdhci_cdns_priv *priv)
 {
-	sdhci_cdns_write_phy_reg(priv, SDHCI_CDNS_PHY_DLY_SD_HS, 4);
-	sdhci_cdns_write_phy_reg(priv, SDHCI_CDNS_PHY_DLY_SD_DEFAULT, 4);
-	sdhci_cdns_write_phy_reg(priv, SDHCI_CDNS_PHY_DLY_EMMC_LEGACY, 9);
-	sdhci_cdns_write_phy_reg(priv, SDHCI_CDNS_PHY_DLY_EMMC_SDR, 2);
-	sdhci_cdns_write_phy_reg(priv, SDHCI_CDNS_PHY_DLY_EMMC_DDR, 3);
+	u32 tmp;
+	int ret;
+
+	if (!of_property_read_u32(np, "phy-dll-delay-sdclk", &tmp)) {
+		ret = sdhci_cdns_write_phy_reg(priv,
+					       SDHCI_CDNS_PHY_DLY_SDCLK, tmp);
+
+		if (ret)
+			return ret;
+	}
+	if (!of_property_read_u32(np, "phy-dll-delay-sdclk-hsmmc", &tmp)) {
+		ret = sdhci_cdns_write_phy_reg(priv,
+					       SDHCI_CDNS_PHY_DLY_HSMMC, tmp);
+		if (ret)
+			return ret;
+	}
+	if (!of_property_read_u32(np, "phy-dll-delay-strobe", &tmp)) {
+		ret = sdhci_cdns_write_phy_reg(priv,
+					       SDHCI_CDNS_PHY_DLY_STROBE, tmp);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
 }
 
 static inline void *sdhci_cdns_priv(struct sdhci_host *host)
@@ -227,6 +309,8 @@ static int sdhci_cdns_probe(struct platform_device *pdev)
 	struct sdhci_cdns_priv *priv;
 	struct clk *clk;
 	int ret;
+	struct device *dev = &pdev->dev;
+	const struct of_device_id *match;
 
 	clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(clk))
@@ -254,7 +338,16 @@ static int sdhci_cdns_probe(struct platform_device *pdev)
 	if (ret)
 		goto free;
 
-	sdhci_cdns_phy_init(priv);
+	match = of_match_node(sdhci_cdns_match, dev->of_node);
+	if (match && match->data) {
+		ret = sdhci_cdns_phy_in_delay_init(priv, match->data);
+		if (ret)
+			goto free;
+	}
+
+	ret = sdhci_cdns_phy_dll_delay_parse_dt(dev->of_node, priv);
+	if (ret)
+		goto free;
 
 	ret = sdhci_add_host(host);
 	if (ret)
@@ -269,8 +362,23 @@ static int sdhci_cdns_probe(struct platform_device *pdev)
 	return ret;
 }
 
+static const struct sdhci_cdns_config sdhci_cdns_uniphier_config = {
+	.phy_dly_sd_highspeed = 4,
+	.phy_dly_sd_legacy = 4,
+	.phy_dly_sd_uhs_sdr12 = 0,
+	.phy_dly_sd_uhs_sdr25 = 0,
+	.phy_dly_sd_uhs_sdr50 = 0,
+	.phy_dly_sd_uhs_ddr50 = 0,
+	.phy_dly_emmc_legacy = 9,
+	.phy_dly_emmc_sdr = 2,
+	.phy_dly_emmc_ddr = 3,
+};
+
 static const struct of_device_id sdhci_cdns_match[] = {
-	{ .compatible = "socionext,uniphier-sd4hc" },
+	{
+		.compatible = "socionext,uniphier-sd4hc",
+		.data = &sdhci_cdns_uniphier_config
+	},
 	{ .compatible = "cdns,sd4hc" },
 	{ /* sentinel */ }
 };
-- 
2.2.2
