From: Faiz Abbas <faiz_abbas@ti.com>
Subject: [PATCH 3/4] mmc: sdhci_am654: Add Support for 4 bit IP on J721E
Date: Tue, 4 Jun 2019 11:39:13 +0530
Message-ID: <20190604060914.10886-4-faiz_abbas@ti.com>
References: <20190604060914.10886-1-faiz_abbas@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190604060914.10886-1-faiz_abbas@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org
Cc: nm@ti.com, ulf.hansson@linaro.org, robh+dt@kernel.org, nsekhar@ti.com, adrian.hunter@intel.com
List-Id: linux-mmc@vger.kernel.org

Add support for 4 bit instances on TI's J721E devices. Because these
instances have no DLL, introduce a DLL_PRESENT flag and make sure DLL
related registers are only accessed when it is present. Also add a
separate set_clock callback for this compatible.

Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
---
 drivers/mmc/host/sdhci_am654.c | 124 +++++++++++++++++++++++----------
 1 file changed, 86 insertions(+), 38 deletions(-)

diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
index 4575aeb435ec..3b3948144591 100644
--- a/drivers/mmc/host/sdhci_am654.c
+++ b/drivers/mmc/host/sdhci_am654.c
@@ -91,6 +91,7 @@ struct sdhci_am654_driver_data {
 #define IOMUX_PRESENT	(1 << 0)
 #define FREQSEL_2_BIT	(1 << 1)
 #define STRBSEL_4_BIT	(1 << 2)
+#define DLL_PRESENT	(1 << 3)
 };
 
 static void sdhci_am654_set_clock(struct sdhci_host *host, unsigned int clock)
@@ -188,6 +189,20 @@ static void sdhci_am654_set_clock(struct sdhci_host *host, unsigned int clock)
 	}
 }
 
+void sdhci_j721e_4bit_set_clock(struct sdhci_host *host, unsigned int clock)
+{
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct sdhci_am654_data *sdhci_am654 = sdhci_pltfm_priv(pltfm_host);
+	int val, mask;
+
+	mask = OTAPDLYENA_MASK | OTAPDLYSEL_MASK;
+	val = (1 << OTAPDLYENA_SHIFT) |
+	      (sdhci_am654->otap_del_sel << OTAPDLYSEL_SHIFT);
+	regmap_update_bits(sdhci_am654->base, PHY_CTRL4, mask, val);
+
+	sdhci_set_clock(host, clock);
+}
+
 static void sdhci_am654_set_power(struct sdhci_host *host, unsigned char mode,
 				  unsigned short vdd)
 {
@@ -240,7 +255,7 @@ static const struct sdhci_pltfm_data sdhci_am654_pdata = {
 
 static const struct sdhci_am654_driver_data sdhci_am654_drvdata = {
 	.pdata = &sdhci_am654_pdata,
-	.flags = IOMUX_PRESENT | FREQSEL_2_BIT | STRBSEL_4_BIT,
+	.flags = IOMUX_PRESENT | FREQSEL_2_BIT | STRBSEL_4_BIT | DLL_PRESENT,
 };
 
 struct sdhci_ops sdhci_j721e_8bit_ops = {
@@ -263,8 +278,31 @@ static const struct sdhci_pltfm_data sdhci_j721e_8bit_pdata = {
 
 static const struct sdhci_am654_driver_data sdhci_j721e_8bit_drvdata = {
 	.pdata = &sdhci_j721e_8bit_pdata,
+	.flags = DLL_PRESENT,
+};
+
+struct sdhci_ops sdhci_j721e_4bit_ops = {
+	.get_max_clock = sdhci_pltfm_clk_get_max_clock,
+	.get_timeout_clock = sdhci_pltfm_clk_get_max_clock,
+	.set_uhs_signaling = sdhci_set_uhs_signaling,
+	.set_bus_width = sdhci_set_bus_width,
+	.set_power = sdhci_am654_set_power,
+	.set_clock = sdhci_j721e_4bit_set_clock,
+	.write_b = sdhci_am654_write_b,
+	.reset = sdhci_reset,
+};
+
+static const struct sdhci_pltfm_data sdhci_j721e_4bit_pdata = {
+	.ops = &sdhci_j721e_4bit_ops,
+	.quirks = SDHCI_QUIRK_INVERTED_WRITE_PROTECT |
+		  SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12,
+	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
 };
 
+static const struct sdhci_am654_driver_data sdhci_j721e_4bit_drvdata = {
+	.pdata = &sdhci_j721e_4bit_pdata,
+	.flags = IOMUX_PRESENT,
+};
 static int sdhci_am654_init(struct sdhci_host *host)
 {
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
@@ -278,15 +316,19 @@ static int sdhci_am654_init(struct sdhci_host *host)
 	mask = OTAPDLYENA_MASK | OTAPDLYSEL_MASK;
 	regmap_update_bits(sdhci_am654->base, PHY_CTRL4, mask, 0x0);
 
-	regmap_read(sdhci_am654->base, PHY_STAT1, &val);
-	if (~val & CALDONE_MASK) {
-		/* Calibrate IO lines */
-		regmap_update_bits(sdhci_am654->base, PHY_CTRL1,
-				   PDB_MASK, PDB_MASK);
-		ret = regmap_read_poll_timeout(sdhci_am654->base, PHY_STAT1,
-					       val, val & CALDONE_MASK, 1, 20);
-		if (ret)
-			return ret;
+	if (sdhci_am654->flags & DLL_PRESENT) {
+		regmap_read(sdhci_am654->base, PHY_STAT1, &val);
+		if (~val & CALDONE_MASK) {
+			/* Calibrate IO lines */
+			regmap_update_bits(sdhci_am654->base, PHY_CTRL1,
+					   PDB_MASK, PDB_MASK);
+			ret = regmap_read_poll_timeout(sdhci_am654->base,
+						       PHY_STAT1, val,
+						       val & CALDONE_MASK,
+						       1, 20);
+			if (ret)
+				return ret;
+		}
 	}
 
 	/* Enable pins by setting IO mux to 0 */
@@ -311,40 +353,42 @@ static int sdhci_am654_get_of_property(struct platform_device *pdev,
 	int drv_strength;
 	int ret;
 
-	ret = device_property_read_u32(dev, "ti,trm-icp",
-				       &sdhci_am654->trm_icp);
-	if (ret)
-		return ret;
-
 	ret = device_property_read_u32(dev, "ti,otap-del-sel",
 				       &sdhci_am654->otap_del_sel);
 	if (ret)
 		return ret;
 
-	ret = device_property_read_u32(dev, "ti,driver-strength-ohm",
-				       &drv_strength);
-	if (ret)
-		return ret;
+	if (sdhci_am654->flags & DLL_PRESENT) {
+		ret = device_property_read_u32(dev, "ti,trm-icp",
+					       &sdhci_am654->trm_icp);
+		if (ret)
+			return ret;
+
+		ret = device_property_read_u32(dev, "ti,driver-strength-ohm",
+					       &drv_strength);
+		if (ret)
+			return ret;
 
-	switch (drv_strength) {
-	case 50:
-		sdhci_am654->drv_strength = DRIVER_STRENGTH_50_OHM;
-		break;
-	case 33:
-		sdhci_am654->drv_strength = DRIVER_STRENGTH_33_OHM;
-		break;
-	case 66:
-		sdhci_am654->drv_strength = DRIVER_STRENGTH_66_OHM;
-		break;
-	case 100:
-		sdhci_am654->drv_strength = DRIVER_STRENGTH_100_OHM;
-		break;
-	case 40:
-		sdhci_am654->drv_strength = DRIVER_STRENGTH_40_OHM;
-		break;
-	default:
-		dev_err(dev, "Invalid driver strength\n");
-		return -EINVAL;
+		switch (drv_strength) {
+		case 50:
+			sdhci_am654->drv_strength = DRIVER_STRENGTH_50_OHM;
+			break;
+		case 33:
+			sdhci_am654->drv_strength = DRIVER_STRENGTH_33_OHM;
+			break;
+		case 66:
+			sdhci_am654->drv_strength = DRIVER_STRENGTH_66_OHM;
+			break;
+		case 100:
+			sdhci_am654->drv_strength = DRIVER_STRENGTH_100_OHM;
+			break;
+		case 40:
+			sdhci_am654->drv_strength = DRIVER_STRENGTH_40_OHM;
+			break;
+		default:
+			dev_err(dev, "Invalid driver strength\n");
+			return -EINVAL;
+		}
 	}
 
 	device_property_read_u32(dev, "ti,strobe-sel", &sdhci_am654->strb_sel);
@@ -363,6 +407,10 @@ static const struct of_device_id sdhci_am654_of_match[] = {
 		.compatible = "ti,j721e-sdhci-8bit",
 		.data = &sdhci_j721e_8bit_drvdata,
 	},
+	{
+		.compatible = "ti,j721e-sdhci-4bit",
+		.data = &sdhci_j721e_4bit_drvdata,
+	},
 	{ /* sentinel */ }
 };
 
-- 
2.19.2
