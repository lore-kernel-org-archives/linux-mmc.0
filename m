From: Dong Aisheng <b29396@freescale.com>
Subject: [PATCH v2 2/5] mmc: sdhci-esdhc-imx: tuning bits should not be cleared during reset
Date: Mon, 4 Nov 2013 16:38:26 +0800
Message-ID: <1383554309-29065-3-git-send-email-b29396@freescale.com>
References: <1383554309-29065-1-git-send-email-b29396@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from tx2ehsobe001.messaging.microsoft.com ([65.55.88.11]:46490 "EHLO
	tx2outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752315Ab3KDI6i (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 4 Nov 2013 03:58:38 -0500
In-Reply-To: <1383554309-29065-1-git-send-email-b29396@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, cjb@laptop.org, shawn.guo@linaro.org, s.hauer@pengutronix.de, b29396@freescale.com, ulf.hansson@linaro.org

We should not clear tuning bits during reset or the SD3.0/eMMC4.5 card
working on UHS mode may not work after reset since the former tuning
settings was lost.

Signed-off-by: Dong Aisheng <b29396@freescale.com>
---
 drivers/mmc/host/sdhci-esdhc-imx.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index 5816585..f5e1dcf 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -45,6 +45,8 @@
 #define  ESDHC_MIX_CTRL_FBCLK_SEL	(1 << 25)
 /* Bits 3 and 6 are not SDHCI standard definitions */
 #define  ESDHC_MIX_CTRL_SDHCI_MASK	0xb7
+/* Tuning bits */
+#define  ESDHC_MIX_CTRL_TUNING_MASK	0x03c00000
 
 /* dll control register */
 #define ESDHC_DLL_CTRL			0x60
@@ -562,7 +564,10 @@ static void esdhc_writeb_le(struct sdhci_host *host, u8 val, int reg)
 		 * Do it manually here.
 		 */
 		if (esdhc_is_usdhc(imx_data)) {
-			writel(0, host->ioaddr + ESDHC_MIX_CTRL);
+			/* the tuning bits should be kept during reset */
+			new_val = readl(host->ioaddr + ESDHC_MIX_CTRL);
+			writel(new_val & ESDHC_MIX_CTRL_TUNING_MASK,
+					host->ioaddr + ESDHC_MIX_CTRL);
 			imx_data->is_ddr = 0;
 		}
 	}
-- 
1.7.2.rc3


