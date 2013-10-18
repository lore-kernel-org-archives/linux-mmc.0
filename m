From: Dong Aisheng <b29396@freescale.com>
Subject: [PATCH v3 4/8] mmc: sdhci-esdhc-imx: add DDR mode support for mx6
Date: Fri, 18 Oct 2013 19:48:46 +0800
Message-ID: <1382096930-7964-5-git-send-email-b29396@freescale.com>
References: <1382096930-7964-1-git-send-email-b29396@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ch1ehsobe002.messaging.microsoft.com ([216.32.181.182]:1891
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753018Ab3JRMF0 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 18 Oct 2013 08:05:26 -0400
In-Reply-To: <1382096930-7964-1-git-send-email-b29396@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, cjb@laptop.org, shawn.guo@linaro.org, s.hauer@pengutronix.de, b29396@freescale.com, wsa@the-dreams.de

When DDR mode is enabled, the initial pre_div should be 2.
And the pre_div value should be changed accordingly
from
...
02h) Base clock divided by 4
01h) Base clock divided by 2
00h) Base clock divided by 1
to
..
02h) Base clock divided by 8
01h) Base clock divided by 4
00h) Base clock divided by 2

Signed-off-by: Dong Aisheng <b29396@freescale.com>
Acked-by: Shawn Guo <shawn.guo@linaro.org>
---
 drivers/mmc/host/sdhci-esdhc-imx.c |   17 ++++++++++++++---
 1 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index 1652e18..915fa68 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -38,6 +38,7 @@
 #define  ESDHC_VENDOR_SPEC_FRC_SDCLK_ON	(1 << 8)
 #define ESDHC_WTMK_LVL			0x44
 #define ESDHC_MIX_CTRL			0x48
+#define  ESDHC_MIX_CTRL_DDREN		(1 << 3)
 #define  ESDHC_MIX_CTRL_AC23EN		(1 << 7)
 #define  ESDHC_MIX_CTRL_EXE_TUNE	(1 << 22)
 #define  ESDHC_MIX_CTRL_SMPCLK_SEL	(1 << 23)
@@ -152,6 +153,7 @@ struct pltfm_imx_data {
 		WAIT_FOR_INT,        /* sent CMD12, waiting for response INT */
 	} multiblock_status;
 	u32 uhs_mode;
+	u32 is_ddr;
 };
 
 static struct platform_device_id imx_esdhc_devtype[] = {
@@ -537,8 +539,10 @@ static void esdhc_writeb_le(struct sdhci_host *host, u8 val, int reg)
 		 * The reset on usdhc fails to clear MIX_CTRL register.
 		 * Do it manually here.
 		 */
-		if (esdhc_is_usdhc(imx_data))
+		if (esdhc_is_usdhc(imx_data)) {
 			writel(0, host->ioaddr + ESDHC_MIX_CTRL);
+			imx_data->is_ddr = 0;
+		}
 	}
 }
 
@@ -582,7 +586,7 @@ static inline void esdhc_pltfm_set_clock(struct sdhci_host *host,
 		goto out;
 	}
 
-	if (esdhc_is_usdhc(imx_data))
+	if (esdhc_is_usdhc(imx_data) && !imx_data->is_ddr)
 		pre_div = 1;
 
 	temp = sdhci_readl(host, ESDHC_SYSTEM_CONTROL);
@@ -600,7 +604,10 @@ static inline void esdhc_pltfm_set_clock(struct sdhci_host *host,
 	dev_dbg(mmc_dev(host->mmc), "desired SD clock: %d, actual: %d\n",
 		clock, host->mmc->actual_clock);
 
-	pre_div >>= 1;
+	if (imx_data->is_ddr)
+		pre_div >>= 2;
+	else
+		pre_div >>= 1;
 	div--;
 
 	temp = sdhci_readl(host, ESDHC_SYSTEM_CONTROL);
@@ -826,6 +833,10 @@ static int esdhc_set_uhs_signaling(struct sdhci_host *host, unsigned int uhs)
 		break;
 	case MMC_TIMING_UHS_DDR50:
 		imx_data->uhs_mode = SDHCI_CTRL_UHS_DDR50;
+		writel(readl(host->ioaddr + ESDHC_MIX_CTRL) |
+				ESDHC_MIX_CTRL_DDREN,
+				host->ioaddr + ESDHC_MIX_CTRL);
+		imx_data->is_ddr = 1;
 		break;
 	}
 
-- 
1.7.2.rc3


