From: Dong Aisheng <aisheng.dong@nxp.com>
Subject: [PATCH 15/23] mmc: sdhci-esdhc-imx: support setting tuning start point
Date: Sat, 16 Apr 2016 01:29:39 +0800
Message-ID: <1460741387-23815-16-git-send-email-aisheng.dong@nxp.com>
References: <1460741387-23815-1-git-send-email-aisheng.dong@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-by2on0054.outbound.protection.outlook.com ([207.46.100.54]:23376
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750910AbcDORw4 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 15 Apr 2016 13:52:56 -0400
In-Reply-To: <1460741387-23815-1-git-send-email-aisheng.dong@nxp.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org, chris@printf.net, shawnguo@kernel.org, adrian.hunter@intel.com, linux-arm-kernel@lists.infradead.org, aisheng.dong@nxp.com, haibo.chen@nxp.com, dongas86@gmail.com

The delay cells of some SoCs may have less delay per one cell,
for such SoCs, user could set the start delay cell point to bypass
the first a few meaningless tuning commands.

Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
 drivers/mmc/host/sdhci-esdhc-imx.c          | 14 +++++++++++---
 include/linux/platform_data/mmc-esdhc-imx.h |  1 +
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index d02db66..9f9be3f 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -75,7 +75,8 @@
 #define ESDHC_TUNING_CTRL		0xcc
 #define ESDHC_STD_TUNING_EN		(1 << 24)
 /* NOTE: the minimum valid tuning start tap for mx6sl is 1 */
-#define ESDHC_TUNING_START_TAP		0x1
+#define ESDHC_TUNING_START_TAP_DEFAULT	0x1
+#define ESDHC_TUNING_START_TAP_MASK	0xff
 #define ESDHC_TUNING_STEP_MASK		0x00070000
 #define ESDHC_TUNING_STEP_SHIFT		16
 
@@ -489,7 +490,12 @@ static void esdhc_writew_le(struct sdhci_host *host, u16 val, int reg)
 				v |= ESDHC_MIX_CTRL_EXE_TUNE;
 				m |= ESDHC_MIX_CTRL_FBCLK_SEL;
 				tuning_ctrl = readl(host->ioaddr + ESDHC_TUNING_CTRL);
-				tuning_ctrl |= ESDHC_STD_TUNING_EN | ESDHC_TUNING_START_TAP;
+				tuning_ctrl |= ESDHC_STD_TUNING_EN | ESDHC_TUNING_START_TAP_DEFAULT;
+				if (imx_data->boarddata.tuning_start_tap) {
+					tuning_ctrl &= ~ESDHC_TUNING_START_TAP_MASK;
+					tuning_ctrl |= imx_data->boarddata.tuning_start_tap;
+				}
+
 				if (imx_data->boarddata.tuning_step) {
 					tuning_ctrl &= ~ESDHC_TUNING_STEP_MASK;
 					tuning_ctrl |= imx_data->boarddata.tuning_step << ESDHC_TUNING_STEP_SHIFT;
@@ -975,6 +981,8 @@ sdhci_esdhc_imx_probe_dt(struct platform_device *pdev,
 		boarddata->wp_type = ESDHC_WP_GPIO;
 
 	of_property_read_u32(np, "fsl,tuning-step", &boarddata->tuning_step);
+	of_property_read_u32(np, "fsl,tuning-start-tap",
+			     &boarddata->tuning_start_tap);
 
 	if (of_find_property(np, "no-1-8-v", NULL))
 		boarddata->support_vsel = false;
@@ -1197,7 +1205,7 @@ static int sdhci_esdhc_imx_probe(struct platform_device *pdev)
 
 	if (imx_data->socdata->flags & ESDHC_FLAG_STD_TUNING)
 		writel(readl(host->ioaddr + ESDHC_TUNING_CTRL) |
-			ESDHC_STD_TUNING_EN | ESDHC_TUNING_START_TAP,
+			ESDHC_STD_TUNING_EN | ESDHC_TUNING_START_TAP_DEFAULT,
 			host->ioaddr + ESDHC_TUNING_CTRL);
 
 	if (imx_data->socdata->flags & ESDHC_FLAG_ERR004536)
diff --git a/include/linux/platform_data/mmc-esdhc-imx.h b/include/linux/platform_data/mmc-esdhc-imx.h
index 95ccab3..7daa78a 100644
--- a/include/linux/platform_data/mmc-esdhc-imx.h
+++ b/include/linux/platform_data/mmc-esdhc-imx.h
@@ -46,5 +46,6 @@ struct esdhc_platform_data {
 	bool support_vsel;
 	unsigned int delay_line;
 	unsigned int tuning_step;       /* The delay cell steps in tuning procedure */
+	unsigned int tuning_start_tap;	/* The start delay cell point in tuning procedure */
 };
 #endif /* __ASM_ARCH_IMX_ESDHC_H */
-- 
1.9.1

