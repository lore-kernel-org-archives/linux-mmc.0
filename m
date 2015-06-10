From: Haibo Chen <haibo.chen@freescale.com>
Subject: [PATCH 1/6] mmc: sdhci-esdhc-imx: add imx7d support and support HS400
Date: Wed, 10 Jun 2015 16:50:39 +0800
Message-ID: <1433926244-29244-2-git-send-email-haibo.chen@freescale.com>
References: <1433926244-29244-1-git-send-email-haibo.chen@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bn1on0116.outbound.protection.outlook.com ([157.56.110.116]:61879
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753445AbbFJIsW (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 10 Jun 2015 04:48:22 -0400
In-Reply-To: <1433926244-29244-1-git-send-email-haibo.chen@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org, chris@printf.net, shawn.guo@linaro.org, aisheng.dong@freescale.com, haibo.chen@freescale.com, linux-arm-kernel@lists.infradead.org

The imx7d usdhc is derived from imx6sx, the difference is that
imx7d support HS400.

So introduce a new compatible string for imx7d and add HS400
support for imx7d usdhc.

Signed-off-by: Haibo Chen <haibo.chen@freescale.com>
---
 drivers/mmc/host/sdhci-esdhc-imx.c | 66 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index faf0cb9..763b928 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -44,6 +44,7 @@
 #define  ESDHC_MIX_CTRL_EXE_TUNE	(1 << 22)
 #define  ESDHC_MIX_CTRL_SMPCLK_SEL	(1 << 23)
 #define  ESDHC_MIX_CTRL_FBCLK_SEL	(1 << 25)
+#define  ESDHC_MIX_CTRL_HS400_EN	(1 << 26)
 /* Bits 3 and 6 are not SDHCI standard definitions */
 #define  ESDHC_MIX_CTRL_SDHCI_MASK	0xb7
 /* Tuning bits */
@@ -60,6 +61,16 @@
 #define  ESDHC_TUNE_CTRL_MIN		0
 #define  ESDHC_TUNE_CTRL_MAX		((1 << 7) - 1)
 
+/* strobe dll register */
+#define ESDHC_STROBE_DLL_CTRL		0x70
+#define ESDHC_STROBE_DLL_CTRL_ENABLE	(1 << 0)
+#define ESDHC_STROBE_DLL_CTRL_RESET	(1 << 1)
+#define ESDHC_STROBE_DLL_CTRL_SLV_DLY_TARGET_SHIFT	3
+
+#define ESDHC_STROBE_DLL_STATUS		0x74
+#define ESDHC_STROBE_DLL_STS_REF_LOCK	(1 << 1)
+#define ESDHC_STROBE_DLL_STS_SLV_LOCK 	0x1
+
 #define ESDHC_TUNING_CTRL		0xcc
 #define ESDHC_STD_TUNING_EN		(1 << 24)
 /* NOTE: the minimum valid tuning start tap for mx6sl is 1 */
@@ -120,6 +131,8 @@
 #define ESDHC_FLAG_ERR004536		BIT(7)
 /* The IP supports HS200 mode */
 #define ESDHC_FLAG_HS200		BIT(8)
+/* The IP supports HS400 mode */
+#define ESDHC_FLAG_SUP_HS400		BIT(9)
 
 struct esdhc_soc_data {
 	u32 flags;
@@ -156,6 +169,12 @@ static struct esdhc_soc_data usdhc_imx6sx_data = {
 			| ESDHC_FLAG_HAVE_CAP1 | ESDHC_FLAG_HS200,
 };
 
+static struct esdhc_soc_data usdhc_imx7d_data = {
+	.flags = ESDHC_FLAG_USDHC | ESDHC_FLAG_STD_TUNING
+			| ESDHC_FLAG_HAVE_CAP1 | ESDHC_FLAG_HS200
+			| ESDHC_FLAG_SUP_HS400,
+};
+
 struct pltfm_imx_data {
 	u32 scratchpad;
 	struct pinctrl *pinctrl;
@@ -199,6 +218,7 @@ static const struct of_device_id imx_esdhc_dt_ids[] = {
 	{ .compatible = "fsl,imx6sx-usdhc", .data = &usdhc_imx6sx_data, },
 	{ .compatible = "fsl,imx6sl-usdhc", .data = &usdhc_imx6sl_data, },
 	{ .compatible = "fsl,imx6q-usdhc", .data = &usdhc_imx6q_data, },
+	{ .compatible = "fsl,imx7d-usdhc", .data = &usdhc_imx7d_data, },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, imx_esdhc_dt_ids);
@@ -274,6 +294,10 @@ static u32 esdhc_readl_le(struct sdhci_host *host, int reg)
 				val = SDHCI_SUPPORT_DDR50 | SDHCI_SUPPORT_SDR104
 					| SDHCI_SUPPORT_SDR50
 					| SDHCI_USE_SDR50_TUNING;
+
+			/* imx7d does not have a support_hs400 register, fake one */
+			if (imx_data->socdata->flags & ESDHC_FLAG_SUP_HS400)
+				val |= SDHCI_SUPPORT_HS400;
 		}
 	}
 
@@ -779,6 +803,7 @@ static int esdhc_change_pinstate(struct sdhci_host *host,
 		break;
 	case MMC_TIMING_UHS_SDR104:
 	case MMC_TIMING_MMC_HS200:
+	case MMC_TIMING_MMC_HS400:
 		pinctrl = imx_data->pins_200mhz;
 		break;
 	default:
@@ -789,6 +814,30 @@ static int esdhc_change_pinstate(struct sdhci_host *host,
 	return pinctrl_select_state(imx_data->pinctrl, pinctrl);
 }
 
+static void esdhc_set_strobe_dll(struct sdhci_host *host)
+{
+	u32 v;
+
+	/* force a reset on strobe dll */
+	writel(ESDHC_STROBE_DLL_CTRL_RESET, host->ioaddr + ESDHC_STROBE_DLL_CTRL);
+	/*
+	 * enable strobe dll ctrl and adjust the delay target
+	 * for the uSDHC loopback read clock
+	 */
+	v = ESDHC_STROBE_DLL_CTRL_ENABLE |
+		(7 << ESDHC_STROBE_DLL_CTRL_SLV_DLY_TARGET_SHIFT);
+	writel(v, host->ioaddr + ESDHC_STROBE_DLL_CTRL);
+	/* wait 1us to make sure strobe dll status register stable */
+	udelay(1);
+	v = readl(host->ioaddr + ESDHC_STROBE_DLL_STATUS);
+	if (!(v & ESDHC_STROBE_DLL_STS_REF_LOCK))
+		dev_warn(mmc_dev(host->mmc),
+			"warning! HS400 strobe DLL status REF not lock!\n");
+	if (!(v & ESDHC_STROBE_DLL_STS_SLV_LOCK))
+		dev_warn(mmc_dev(host->mmc),
+			"warning! HS400 strobe DLL status SLV not lock!\n");
+}
+
 static void esdhc_set_uhs_signaling(struct sdhci_host *host, unsigned timing)
 {
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
@@ -800,7 +849,13 @@ static void esdhc_set_uhs_signaling(struct sdhci_host *host, unsigned timing)
 	case MMC_TIMING_UHS_SDR25:
 	case MMC_TIMING_UHS_SDR50:
 	case MMC_TIMING_UHS_SDR104:
+		break;
 	case MMC_TIMING_MMC_HS200:
+		/* disable ddr mode and disable HS400 mode */
+		writel(readl(host->ioaddr + ESDHC_MIX_CTRL) &
+			~(ESDHC_MIX_CTRL_DDREN | ESDHC_MIX_CTRL_HS400_EN),
+			host->ioaddr + ESDHC_MIX_CTRL);
+		imx_data->is_ddr = 0;
 		break;
 	case MMC_TIMING_UHS_DDR50:
 	case MMC_TIMING_MMC_DDR52:
@@ -818,6 +873,14 @@ static void esdhc_set_uhs_signaling(struct sdhci_host *host, unsigned timing)
 			writel(v, host->ioaddr + ESDHC_DLL_CTRL);
 		}
 		break;
+	case MMC_TIMING_MMC_HS400:
+		writel(readl(host->ioaddr + ESDHC_MIX_CTRL) |
+				ESDHC_MIX_CTRL_DDREN | ESDHC_MIX_CTRL_HS400_EN,
+				host->ioaddr + ESDHC_MIX_CTRL);
+		imx_data->is_ddr = 1;
+		if (host->clock == 200000000)
+			esdhc_set_strobe_dll(host);
+		break;
 	}
 
 	esdhc_change_pinstate(host, timing);
@@ -1030,6 +1093,9 @@ static int sdhci_esdhc_imx_probe(struct platform_device *pdev)
 	if (imx_data->socdata->flags & ESDHC_FLAG_ERR004536)
 		host->quirks |= SDHCI_QUIRK_BROKEN_ADMA;
 
+	if (imx_data->socdata->flags & ESDHC_FLAG_SUP_HS400)
+		host->quirks2 |= SDHCI_QUIRK2_CAPS_BIT63_FOR_HS400;
+
 	boarddata = &imx_data->boarddata;
 	if (sdhci_esdhc_imx_probe_dt(pdev, host, boarddata) < 0) {
 		if (!host->mmc->parent->platform_data) {
-- 
1.9.1

