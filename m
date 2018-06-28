From: Stefan Agner <stefan@agner.ch>
Subject: [PATCH] mmc: sdhci-esdhc-imx: support eMMC DDR mode when running at 3.3V
Date: Thu, 28 Jun 2018 09:31:36 +0200
Message-ID: <20180628073136.21748-1-stefan@agner.ch>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: adrian.hunter@intel.com, ulf.hansson@linaro.org
Cc: fabio.estevam@nxp.com, haibo.chen@nxp.com, aisheng.dong@nxp.com, michael@amarulasolutions.com, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Stefan Agner <stefan@agner.ch>
List-Id: linux-mmc@vger.kernel.org

The uSDHC supports DDR modes for eMMC devices running at 3.3V. This
allows to run eMMC with 3.3V signaling voltage at DDR52 mode:

  # cat /sys/kernel/debug/mmc1/ios
  clock:          52000000 Hz
  vdd:            21 (3.3 ~ 3.4 V)
  bus mode:       2 (push-pull)
  chip select:    0 (don't care)
  power mode:     2 (on)
  bus width:      3 (8 bits)
  timing spec:    8 (mmc DDR52)
  signal voltage: 0 (3.30 V)
  driver type:    0 (driver type B)

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 drivers/mmc/host/sdhci-esdhc-imx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index b716b933f00a..6f444731754d 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -1324,7 +1324,7 @@ static int sdhci_esdhc_imx_probe(struct platform_device *pdev)
 
 	if (esdhc_is_usdhc(imx_data)) {
 		host->quirks2 |= SDHCI_QUIRK2_PRESET_VALUE_BROKEN;
-		host->mmc->caps |= MMC_CAP_1_8V_DDR;
+		host->mmc->caps |= MMC_CAP_1_8V_DDR | MMC_CAP_3_3V_DDR;
 		if (!(imx_data->socdata->flags & ESDHC_FLAG_HS200))
 			host->quirks2 |= SDHCI_QUIRK2_BROKEN_HS200;
 
-- 
2.18.0
