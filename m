From: Dong Aisheng <b29396@freescale.com>
Subject: [PATCH v2 5/8] mmc: sdhci-esdhc-imx: add delay line setting support
Date: Fri, 18 Oct 2013 18:54:18 +0800
Message-ID: <1382093661-4074-6-git-send-email-b29396@freescale.com>
References: <1382093661-4074-1-git-send-email-b29396@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ch1ehsobe006.messaging.microsoft.com ([216.32.181.186]:8718
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753070Ab3JRLKy (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 18 Oct 2013 07:10:54 -0400
In-Reply-To: <1382093661-4074-1-git-send-email-b29396@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, cjb@laptop.org, shawn.guo@linaro.org, s.hauer@pengutronix.de, b29396@freescale.com, wsa@the-dreams.de

The DLL(Delay Line) is newly added to assist in sampling read data.
The DLL provides the ability to programmatically select a quantized
delay (in fractions of the clock period) regardless of on-chip variations
such as process, voltage and temperature (PVT).

This patch adds a user interface to set slave delay line via device tree.
It's usually used in high speed mode like mmc DDR mode when the signal
quality is not good caused by board design, e.g. the signal path is too long.
User can manual set delay line to find a suitable data sampling window
for card to work properly.

Signed-off-by: Dong Aisheng <b29396@freescale.com>
---
 .../devicetree/bindings/mmc/fsl-imx-esdhc.txt      |    5 +++++
 drivers/mmc/host/sdhci-esdhc-imx.c                 |   18 ++++++++++++++++++
 include/linux/platform_data/mmc-esdhc-imx.h        |    1 +
 3 files changed, 24 insertions(+), 0 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt
index 1dd6225..78a45c5 100644
--- a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt
+++ b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt
@@ -12,6 +12,11 @@ Required properties:
 Optional properties:
 - fsl,cd-controller : Indicate to use controller internal card detection
 - fsl,wp-controller : Indicate to use controller internal write protection
+- fsl,delay-line : Specify the number of delay cells for override mode.
+  This is used to set the clock delay for DLL(Delay Line) on override mode
+  to select a proper data sampling window in case the clock quality is not good
+  due to signal path is too long on the board.
+  please refer to DLL chapter in RM for details.
 
 Examples:
 
diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index c5c26bd..87d202b 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -46,6 +46,11 @@
 /* Bits 3 and 6 are not SDHCI standard definitions */
 #define  ESDHC_MIX_CTRL_SDHCI_MASK	0xb7
 
+/* dll control register */
+#define ESDHC_DLL_CTRL			0x60
+#define ESDHC_DLL_OVERRIDE_VAL_SHIFT	9
+#define ESDHC_DLL_OVERRIDE_EN_SHIFT	8
+
 /* tune control register */
 #define ESDHC_TUNE_CTRL_STATUS		0x68
 #define  ESDHC_TUNE_CTRL_STEP		1
@@ -817,6 +822,7 @@ static int esdhc_set_uhs_signaling(struct sdhci_host *host, unsigned int uhs)
 {
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
 	struct pltfm_imx_data *imx_data = pltfm_host->priv;
+	struct esdhc_platform_data *boarddata = &imx_data->boarddata;
 
 	switch (uhs) {
 	case MMC_TIMING_UHS_SDR12:
@@ -837,6 +843,15 @@ static int esdhc_set_uhs_signaling(struct sdhci_host *host, unsigned int uhs)
 				ESDHC_MIX_CTRL_DDREN,
 				host->ioaddr + ESDHC_MIX_CTRL);
 		imx_data->is_ddr = 1;
+		if (boarddata->delay_line) {
+			u32 v;
+			v = boarddata->delay_line <<
+				ESDHC_DLL_OVERRIDE_VAL_SHIFT |
+				(1 << ESDHC_DLL_OVERRIDE_EN_SHIFT);
+			if (is_imx53_esdhc(imx_data))
+				v <<= 1;
+			writel(v, host->ioaddr + ESDHC_DLL_CTRL);
+		}
 		break;
 	}
 
@@ -901,6 +916,9 @@ sdhci_esdhc_imx_probe_dt(struct platform_device *pdev,
 	else
 		boarddata->support_vsel = true;
 
+	if (of_property_read_u32(np, "fsl,delay-line", &boarddata->delay_line))
+		boarddata->delay_line = 0;
+
 	return 0;
 }
 #else
diff --git a/include/linux/platform_data/mmc-esdhc-imx.h b/include/linux/platform_data/mmc-esdhc-imx.h
index a0f5a8f..75f70f6 100644
--- a/include/linux/platform_data/mmc-esdhc-imx.h
+++ b/include/linux/platform_data/mmc-esdhc-imx.h
@@ -45,5 +45,6 @@ struct esdhc_platform_data {
 	int max_bus_width;
 	unsigned int f_max;
 	bool support_vsel;
+	unsigned int delay_line;
 };
 #endif /* __ASM_ARCH_IMX_ESDHC_H */
-- 
1.7.2.rc3


