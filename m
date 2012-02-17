From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH] mmc sdhci i.MX5: make mmc cards work
Date: Fri, 17 Feb 2012 11:51:49 +0100
Message-ID: <1329475909-29047-1-git-send-email-s.hauer@pengutronix.de>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:58582 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751999Ab2BQKvy (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 17 Feb 2012 05:51:54 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Chris Ball <cjb@laptop.org>, Shawn Guo <shawn.guo@linaro.org>, Wolfram Sang <w.sang@pengutronix.de>, Sascha Hauer <s.hauer@pengutronix.de>

On i.MX53 we have to write a special SDHCI_CMD_ABORTCMD to the
SDHCI_TRANSFER_MODE register during a MMC_STOP_TRANSMISSION
command. This works for SD cards. However, with MMC cards
the MMC_SET_BLOCK_COUNT command is used instead, but this needs
the same handling. Fix MMC cards by testing for the
MMC_SET_BLOCK_COUNT command aswell. Tested on a custom i.MX53
board with a Transcend MMC+ card and eMMC.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/mmc/host/sdhci-esdhc-imx.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index d601e41..cd35dc4 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -269,7 +269,8 @@ static void esdhc_writew_le(struct sdhci_host *host, u16 val, int reg)
 		imx_data->scratchpad = val;
 		return;
 	case SDHCI_COMMAND:
-		if ((host->cmd->opcode == MMC_STOP_TRANSMISSION)
+		if ((host->cmd->opcode == MMC_STOP_TRANSMISSION ||
+			host->cmd->opcode == MMC_SET_BLOCK_COUNT)
 			&& (imx_data->flags & ESDHC_FLAG_MULTIBLK_NO_INT))
 			val |= SDHCI_CMD_ABORTCMD;
 
-- 
1.7.9

