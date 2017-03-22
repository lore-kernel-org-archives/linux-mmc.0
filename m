From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH 3/6] mmc: meson-gx: improve variable usage in
 meson_mmc_start_cmd
Date: Wed, 22 Mar 2017 22:33:47 +0100
Message-ID: <61dca1b6-aabb-5934-f389-590761c40982@gmail.com>
References: <8bf58a83-d8d7-615c-c89b-87a62a3c9c40@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34742 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753654AbdCVVeQ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 22 Mar 2017 17:34:16 -0400
Received: by mail-wm0-f66.google.com with SMTP id u132so13036718wmg.1
        for <linux-mmc@vger.kernel.org>; Wed, 22 Mar 2017 14:34:15 -0700 (PDT)
In-Reply-To: <8bf58a83-d8d7-615c-c89b-87a62a3c9c40@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@baylibre.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-amlogic@lists.infradead.org

Simplify the code by using two variables instead of a struct sd_emmc_desc.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/mmc/host/meson-gx-mmc.c | 55 ++++++++++++++++++-----------------------
 1 file changed, 24 insertions(+), 31 deletions(-)

diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
index 1b20ec1a..8bf3eb54 100644
--- a/drivers/mmc/host/meson-gx-mmc.c
+++ b/drivers/mmc/host/meson-gx-mmc.c
@@ -425,45 +425,39 @@ static void meson_mmc_start_cmd(struct mmc_host *mmc, struct mmc_command *cmd)
 {
 	struct meson_host *host = mmc_priv(mmc);
 	struct mmc_data *data = cmd->data;
-	struct sd_emmc_desc *desc, desc_tmp;
-	u32 cfg;
+	u32 cfg, cmd_cfg = 0, cmd_data = 0;
 	u8 blk_len, cmd_cfg_timeout;
 	unsigned int xfer_bytes = 0;
 
 	/* Setup descriptors */
 	dma_rmb();
-	desc = &desc_tmp;
-	memset(desc, 0, sizeof(struct sd_emmc_desc));
 
-	desc->cmd_cfg |= (cmd->opcode & CMD_CFG_CMD_INDEX_MASK)	<<
-		CMD_CFG_CMD_INDEX_SHIFT;
-	desc->cmd_cfg |= CMD_CFG_OWNER;  /* owned by CPU */
-	desc->cmd_arg = cmd->arg;
+	cmd_cfg |= (cmd->opcode & CMD_CFG_CMD_INDEX_MASK) <<
+		   CMD_CFG_CMD_INDEX_SHIFT;
+	cmd_cfg |= CMD_CFG_OWNER;  /* owned by CPU */
 
 	/* Response */
 	if (cmd->flags & MMC_RSP_PRESENT) {
 		if (cmd->flags & MMC_RSP_136)
-			desc->cmd_cfg |= CMD_CFG_RESP_128;
-		desc->cmd_cfg |= CMD_CFG_RESP_NUM;
-		desc->cmd_resp = 0;
+			cmd_cfg |= CMD_CFG_RESP_128;
+		cmd_cfg |= CMD_CFG_RESP_NUM;
 
 		if (!(cmd->flags & MMC_RSP_CRC))
-			desc->cmd_cfg |= CMD_CFG_RESP_NOCRC;
+			cmd_cfg |= CMD_CFG_RESP_NOCRC;
 
 		if (cmd->flags & MMC_RSP_BUSY)
-			desc->cmd_cfg |= CMD_CFG_R1B;
+			cmd_cfg |= CMD_CFG_R1B;
 	} else {
-		desc->cmd_cfg |= CMD_CFG_NO_RESP;
+		cmd_cfg |= CMD_CFG_NO_RESP;
 	}
 
 	/* data? */
 	if (data) {
-		desc->cmd_cfg |= CMD_CFG_DATA_IO;
+		cmd_cfg |= CMD_CFG_DATA_IO;
 		if (data->blocks > 1) {
-			desc->cmd_cfg |= CMD_CFG_BLOCK_MODE;
-			desc->cmd_cfg |=
-				(data->blocks & CMD_CFG_LENGTH_MASK) <<
-				CMD_CFG_LENGTH_SHIFT;
+			cmd_cfg |= CMD_CFG_BLOCK_MODE;
+			cmd_cfg |= (data->blocks & CMD_CFG_LENGTH_MASK) <<
+				   CMD_CFG_LENGTH_SHIFT;
 
 			/* check if block-size matches, if not update */
 			cfg = readl(host->regs + SD_EMMC_CFG);
@@ -479,15 +473,14 @@ static void meson_mmc_start_cmd(struct mmc_host *mmc, struct mmc_command *cmd)
 				writel(cfg, host->regs + SD_EMMC_CFG);
 			}
 		} else {
-			desc->cmd_cfg |=
-				(data->blksz & CMD_CFG_LENGTH_MASK) <<
-				CMD_CFG_LENGTH_SHIFT;
+			cmd_cfg |= (data->blksz & CMD_CFG_LENGTH_MASK) <<
+				   CMD_CFG_LENGTH_SHIFT;
 		}
 
 		data->bytes_xfered = 0;
 		xfer_bytes = data->blksz * data->blocks;
 		if (data->flags & MMC_DATA_WRITE) {
-			desc->cmd_cfg |= CMD_CFG_DATA_WR;
+			cmd_cfg |= CMD_CFG_DATA_WR;
 			WARN_ON(xfer_bytes > host->bounce_buf_size);
 			sg_copy_to_buffer(data->sg, data->sg_len,
 					  host->bounce_buf, xfer_bytes);
@@ -495,24 +488,24 @@ static void meson_mmc_start_cmd(struct mmc_host *mmc, struct mmc_command *cmd)
 			dma_wmb();
 		}
 
-		desc->cmd_data = host->bounce_dma_addr & CMD_DATA_MASK;
+		cmd_data = host->bounce_dma_addr & CMD_DATA_MASK;
 
 		cmd_cfg_timeout = ilog2(SD_EMMC_CMD_TIMEOUT_DATA);
 	} else {
 		cmd_cfg_timeout = ilog2(SD_EMMC_CMD_TIMEOUT);
 	}
-	desc->cmd_cfg |= (cmd_cfg_timeout & CMD_CFG_TIMEOUT_MASK) <<
-		CMD_CFG_TIMEOUT_SHIFT;
+	cmd_cfg |= (cmd_cfg_timeout & CMD_CFG_TIMEOUT_MASK) <<
+		   CMD_CFG_TIMEOUT_SHIFT;
 
 	host->cmd = cmd;
 
 	/* Last descriptor */
-	desc->cmd_cfg |= CMD_CFG_END_OF_CHAIN;
-	writel(desc->cmd_cfg, host->regs + SD_EMMC_CMD_CFG);
-	writel(desc->cmd_data, host->regs + SD_EMMC_CMD_DAT);
-	writel(desc->cmd_resp, host->regs + SD_EMMC_CMD_RSP);
+	cmd_cfg |= CMD_CFG_END_OF_CHAIN;
+	writel(cmd_cfg, host->regs + SD_EMMC_CMD_CFG);
+	writel(cmd_data, host->regs + SD_EMMC_CMD_DAT);
+	writel(0, host->regs + SD_EMMC_CMD_RSP);
 	wmb(); /* ensure descriptor is written before kicked */
-	writel(desc->cmd_arg, host->regs + SD_EMMC_CMD_ARG);
+	writel(cmd->arg, host->regs + SD_EMMC_CMD_ARG);
 }
 
 static void meson_mmc_request(struct mmc_host *mmc, struct mmc_request *mrq)
-- 
2.12.0


