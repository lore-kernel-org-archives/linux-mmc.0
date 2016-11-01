From: "Leonardo G. Veiga" <leogveiga@gmail.com>
Subject: [PATCH] sdhci-esdhc-imx: fix bus-width for 1-bit operation.
Date: Tue,  1 Nov 2016 13:58:25 -0200
Message-ID: <1478015905-31262-1-git-send-email-leogveiga@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: ulf.hansson@linaro.org
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, stefan@agner.ch, raul.munoz@toradex.com, leonardo.veiga@toradex.com
List-Id: linux-mmc@vger.kernel.org

From: Leonardo Graboski Veiga <leonardo.veiga@toradex.com>

The 1-bit operation mode, enabled by seeting the 'bus-width' property of
the device tree 'esdhc' node to <1>, not work while using SD card.

The behavior is only noticed when only the data pin 0 is connected to the
hardware. A series of kernel errors are printed to the console, all of them
returning the following error message followed by some explanation:
mmcblk0: error -84 transferring data

If four data lines are connected, it ignores the device-tree
property and works in 4-bit mode of operation without errors. The hardware
used for testing does not support 8-bit mode.

Check the 'bus-width' property and if set to <1>, enable the
SDHCI_QUIRK_FORCE_1_BIT_DATA quirk.

Signed-off-by: Leonardo Graboski Veiga <leonardo.veiga@toradex.com>
---
 drivers/mmc/host/sdhci-esdhc-imx.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index c9fbc4c3..88d7d22 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -1003,6 +1003,10 @@ sdhci_esdhc_imx_probe_dt(struct platform_device *pdev,
 		host->quirks2 |= SDHCI_QUIRK2_NO_1_8_V;
 	}
 
+	if (!of_property_read_u32(np, "bus-width", &boarddata->max_bus_width)
+		&& boarddata->max_bus_width == 1)
+		host->quirks |= SDHCI_QUIRK_FORCE_1_BIT_DATA;
+
 	/* call to generic mmc_of_parse to support additional capabilities */
 	ret = mmc_of_parse(host->mmc);
 	if (ret)
-- 
2.7.4
