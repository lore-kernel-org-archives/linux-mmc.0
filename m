From: Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH 3/6] mmc: sdhci-esdhc-imx: Auto CMD23 support for usdhc
Date: Mon, 21 Jan 2013 19:02:26 +0800
Message-ID: <1358766149-9534-4-git-send-email-shawn.guo@linaro.org>
References: <1358766149-9534-1-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from co9ehsobe002.messaging.microsoft.com ([207.46.163.25]:17048
	"EHLO co9outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752403Ab3AUKef (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 21 Jan 2013 05:34:35 -0500
In-Reply-To: <1358766149-9534-1-git-send-email-shawn.guo@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Sascha Hauer <s.hauer@pengutronix.de>, Chris Ball <cjb@laptop.org>, Shawn Guo <shawn.guo@linaro.org>

SDHCI core will try to use Auto CMD23 for mmc card.  Currently, we will
see the following message with mmc card on usdhc due to the lacking of
Auto CMD23 support in the driver.

$ mmc0: new high speed MMC card at address 0001
mmcblk1: mmc0:0001 MMC02G 1.87 GiB
mmcblk1: error -84 transferring data, sector 0, nr 8, cmd response 0x900, card status 0xb00
mmcblk1: retrying using single block read
 mmcblk1:

Enable Auto CMD23 support for usdhc so that mmc card can work in
multiple block mode.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 drivers/mmc/host/sdhci-esdhc-imx.c |   10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index 968a70f..24daaf4 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -36,6 +36,9 @@
 #define  ESDHC_VENDOR_SPEC_SDIO_QUIRK	(1 << 1)
 #define ESDHC_WTMK_LVL			0x44
 #define ESDHC_MIX_CTRL			0x48
+#define  ESDHC_MIX_CTRL_AC23EN		(1 << 7)
+/* Bits 3 and 6 are not SDHCI standard definitions */
+#define  ESDHC_MIX_CTRL_SDHCI_MASK	0xb7
 
 /*
  * There is an INT DMA ERR mis-match between eSDHC and STD SDHC SPEC:
@@ -251,7 +254,12 @@ static void esdhc_writew_le(struct sdhci_host *host, u16 val, int reg)
 
 		if (is_imx6q_usdhc(imx_data)) {
 			u32 m = readl(host->ioaddr + ESDHC_MIX_CTRL);
-			m = val | (m & 0xffff0000);
+			/* Swap AC23 bit */
+			if (val & SDHCI_TRNS_AUTO_CMD23) {
+				val &= ~SDHCI_TRNS_AUTO_CMD23;
+				val |= ESDHC_MIX_CTRL_AC23EN;
+			}
+			m = val | (m & ~ESDHC_MIX_CTRL_SDHCI_MASK);
 			writel(m, host->ioaddr + ESDHC_MIX_CTRL);
 		} else {
 			/*
-- 
1.7.9.5


