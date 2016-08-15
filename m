From: Haibo Chen <haibo.chen@nxp.com>
Subject: [PATCH] mmc: sdhci-esdhc-imx: reset tuning circurt when insert sd card
Date: Mon, 15 Aug 2016 18:01:58 +0800
Message-ID: <1471255318-10933-1-git-send-email-haibo.chen@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ve1eur01on0068.outbound.protection.outlook.com ([104.47.1.68]:48044
	"EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752073AbcHOJ4n (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 15 Aug 2016 05:56:43 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: adrian.hunter@intel.com, ulf.hansson@linaro.org, aisheng.dong@nxp.com, linux-mmc@vger.kernel.org
Cc: haibo.chen@nxp.com

Current driver do not clear the tuning related register after
plug out SD3.0 card. This will impact the timing and let other
SD3.0 card inserted later meet CRC error.

e.g., after plug out a SDR104 card, and then plug in a DDR50 card,
CRC error shows up:

mmc2: new ultra high speed DDR50 SDHC card at address aaaa
mmcblk2: mmc2:aaaa SE08G 7.40 GiB
mmcblk2: error -84 transferring data, sector 0, nr 8, cmd response 0x900, card status 0xb00
mmc2: tried to reset card
 mmcblk2: p1 p2

Logictally, we should reset USDHC include tuning circurt first when we
plug in a sd/mmc/sdio card.

Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
---
 drivers/mmc/host/sdhci-esdhc-imx.c | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index ea7d086..2783a4b 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -924,6 +924,30 @@ static void esdhc_reset(struct sdhci_host *host, u8 mask)
 	sdhci_writel(host, host->ier, SDHCI_SIGNAL_ENABLE);
 }
 
+static void esdhc_hw_reset_for_init(struct sdhci_host *host)
+{
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct pltfm_imx_data *imx_data = sdhci_pltfm_priv(pltfm_host);
+	u16 ctrl;
+
+	sdhci_reset(host, SDHCI_RESET_ALL);
+
+	/* Rest the tuning circurt */
+	if (esdhc_is_usdhc(imx_data)) {
+		if (imx_data->socdata->flags & ESDHC_FLAG_MAN_TUNING) {
+			ctrl = readl(host->ioaddr + ESDHC_MIX_CTRL);
+			ctrl &= ~(ESDHC_MIX_CTRL_SMPCLK_SEL |
+					ESDHC_MIX_CTRL_FBCLK_SEL);
+			writel(ctrl, host->ioaddr + ESDHC_MIX_CTRL);
+			writel(0 << 8, host->ioaddr + ESDHC_TUNE_CTRL_STATUS);
+		} else if (imx_data->socdata->flags & ESDHC_FLAG_STD_TUNING) {
+			ctrl = readl(host->ioaddr + SDHCI_ACMD12_ERR);
+			ctrl &= ~ESDHC_MIX_CTRL_SMPCLK_SEL;
+			writel(ctrl, host->ioaddr + SDHCI_ACMD12_ERR);
+		}
+	}
+}
+
 static unsigned int esdhc_get_max_timeout_count(struct sdhci_host *host)
 {
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
@@ -958,6 +982,7 @@ static struct sdhci_ops sdhci_esdhc_ops = {
 	.set_bus_width = esdhc_pltfm_set_bus_width,
 	.set_uhs_signaling = esdhc_set_uhs_signaling,
 	.reset = esdhc_reset,
+	.hw_reset = esdhc_hw_reset_for_init,
 };
 
 static const struct sdhci_pltfm_data sdhci_esdhc_imx_pdata = {
@@ -1223,7 +1248,7 @@ static int sdhci_esdhc_imx_probe(struct platform_device *pdev)
 
 	if (esdhc_is_usdhc(imx_data)) {
 		host->quirks2 |= SDHCI_QUIRK2_PRESET_VALUE_BROKEN;
-		host->mmc->caps |= MMC_CAP_1_8V_DDR;
+		host->mmc->caps |= MMC_CAP_1_8V_DDR | MMC_CAP_HW_RESET;
 		if (!(imx_data->socdata->flags & ESDHC_FLAG_HS200))
 			host->quirks2 |= SDHCI_QUIRK2_BROKEN_HS200;
 
-- 
1.9.1

