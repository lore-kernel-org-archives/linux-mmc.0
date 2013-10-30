From: Dong Aisheng <b29396@freescale.com>
Subject: [PATCH 3/5] mmc: sdhci-esdhc-imx: clear SDHCI_CTRL_EXEC_TUNING should not affect other bits
Date: Wed, 30 Oct 2013 22:12:16 +0800
Message-ID: <1383142338-25062-4-git-send-email-b29396@freescale.com>
References: <1383142338-25062-1-git-send-email-b29396@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from tx2ehsobe005.messaging.microsoft.com ([65.55.88.15]:54892 "EHLO
	tx2outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752899Ab3J3Ob3 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 30 Oct 2013 10:31:29 -0400
In-Reply-To: <1383142338-25062-1-git-send-email-b29396@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, cjb@laptop.org, shawn.guo@linaro.org, s.hauer@pengutronix.de, b29396@freescale.com, wsa@the-dreams.de

Current code will clear all turning related bits like ESDHC_STD_TUNING_EN
and ESDHC_MIX_CTRL_FBCLK_SEL when clear SDHCI_CTRL_EXEC_TUNING.
This may cause the card which has already passed the turning to become
unwork since the turning status lost.
We observed this failure when enable runtime pm.

BTW, imx needs to enable ESDHC_MIX_CTRL_FBCLK_SEL bit for turned clock.
The FBCLK_SEL will be cleared when SDHCI_CTRL_TUNED_CLK is cleared
and SDHCI_CTRL_EXEC_TUNING is not set.
This is used in case we change to another normal card from a UHS card
in the same slot. FBCLK_SEL is not needed for normal card.

After that, SDHCI_CTRL_EXEC_TUNING will only affect ESDHC_MIX_CTRL_EXE_TUNE.
Clearing it does not affect the turned card to remain working on UHS mode.

Signed-off-by: Dong Aisheng <b29396@freescale.com>
---
 drivers/mmc/host/sdhci-esdhc-imx.c |   24 +++++++++++++-----------
 1 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index f5e1dcf..0bd99eb 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -439,24 +439,20 @@ static void esdhc_writew_le(struct sdhci_host *host, u16 val, int reg)
 		} else if (imx_data->socdata->flags & ESDHC_FLAG_STD_TUNING) {
 			u32 v = readl(host->ioaddr + SDHCI_ACMD12_ERR);
 			u32 m = readl(host->ioaddr + ESDHC_MIX_CTRL);
-			new_val = readl(host->ioaddr + ESDHC_TUNING_CTRL);
+			if (val & SDHCI_CTRL_TUNED_CLK) {
+				v |= ESDHC_MIX_CTRL_SMPCLK_SEL;
+			} else {
+				v &= ~ESDHC_MIX_CTRL_SMPCLK_SEL;
+				m &= ~ESDHC_MIX_CTRL_FBCLK_SEL;
+			}
+
 			if (val & SDHCI_CTRL_EXEC_TUNING) {
-				new_val |= ESDHC_STD_TUNING_EN |
-						ESDHC_TUNING_START_TAP;
 				v |= ESDHC_MIX_CTRL_EXE_TUNE;
 				m |= ESDHC_MIX_CTRL_FBCLK_SEL;
 			} else {
-				new_val &= ~ESDHC_STD_TUNING_EN;
 				v &= ~ESDHC_MIX_CTRL_EXE_TUNE;
-				m &= ~ESDHC_MIX_CTRL_FBCLK_SEL;
 			}
 
-			if (val & SDHCI_CTRL_TUNED_CLK)
-				v |= ESDHC_MIX_CTRL_SMPCLK_SEL;
-			else
-				v &= ~ESDHC_MIX_CTRL_SMPCLK_SEL;
-
-			writel(new_val, host->ioaddr + ESDHC_TUNING_CTRL);
 			writel(v, host->ioaddr + SDHCI_ACMD12_ERR);
 			writel(m, host->ioaddr + ESDHC_MIX_CTRL);
 		}
@@ -1038,6 +1034,12 @@ static int sdhci_esdhc_imx_probe(struct platform_device *pdev)
 	if (imx_data->socdata->flags & ESDHC_FLAG_MAN_TUNING)
 		sdhci_esdhc_ops.platform_execute_tuning =
 					esdhc_executing_tuning;
+
+	if (imx_data->socdata->flags & ESDHC_FLAG_STD_TUNING)
+		writel(readl(host->ioaddr + ESDHC_TUNING_CTRL) |
+			ESDHC_STD_TUNING_EN | ESDHC_TUNING_START_TAP,
+			host->ioaddr + ESDHC_TUNING_CTRL);
+
 	boarddata = &imx_data->boarddata;
 	if (sdhci_esdhc_imx_probe_dt(pdev, boarddata) < 0) {
 		if (!host->mmc->parent->platform_data) {
-- 
1.7.2.rc3


