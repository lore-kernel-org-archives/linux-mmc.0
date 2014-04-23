From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [PATCH 26/38] mmc: sdhci-esdhc-imx: remove emulation of uhs_mode
Date: Wed, 23 Apr 2014 20:08:23 +0100
Message-ID: <E1Wd2Wt-0003w1-6P@rmk-PC.arm.linux.org.uk>
References: <20140423185534.GA26756@n2100.arm.linux.org.uk>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from gw-1.arm.linux.org.uk ([78.32.30.217]:46490 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S932171AbaDWTI2 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 23 Apr 2014 15:08:28 -0400
In-Reply-To: <20140423185534.GA26756@n2100.arm.linux.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <chris@printf.net>, linux-mmc@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Ulf Hansson <ulf.hansson@linaro.org>

We no longer need to emulate the uhs_mode field of the host control2
register - the main sdhci driver never reads this back to evaluate
the current mode as it caches the current mode instead.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/mmc/host/sdhci-esdhc-imx.c | 17 +++--------------
 1 file changed, 3 insertions(+), 14 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index 72e0581e564f..4866d802f9e2 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -160,7 +160,6 @@ struct pltfm_imx_data {
 		MULTIBLK_IN_PROCESS, /* exact multiblock cmd in process */
 		WAIT_FOR_INT,        /* sent CMD12, waiting for response INT */
 	} multiblock_status;
-	u32 uhs_mode;
 	u32 is_ddr;
 };
 
@@ -382,7 +381,6 @@ static u16 esdhc_readw_le(struct sdhci_host *host, int reg)
 		if (val & ESDHC_MIX_CTRL_SMPCLK_SEL)
 			ret |= SDHCI_CTRL_TUNED_CLK;
 
-		ret |= (imx_data->uhs_mode & SDHCI_CTRL_UHS_MASK);
 		ret &= ~SDHCI_CTRL_PRESET_VAL_ENABLE;
 
 		return ret;
@@ -429,7 +427,6 @@ static void esdhc_writew_le(struct sdhci_host *host, u16 val, int reg)
 		else
 			new_val &= ~ESDHC_VENDOR_SPEC_VSELECT;
 		writel(new_val, host->ioaddr + ESDHC_VENDOR_SPEC);
-		imx_data->uhs_mode = val & SDHCI_CTRL_UHS_MASK;
 		if (imx_data->socdata->flags & ESDHC_FLAG_MAN_TUNING) {
 			new_val = readl(host->ioaddr + ESDHC_MIX_CTRL);
 			if (val & SDHCI_CTRL_TUNED_CLK)
@@ -841,28 +838,20 @@ static int esdhc_change_pinstate(struct sdhci_host *host,
 	return pinctrl_select_state(imx_data->pinctrl, pinctrl);
 }
 
-static void esdhc_set_uhs_signaling(struct sdhci_host *host, unsigned int uhs)
+static void esdhc_set_uhs_signaling(struct sdhci_host *host, unsigned timing)
 {
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
 	struct pltfm_imx_data *imx_data = pltfm_host->priv;
 	struct esdhc_platform_data *boarddata = &imx_data->boarddata;
 
-	switch (uhs) {
+	switch (timing) {
 	case MMC_TIMING_UHS_SDR12:
-		imx_data->uhs_mode = SDHCI_CTRL_UHS_SDR12;
-		break;
 	case MMC_TIMING_UHS_SDR25:
-		imx_data->uhs_mode = SDHCI_CTRL_UHS_SDR25;
-		break;
 	case MMC_TIMING_UHS_SDR50:
-		imx_data->uhs_mode = SDHCI_CTRL_UHS_SDR50;
-		break;
 	case MMC_TIMING_UHS_SDR104:
 	case MMC_TIMING_MMC_HS200:
-		imx_data->uhs_mode = SDHCI_CTRL_UHS_SDR104;
 		break;
 	case MMC_TIMING_UHS_DDR50:
-		imx_data->uhs_mode = SDHCI_CTRL_UHS_DDR50;
 		writel(readl(host->ioaddr + ESDHC_MIX_CTRL) |
 				ESDHC_MIX_CTRL_DDREN,
 				host->ioaddr + ESDHC_MIX_CTRL);
@@ -879,7 +868,7 @@ static void esdhc_set_uhs_signaling(struct sdhci_host *host, unsigned int uhs)
 		break;
 	}
 
-	esdhc_change_pinstate(host, uhs);
+	esdhc_change_pinstate(host, timing);
 }
 
 static void esdhc_reset(struct sdhci_host *host, u8 mask)
-- 
1.8.3.1

