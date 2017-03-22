From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH 1/6] mmc: meson-gx: remove unneeded configuration bit resets
Date: Wed, 22 Mar 2017 22:18:37 +0100
Message-ID: <bc05bb2e-f42d-cd66-c0d8-04d2e98e0c5d@gmail.com>
References: <8bf58a83-d8d7-615c-c89b-87a62a3c9c40@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35901 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752775AbdCVVeN (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 22 Mar 2017 17:34:13 -0400
Received: by mail-wm0-f66.google.com with SMTP id x124so13082012wmf.3
        for <linux-mmc@vger.kernel.org>; Wed, 22 Mar 2017 14:34:12 -0700 (PDT)
In-Reply-To: <8bf58a83-d8d7-615c-c89b-87a62a3c9c40@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@baylibre.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-amlogic@lists.infradead.org

The variables holding the configuration bits are zero-initialized.
So we can remove all bit resets.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/mmc/host/meson-gx-mmc.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
index bd075fef..04a55577 100644
--- a/drivers/mmc/host/meson-gx-mmc.c
+++ b/drivers/mmc/host/meson-gx-mmc.c
@@ -441,7 +441,6 @@ static void meson_mmc_start_cmd(struct mmc_host *mmc, struct mmc_command *cmd)
 
 	/* Response */
 	if (cmd->flags & MMC_RSP_PRESENT) {
-		desc->cmd_cfg &= ~CMD_CFG_NO_RESP;
 		if (cmd->flags & MMC_RSP_136)
 			desc->cmd_cfg |= CMD_CFG_RESP_128;
 		desc->cmd_cfg |= CMD_CFG_RESP_NUM;
@@ -479,7 +478,6 @@ static void meson_mmc_start_cmd(struct mmc_host *mmc, struct mmc_command *cmd)
 				writel(cfg, host->regs + SD_EMMC_CFG);
 			}
 		} else {
-			desc->cmd_cfg &= ~CMD_CFG_BLOCK_MODE;
 			desc->cmd_cfg |=
 				(cmd->data->blksz & CMD_CFG_LENGTH_MASK) <<
 				CMD_CFG_LENGTH_SHIFT;
@@ -494,15 +492,12 @@ static void meson_mmc_start_cmd(struct mmc_host *mmc, struct mmc_command *cmd)
 					  host->bounce_buf, xfer_bytes);
 			cmd->data->bytes_xfered = xfer_bytes;
 			dma_wmb();
-		} else {
-			desc->cmd_cfg &= ~CMD_CFG_DATA_WR;
 		}
 
 		desc->cmd_data = host->bounce_dma_addr & CMD_DATA_MASK;
 
 		cmd_cfg_timeout = ilog2(SD_EMMC_CMD_TIMEOUT_DATA);
 	} else {
-		desc->cmd_cfg &= ~CMD_CFG_DATA_IO;
 		cmd_cfg_timeout = ilog2(SD_EMMC_CMD_TIMEOUT);
 	}
 	desc->cmd_cfg |= (cmd_cfg_timeout & CMD_CFG_TIMEOUT_MASK) <<
-- 
2.12.0


