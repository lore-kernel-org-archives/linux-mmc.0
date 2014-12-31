From: Alim Akhtar <alim.akhtar@samsung.com>
Subject: [PATCH v3 1/4] mmc: dw_mmc: exynos: incorporate ciu_div into timing
 property
Date: Wed, 31 Dec 2014 12:13:02 +0530
Message-ID: <1420008185-24758-2-git-send-email-alim.akhtar@samsung.com>
References: <1420008185-24758-1-git-send-email-alim.akhtar@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1420008185-24758-1-git-send-email-alim.akhtar@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: chris@printf.net, ulf.hansson@linaro.org, jh80.chung@samsung.com, tgih.jun@samsung.com, dianders@chromium.org, alim.akhtar@gmail.com, kgene@kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-samsung-soc@vger.kernel.org, a.kesavan@samsung.com
List-Id: linux-mmc@vger.kernel.org

From: Seungwon Jeon <tgih.jun@samsung.com>

ciu_div may not be common value for all speed mode.
So, it needs to be attached to CLKSEL timing.
This also introduce a new compatibale 'dw-mshc-hs200-timing'
for selecting hs200 timing value

Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>
Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
---
 .../devicetree/bindings/mmc/exynos-dw-mshc.txt     |   15 ++--
 drivers/mmc/host/dw_mmc-exynos.c                   |   81 ++++++++++++++------
 drivers/mmc/host/dw_mmc-exynos.h                   |    1 +
 3 files changed, 67 insertions(+), 30 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/exynos-dw-mshc.txt b/Documentation/devicetree/bindings/mmc/exynos-dw-mshc.txt
index ee4fc05..06455de 100644
--- a/Documentation/devicetree/bindings/mmc/exynos-dw-mshc.txt
+++ b/Documentation/devicetree/bindings/mmc/exynos-dw-mshc.txt
@@ -23,10 +23,6 @@ Required Properties:
 	- "samsung,exynos7-dw-mshc-smu": for controllers with Samsung Exynos7
 	  specific extensions having an SMU.
 
-* samsung,dw-mshc-ciu-div: Specifies the divider value for the card interface
-  unit (ciu) clock. This property is applicable only for Exynos5 SoC's and
-  ignored for Exynos4 SoC's. The valid range of divider value is 0 to 7.
-
 * samsung,dw-mshc-sdr-timing: Specifies the value of CIU clock phase shift value
   in transmit mode and CIU clock phase shift value in receive mode for single
   data rate mode operation. Refer notes below for the order of the cells and the
@@ -37,11 +33,16 @@ Required Properties:
   data rate mode operation. Refer notes below for the order of the cells and the
   valid values.
 
+* samsung,dw-mshc-hs200-timing: Similar with dw-mshc-sdr-timing.
+
   Notes for the sdr-timing and ddr-timing values:
 
     The order of the cells should be
       - First Cell: CIU clock phase shift value for tx mode.
       - Second Cell: CIU clock phase shift value for rx mode.
+      - Thrid Cell: Specifies the divider value for the card interface
+        unit (ciu) clock. This property is applicable only for Exynos5 SoC's and
+        ignored for Exynos4 SoC's. The valid range of divider value is 0 to 7.
 
     Valid values for SDR and DDR CIU clock timing for Exynos5250:
       - valid value for tx phase shift and rx phase shift is 0 to 7.
@@ -79,8 +80,8 @@ Example:
 		broken-cd;
 		fifo-depth = <0x80>;
 		card-detect-delay = <200>;
-		samsung,dw-mshc-ciu-div = <3>;
-		samsung,dw-mshc-sdr-timing = <2 3>;
-		samsung,dw-mshc-ddr-timing = <1 2>;
+		samsung,dw-mshc-sdr-timing = <2 3 3>;
+		samsung,dw-mshc-ddr-timing = <1 2 3>;
+		samsung,dw-mshc-hs200-timing = <0 2 3>;
 		bus-width = <8>;
 	};
diff --git a/drivers/mmc/host/dw_mmc-exynos.c b/drivers/mmc/host/dw_mmc-exynos.c
index 12a5eaa..be6530e 100644
--- a/drivers/mmc/host/dw_mmc-exynos.c
+++ b/drivers/mmc/host/dw_mmc-exynos.c
@@ -40,6 +40,7 @@ struct dw_mci_exynos_priv_data {
 	u8				ciu_div;
 	u32				sdr_timing;
 	u32				ddr_timing;
+	u32				hs200_timing;
 	u32				cur_speed;
 };
 
@@ -71,6 +72,21 @@ static struct dw_mci_exynos_compatible {
 	},
 };
 
+static inline u8 dw_mci_exynos_get_ciu_div(struct dw_mci *host)
+{
+	struct dw_mci_exynos_priv_data *priv = host->priv;
+
+	if (priv->ctrl_type == DW_MCI_TYPE_EXYNOS4412)
+		return EXYNOS4412_FIXED_CIU_CLK_DIV;
+	else if (priv->ctrl_type == DW_MCI_TYPE_EXYNOS4210)
+		return EXYNOS4210_FIXED_CIU_CLK_DIV;
+	else if (priv->ctrl_type == DW_MCI_TYPE_EXYNOS7 ||
+			priv->ctrl_type == DW_MCI_TYPE_EXYNOS7_SMU)
+		return SDMMC_CLKSEL_GET_DIV(mci_readl(host, CLKSEL64)) + 1;
+	else
+		return SDMMC_CLKSEL_GET_DIV(mci_readl(host, CLKSEL)) + 1;
+}
+
 static int dw_mci_exynos_priv_init(struct dw_mci *host)
 {
 	struct dw_mci_exynos_priv_data *priv = host->priv;
@@ -85,6 +101,8 @@ static int dw_mci_exynos_priv_init(struct dw_mci *host)
 			   SDMMC_MPSCTRL_NON_SECURE_WRITE_BIT);
 	}
 
+	priv->ciu_div = dw_mci_exynos_get_ciu_div(host);
+
 	return 0;
 }
 
@@ -92,7 +110,7 @@ static int dw_mci_exynos_setup_clock(struct dw_mci *host)
 {
 	struct dw_mci_exynos_priv_data *priv = host->priv;
 
-	host->bus_hz /= (priv->ciu_div + 1);
+	host->bus_hz /= priv->ciu_div;
 
 	return 0;
 }
@@ -177,9 +195,14 @@ static void dw_mci_exynos_set_ios(struct dw_mci *host, struct mmc_ios *ios)
 	struct dw_mci_exynos_priv_data *priv = host->priv;
 	unsigned int wanted = ios->clock;
 	unsigned long actual;
-	u8 div = priv->ciu_div + 1;
 
-	if (ios->timing == MMC_TIMING_MMC_DDR52) {
+	if (ios->timing == MMC_TIMING_MMC_HS200) {
+		if (priv->ctrl_type == DW_MCI_TYPE_EXYNOS7 ||
+			priv->ctrl_type == DW_MCI_TYPE_EXYNOS7_SMU)
+			mci_writel(host, CLKSEL64, priv->hs200_timing);
+		else
+			mci_writel(host, CLKSEL, priv->hs200_timing);
+	} else if (ios->timing == MMC_TIMING_MMC_DDR52) {
 		if (priv->ctrl_type == DW_MCI_TYPE_EXYNOS7 ||
 			priv->ctrl_type == DW_MCI_TYPE_EXYNOS7_SMU)
 			mci_writel(host, CLKSEL64, priv->ddr_timing);
@@ -208,6 +231,7 @@ static void dw_mci_exynos_set_ios(struct dw_mci *host, struct mmc_ios *ios)
 		wanted = EXYNOS_CCLKIN_MIN;
 
 	if (wanted != priv->cur_speed) {
+		u8 div = dw_mci_exynos_get_ciu_div(host);
 		int ret = clk_set_rate(host->ciu_clk, wanted * div);
 		if (ret)
 			dev_warn(host->dev,
@@ -220,14 +244,34 @@ static void dw_mci_exynos_set_ios(struct dw_mci *host, struct mmc_ios *ios)
 	}
 }
 
+static int dw_mci_exynos_dt_populate_timing(struct dw_mci *host,
+					    unsigned int ctrl_type,
+					    const char *propname,
+					    u32 *out_values)
+{
+	struct device_node *np = host->dev->of_node;
+	u32 timing[3];
+	int ret;
+
+	ret = of_property_read_u32_array(np, propname, timing, 3);
+	if (ret)
+		return ret;
+
+	if (ctrl_type == DW_MCI_TYPE_EXYNOS4412 ||
+	    ctrl_type == DW_MCI_TYPE_EXYNOS4210)
+		timing[2] = 0;
+
+	*out_values = SDMMC_CLKSEL_TIMING(timing[0], timing[1], timing[2]);
+
+	return 0;
+}
+
+
 static int dw_mci_exynos_parse_dt(struct dw_mci *host)
 {
 	struct dw_mci_exynos_priv_data *priv;
 	struct device_node *np = host->dev->of_node;
-	u32 timing[2];
-	u32 div = 0;
-	int idx;
-	int ret;
+	int idx, ret;
 
 	priv = devm_kzalloc(host->dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
@@ -238,29 +282,20 @@ static int dw_mci_exynos_parse_dt(struct dw_mci *host)
 			priv->ctrl_type = exynos_compat[idx].ctrl_type;
 	}
 
-	if (priv->ctrl_type == DW_MCI_TYPE_EXYNOS4412)
-		priv->ciu_div = EXYNOS4412_FIXED_CIU_CLK_DIV - 1;
-	else if (priv->ctrl_type == DW_MCI_TYPE_EXYNOS4210)
-		priv->ciu_div = EXYNOS4210_FIXED_CIU_CLK_DIV - 1;
-	else {
-		of_property_read_u32(np, "samsung,dw-mshc-ciu-div", &div);
-		priv->ciu_div = div;
-	}
-
-	ret = of_property_read_u32_array(np,
-			"samsung,dw-mshc-sdr-timing", timing, 2);
+	ret = dw_mci_exynos_dt_populate_timing(host, priv->ctrl_type,
+			"samsung,dw-mshc-sdr-timing", &priv->sdr_timing);
 	if (ret)
 		return ret;
 
-	priv->sdr_timing = SDMMC_CLKSEL_TIMING(timing[0], timing[1], div);
-
-	ret = of_property_read_u32_array(np,
-			"samsung,dw-mshc-ddr-timing", timing, 2);
+	ret = dw_mci_exynos_dt_populate_timing(host, priv->ctrl_type,
+			"samsung,dw-mshc-ddr-timing", &priv->ddr_timing);
 	if (ret)
 		return ret;
 
-	priv->ddr_timing = SDMMC_CLKSEL_TIMING(timing[0], timing[1], div);
+	dw_mci_exynos_dt_populate_timing(host, priv->ctrl_type,
+		"samsung,dw-mshc-hs200-timing", &priv->hs200_timing);
 	host->priv = priv;
+
 	return 0;
 }
 
diff --git a/drivers/mmc/host/dw_mmc-exynos.h b/drivers/mmc/host/dw_mmc-exynos.h
index 7872ce5..c04ecef 100644
--- a/drivers/mmc/host/dw_mmc-exynos.h
+++ b/drivers/mmc/host/dw_mmc-exynos.h
@@ -21,6 +21,7 @@
 #define SDMMC_CLKSEL_CCLK_DRIVE(x)	(((x) & 7) << 16)
 #define SDMMC_CLKSEL_CCLK_DIVIDER(x)	(((x) & 7) << 24)
 #define SDMMC_CLKSEL_GET_DRV_WD3(x)	(((x) >> 16) & 0x7)
+#define SDMMC_CLKSEL_GET_DIV(x)		(((x) >> 24) & 0x7)
 #define SDMMC_CLKSEL_TIMING(x, y, z)	(SDMMC_CLKSEL_CCLK_SAMPLE(x) |	\
 					 SDMMC_CLKSEL_CCLK_DRIVE(y) |	\
 					 SDMMC_CLKSEL_CCLK_DIVIDER(z))
-- 
1.7.9.5
