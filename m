From: Haibo Chen <haibo.chen@freescale.com>
Subject: [PATCH v5 6/6] mmc: sdhci-esdhc-imx: change default watermark level and burst length
Date: Mon, 10 Aug 2015 16:18:08 +0800
Message-ID: <1439194688-18335-7-git-send-email-haibo.chen@freescale.com>
References: <1439194688-18335-1-git-send-email-haibo.chen@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bl2on0120.outbound.protection.outlook.com ([65.55.169.120]:22336
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932157AbbHJIQ2 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 10 Aug 2015 04:16:28 -0400
In-Reply-To: <1439194688-18335-1-git-send-email-haibo.chen@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, shawnguo@kernel.org, kernel@pengutronix.de, linux@arm.linux.org.uk, ulf.hansson@linaro.org, aisheng.dong@freescale.com
Cc: johan.derycke@barco.com, mkl@pengutronix.de, haibo.chen@freescale.com, fabio.estevam@freescale.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org

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
index d7ec993..1b31d36 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -1162,7 +1162,8 @@ static int sdhci_esdhc_imx_probe(struct platform_device *pdev)
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

