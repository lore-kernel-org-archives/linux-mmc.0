From: Haibo Chen <haibo.chen@freescale.com>
Subject: [PATCH v4 5/6] mmc: sdhci-esdhc-imx: change default watermark level and burst length
Date: Wed, 5 Aug 2015 18:38:41 +0800
Message-ID: <1438771122-8601-6-git-send-email-haibo.chen@freescale.com>
References: <1438771122-8601-1-git-send-email-haibo.chen@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1438771122-8601-1-git-send-email-haibo.chen@freescale.com>
Sender: linux-kernel-owner@vger.kernel.org
To: robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, shawnguo@kernel.org, kernel@pengutronix.de, linux@arm.linux.org.uk, ulf.hansson@linaro.org, aisheng.dong@freescale.com
Cc: haibo.chen@freescale.com, johan.derycke@barco.com, mkl@pengutronix.de, fabio.estevam@freescale.com, b29396@freescale.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

By default, for all imx SoC types, the watermark level is 16, and the
burst length is 8. But if the SDIO/SD/MMC I/O speed is fast enough,
this default watermark level and burst length will be the performance
bottleneck.

For example, i.MX7D support eMMC HS400 mode, this mode can run in 8 bit,
200MHZ DDR mode. So the I/O speed improve a lot compare to SD3.0.
The default burst length is 8, if we don't change this value, in
HS400 mode, when we do eMMC read operation, we can find that the
clock signal will stop for a period of time. This means the speed
of data moving on AHB bus is slower than I/O speed. So we should
improve the speed of data moving on AHB bus.

This patch set the default burst length as 16, and set the default
watermark level as 64. The test result is the clock signal has
no stop during the eMMC HS400 operation.

Signed-off-by: Haibo Chen <haibo.chen@freescale.com>
---
 drivers/mmc/host/sdhci-esdhc-imx.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index 803d24f..97aa944 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -1160,7 +1160,8 @@ static int sdhci_esdhc_imx_probe(struct platform_device *pdev)
 	 * to something insane.  Change it back here.
 	 */
 	if (esdhc_is_usdhc(imx_data)) {
-		writel(0x08100810, host->ioaddr + ESDHC_WTMK_LVL);
+		writel(0x10401040, host->ioaddr + ESDHC_WTMK_LVL);
+
 		host->quirks2 |= SDHCI_QUIRK2_PRESET_VALUE_BROKEN;
 		host->mmc->caps |= MMC_CAP_1_8V_DDR;
 
-- 
1.9.1
