From: Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH 1/6] mmc: sdhci-esdhc-imx: separate transfer mode from command write for usdhc
Date: Mon, 21 Jan 2013 19:02:24 +0800
Message-ID: <1358766149-9534-2-git-send-email-shawn.guo@linaro.org>
References: <1358766149-9534-1-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from am1ehsobe005.messaging.microsoft.com ([213.199.154.208]:16256
	"EHLO am1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752002Ab3AUKeS (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 21 Jan 2013 05:34:18 -0500
In-Reply-To: <1358766149-9534-1-git-send-email-shawn.guo@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Sascha Hauer <s.hauer@pengutronix.de>, Chris Ball <cjb@laptop.org>, Shawn Guo <shawn.guo@linaro.org>

The combining of SDHCI_TRANSFER_MODE and SDHCI_COMMAND writes is only
required for esdhc, but not necessarily for usdhc.  Different from
esdhc where the bits for transfer mode and command are all in the same
register CMD_XFR_TYP, usdhc has a newly introduced register MIX_CTRL
to hold transfer mode bits.  So it makes more sense to separate transfer
mode from command write for usdhc.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 drivers/mmc/host/sdhci-esdhc-imx.c |   25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index 370c052..48832c5 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -239,10 +239,6 @@ static void esdhc_writew_le(struct sdhci_host *host, u16 val, int reg)
 
 	switch (reg) {
 	case SDHCI_TRANSFER_MODE:
-		/*
-		 * Postpone this write, we must do it together with a
-		 * command write that is down below.
-		 */
 		if ((imx_data->flags & ESDHC_FLAG_MULTIBLK_NO_INT)
 				&& (host->cmd->opcode == SD_IO_RW_EXTENDED)
 				&& (host->cmd->data->blocks > 1)
@@ -252,7 +248,18 @@ static void esdhc_writew_le(struct sdhci_host *host, u16 val, int reg)
 			v |= ESDHC_VENDOR_SPEC_SDIO_QUIRK;
 			writel(v, host->ioaddr + ESDHC_VENDOR_SPEC);
 		}
-		imx_data->scratchpad = val;
+
+		if (is_imx6q_usdhc(imx_data)) {
+			u32 m = readl(host->ioaddr + ESDHC_MIX_CTRL);
+			m = val | (m & 0xffff0000);
+			writel(m, host->ioaddr + ESDHC_MIX_CTRL);
+		} else {
+			/*
+			 * Postpone this write, we must do it together with a
+			 * command write that is down below.
+			 */
+			imx_data->scratchpad = val;
+		}
 		return;
 	case SDHCI_COMMAND:
 		if ((host->cmd->opcode == MMC_STOP_TRANSMISSION ||
@@ -260,16 +267,12 @@ static void esdhc_writew_le(struct sdhci_host *host, u16 val, int reg)
 	            (imx_data->flags & ESDHC_FLAG_MULTIBLK_NO_INT))
 			val |= SDHCI_CMD_ABORTCMD;
 
-		if (is_imx6q_usdhc(imx_data)) {
-			u32 m = readl(host->ioaddr + ESDHC_MIX_CTRL);
-			m = imx_data->scratchpad | (m & 0xffff0000);
-			writel(m, host->ioaddr + ESDHC_MIX_CTRL);
+		if (is_imx6q_usdhc(imx_data))
 			writel(val << 16,
 			       host->ioaddr + SDHCI_TRANSFER_MODE);
-		} else {
+		else
 			writel(val << 16 | imx_data->scratchpad,
 			       host->ioaddr + SDHCI_TRANSFER_MODE);
-		}
 		return;
 	case SDHCI_BLOCK_SIZE:
 		val &= ~SDHCI_MAKE_BLKSZ(0x7, 0);
-- 
1.7.9.5


