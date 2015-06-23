From: Haibo Chen <haibo.chen@freescale.com>
Subject: [PATCH v2 2/4] mmc: sdhci-esdhc-imx: add tuning-step seting support
Date: Tue, 23 Jun 2015 19:48:01 +0800
Message-ID: <1435060083-2606-3-git-send-email-haibo.chen@freescale.com>
References: <1435060083-2606-1-git-send-email-haibo.chen@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-by2on0140.outbound.protection.outlook.com ([207.46.100.140]:3232
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754471AbbFWLp1 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 23 Jun 2015 07:45:27 -0400
In-Reply-To: <1435060083-2606-1-git-send-email-haibo.chen@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org, aisheng.dong@freescale.com, fabio.estevam@freescale.com, shawn.guo@linaro.org, eric.nelson@boundarydevices.com, linux-mmc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, haibo.chen@freescale.com

tuning-step is the delay cell steps in tuning procedure. The default value
of tuning-step is 1. For imx6 series usdhc, tuning procedure can be passed
when the tuning-step value is 1. But imx7d usdhc need the tuning-step value
as 2, otherwise it can't pass the tuning procedure.

This patch add the tuning-step setting in driver, so that user can set the
tuning-step value in dts.

Signed-off-by: Haibo Chen <haibo.chen@freescale.com>
---
 drivers/mmc/host/sdhci-esdhc-imx.c          | 9 +++++++++
 include/linux/platform_data/mmc-esdhc-imx.h | 1 +
 2 files changed, 10 insertions(+)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index 763b928..f7ec66e 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -75,6 +75,7 @@
 #define ESDHC_STD_TUNING_EN		(1 << 24)
 /* NOTE: the minimum valid tuning start tap for mx6sl is 1 */
 #define ESDHC_TUNING_START_TAP		0x1
+#define ESDHC_TUNING_STEP_SHIFT		16
 
 /* pinctrl state */
 #define ESDHC_PINCTRL_STATE_100MHZ	"state_100mhz"
@@ -472,6 +473,7 @@ static void esdhc_writew_le(struct sdhci_host *host, u16 val, int reg)
 		} else if (imx_data->socdata->flags & ESDHC_FLAG_STD_TUNING) {
 			u32 v = readl(host->ioaddr + SDHCI_ACMD12_ERR);
 			u32 m = readl(host->ioaddr + ESDHC_MIX_CTRL);
+			u32 tuning_ctrl;
 			if (val & SDHCI_CTRL_TUNED_CLK) {
 				v |= ESDHC_MIX_CTRL_SMPCLK_SEL;
 			} else {
@@ -482,6 +484,11 @@ static void esdhc_writew_le(struct sdhci_host *host, u16 val, int reg)
 			if (val & SDHCI_CTRL_EXEC_TUNING) {
 				v |= ESDHC_MIX_CTRL_EXE_TUNE;
 				m |= ESDHC_MIX_CTRL_FBCLK_SEL;
+				tuning_ctrl = readl(host->ioaddr + ESDHC_TUNING_CTRL);
+				tuning_ctrl |= ESDHC_STD_TUNING_EN | ESDHC_TUNING_START_TAP;
+				if (imx_data->boarddata.tuning_step)
+					tuning_ctrl |= imx_data->boarddata.tuning_step << ESDHC_TUNING_STEP_SHIFT;
+					writel(tuning_ctrl, host->ioaddr + ESDHC_TUNING_CTRL);
 			} else {
 				v &= ~ESDHC_MIX_CTRL_EXE_TUNE;
 			}
@@ -969,6 +976,8 @@ sdhci_esdhc_imx_probe_dt(struct platform_device *pdev,
 
 	of_property_read_u32(np, "max-frequency", &boarddata->f_max);
 
+	of_property_read_u32(np, "tuning-step", &boarddata->tuning_step);
+
 	if (of_find_property(np, "no-1-8-v", NULL))
 		boarddata->support_vsel = false;
 	else
diff --git a/include/linux/platform_data/mmc-esdhc-imx.h b/include/linux/platform_data/mmc-esdhc-imx.h
index 75f70f6..cedbf8e 100644
--- a/include/linux/platform_data/mmc-esdhc-imx.h
+++ b/include/linux/platform_data/mmc-esdhc-imx.h
@@ -46,5 +46,6 @@ struct esdhc_platform_data {
 	unsigned int f_max;
 	bool support_vsel;
 	unsigned int delay_line;
+	unsigned int tuning_step;	/* The delay cell steps in tuning procedure */
 };
 #endif /* __ASM_ARCH_IMX_ESDHC_H */
-- 
1.9.1

