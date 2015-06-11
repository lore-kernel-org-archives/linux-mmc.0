From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH] mmc: sdhci-esdhc-imx: Do not set MMC_CAP_1_8V_DDR in the 'no-1-8-v' case
Date: Thu, 11 Jun 2015 19:08:23 -0300
Message-ID: <1434060503-10260-1-git-send-email-festevam@gmail.com>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: ulf.hansson@linaro.org
Cc: aisheng.dong@freescale.com, kevin.lemoi@savant.com, otavio@ossystems.com.br, kernel@pengutronix.de, linux@arm.linux.org.uk, linux-mmc@vger.kernel.org, Fabio Estevam <fabio.estevam@freescale.com>, stable@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

From: Fabio Estevam <fabio.estevam@freescale.com>

Since commit e2997c944dbdff3f ("mmc: sdhci-esdhc-imx: add MMC_CAP_1_8V_DDR
for mx6") the driver sets the MMC_CAP_1_8V_DDR flag unconditionally on
mx6, but we should not do this when the 'no-1-8-v' property is passed via 
device tree.

This causes the following errors when accessing eMMC on a mx6sl board:

mmc0: MAN_BKOPS_EN bit is not set
mmc0: power class selection to bus width 8 ddr 4 failed
mmc0: error -110 whilst initialising MMC card

So only set the MMC_CAP_1_8V_DDR flag when the 'no-1-8-v' property is
absent.

With this fix in place it is possible to successfully mount the rootfs
from the emmc on a mx6sl board which has 'no-1-8-v' property passed in the
device tree.

Fixes: e2997c944dbdff3f ("mmc: sdhci-esdhc-imx: add MMC_CAP_1_8V_DDR for mx6")
Cc: stable@vger.kernel.org
Reported-by: Kevin Lemoi <kevin.lemoi@savant.com>
Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 drivers/mmc/host/sdhci-esdhc-imx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index faf0cb9..b562faf 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -1005,7 +1005,6 @@ static int sdhci_esdhc_imx_probe(struct platform_device *pdev)
 	if (esdhc_is_usdhc(imx_data)) {
 		writel(0x08100810, host->ioaddr + ESDHC_WTMK_LVL);
 		host->quirks2 |= SDHCI_QUIRK2_PRESET_VALUE_BROKEN;
-		host->mmc->caps |= MMC_CAP_1_8V_DDR;
 
 		if (!(imx_data->socdata->flags & ESDHC_FLAG_HS200))
 			host->quirks2 |= SDHCI_QUIRK2_BROKEN_HS200;
@@ -1094,6 +1093,7 @@ static int sdhci_esdhc_imx_probe(struct platform_device *pdev)
 	/* sdr50 and sdr104 needs work on 1.8v signal voltage */
 	if ((boarddata->support_vsel) && esdhc_is_usdhc(imx_data) &&
 	    !IS_ERR(imx_data->pins_default)) {
+		host->mmc->caps |= MMC_CAP_1_8V_DDR;
 		imx_data->pins_100mhz = pinctrl_lookup_state(imx_data->pinctrl,
 						ESDHC_PINCTRL_STATE_100MHZ);
 		imx_data->pins_200mhz = pinctrl_lookup_state(imx_data->pinctrl,
-- 
1.9.1
