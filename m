From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: [PATCH 11/22] mmc: dw_mmc: exynos: adjust the clock rate with speed
 mode
Date: Sat, 31 Aug 2013 00:13:03 +0900
Message-ID: <000e01cea593$6c05ad50$441107f0$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:46280 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756321Ab3H3PNE (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 30 Aug 2013 11:13:04 -0400
Received: from epcpsbgr3.samsung.com
 (u143.gpu120.samsung.co.kr [203.254.230.143])
 by mailout3.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MSC0023TNLRN5N0@mailout3.samsung.com> for
 linux-mmc@vger.kernel.org; Sat, 31 Aug 2013 00:13:03 +0900 (KST)
References: 
In-reply-to: 
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: 'Chris Ball' <cjb@laptop.org>, 'Jaehoon Chung' <jh80.chung@samsung.com>

Exynos's host has divider logic before 'cclk_in' to controller core.
It means that actual clock rate of ciu clock comes from this divider
value. So, source clock should be adjusted along with 'ciu_div' which
indicates the host's divider ratio. Setting clock rate basically fits
the required speed. Specially, 'cclk_in' should have double rate of
target speed in case of DDR 8-bit mode.

Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>
Tested-by: Alim Akhtar <alim.akhtar@samsung.com>
---
 drivers/mmc/host/dw_mmc-exynos.c |   55 +++++++++++++++++++++++++++++---------
 1 files changed, 42 insertions(+), 13 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc-exynos.c b/drivers/mmc/host/dw_mmc-exynos.c
index b86f518..d42e664 100644
--- a/drivers/mmc/host/dw_mmc-exynos.c
+++ b/drivers/mmc/host/dw_mmc-exynos.c
@@ -56,6 +56,8 @@
 #define DWMCI_MPSCTRL_ENCRYPTION		BIT(1)
 #define DWMCI_MPSCTRL_VALID			BIT(0)
 
+#define EXYNOS_CCLKIN_MIN	50000000	/* unit: HZ */
+
 /* Variations in Exynos specific dw-mshc controller */
 enum dw_mci_exynos_type {
 	DW_MCI_TYPE_EXYNOS4210,
@@ -71,6 +73,7 @@ struct dw_mci_exynos_priv_data {
 	u8				ciu_div;
 	u32				sdr_timing;
 	u32				ddr_timing;
+	u32				cur_speed;
 };
 
 static struct dw_mci_exynos_compatible {
@@ -114,16 +117,9 @@ static int dw_mci_exynos_priv_init(struct dw_mci *host)
 static int dw_mci_exynos_setup_clock(struct dw_mci *host)
 {
 	struct dw_mci_exynos_priv_data *priv = host->priv;
+	unsigned long rate = clk_get_rate(host->ciu_clk);
 
-	if (priv->ctrl_type == DW_MCI_TYPE_EXYNOS5250 ||
-	    priv->ctrl_type == DW_MCI_TYPE_EXYNOS5420 ||
-	    priv->ctrl_type == DW_MCI_TYPE_EXYNOS5420_SMU)
-		host->bus_hz /= (priv->ciu_div + 1);
-	else if (priv->ctrl_type == DW_MCI_TYPE_EXYNOS4412)
-		host->bus_hz /= EXYNOS4412_FIXED_CIU_CLK_DIV;
-	else if (priv->ctrl_type == DW_MCI_TYPE_EXYNOS4210)
-		host->bus_hz /= EXYNOS4210_FIXED_CIU_CLK_DIV;
-
+	host->bus_hz = rate / (priv->ciu_div + 1);
 	return 0;
 }
 
@@ -187,11 +183,38 @@ static void dw_mci_exynos_prepare_command(struct dw_mci *host, u32 *cmdr)
 static void dw_mci_exynos_set_ios(struct dw_mci *host, struct mmc_ios *ios)
 {
 	struct dw_mci_exynos_priv_data *priv = host->priv;
+	unsigned int wanted = ios->clock;
+	unsigned long actual;
+	u8 div = priv->ciu_div + 1;
 
-	if (ios->timing == MMC_TIMING_UHS_DDR50)
+	if (ios->timing == MMC_TIMING_UHS_DDR50) {
 		mci_writel(host, CLKSEL, priv->ddr_timing);
-	else
+		/* Should be double rate for DDR mode */
+		if (ios->bus_width == MMC_BUS_WIDTH_8)
+			wanted <<= 1;
+	} else {
 		mci_writel(host, CLKSEL, priv->sdr_timing);
+	}
+
+	/* Don't care if wanted clock is zero */
+	if (!wanted)
+		return;
+
+	/* Guaranteed minimum frequency for cclkin */
+	if (wanted < EXYNOS_CCLKIN_MIN)
+		wanted = EXYNOS_CCLKIN_MIN;
+
+	if (wanted != priv->cur_speed) {
+		int ret = clk_set_rate(host->ciu_clk, wanted * div);
+		if (ret)
+			dev_warn(host->dev,
+				"failed to set clk-rate %u error: %d\n",
+				 wanted * div, ret);
+		actual = clk_get_rate(host->ciu_clk);
+		host->bus_hz = actual / div;
+		priv->cur_speed = wanted;
+		host->current_speed = 0;
+	}
 }
 
 static int dw_mci_exynos_parse_dt(struct dw_mci *host)
@@ -214,8 +237,14 @@ static int dw_mci_exynos_parse_dt(struct dw_mci *host)
 			priv->ctrl_type = exynos_compat[idx].ctrl_type;
 	}
 
-	of_property_read_u32(np, "samsung,dw-mshc-ciu-div", &div);
-	priv->ciu_div = div;
+	if (priv->ctrl_type == DW_MCI_TYPE_EXYNOS4412)
+		priv->ciu_div = EXYNOS4412_FIXED_CIU_CLK_DIV - 1;
+	else if (priv->ctrl_type == DW_MCI_TYPE_EXYNOS4210)
+		priv->ciu_div = EXYNOS4210_FIXED_CIU_CLK_DIV - 1;
+	else {
+		of_property_read_u32(np, "samsung,dw-mshc-ciu-div", &div);
+		priv->ciu_div = div;
+	}
 
 	ret = of_property_read_u32_array(np,
 			"samsung,dw-mshc-sdr-timing", timing, 2);
-- 
1.7.0.4


