From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH 05/18] mmc: meson-gx: eliminate struct sd_emmc_data
Date: Tue, 14 Feb 2017 21:06:22 +0100
Message-ID: <4a344def-d2de-ef25-8506-8ad92b8147ce@gmail.com>
References: <420b75a9-b8c2-b3d7-ae60-3ed8a5a18ead@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36669 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754589AbdBNUHi (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 14 Feb 2017 15:07:38 -0500
Received: by mail-wm0-f65.google.com with SMTP id r18so5221614wmd.3
        for <linux-mmc@vger.kernel.org>; Tue, 14 Feb 2017 12:07:37 -0800 (PST)
In-Reply-To: <420b75a9-b8c2-b3d7-ae60-3ed8a5a18ead@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@baylibre.com>
Cc: Carlo Caione <carlo@caione.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-amlogic@lists.infradead.org

Struct sd_emmc_data is used in meson_mmc_start_cmd only, so we can get
rid of this struct and replace the two used members with local variables.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/mmc/host/meson-gx-mmc.c | 69 +++++++++++++++++------------------------
 1 file changed, 29 insertions(+), 40 deletions(-)

diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
index 630e0590..c7bf0e12 100644
--- a/drivers/mmc/host/meson-gx-mmc.c
+++ b/drivers/mmc/host/meson-gx-mmc.c
@@ -146,12 +146,6 @@ struct meson_host {
 	bool vqmmc_enabled;
 };
 
-struct sd_emmc_desc {
-	u32 cmd_cfg;
-	u32 cmd_arg;
-	u32 cmd_data;
-	u32 cmd_resp;
-};
 #define CMD_CFG_LENGTH_SHIFT 0
 #define CMD_CFG_LENGTH_MASK 0x1ff
 #define CMD_CFG_BLOCK_MODE BIT(9)
@@ -443,45 +437,41 @@ static int meson_mmc_request_done(struct mmc_host *mmc, struct mmc_request *mrq)
 static void meson_mmc_start_cmd(struct mmc_host *mmc, struct mmc_command *cmd)
 {
 	struct meson_host *host = mmc_priv(mmc);
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
+	cmd_cfg |= (cmd->opcode & CMD_CFG_CMD_INDEX_MASK) <<
+		   CMD_CFG_CMD_INDEX_SHIFT;
+	cmd_cfg |= CMD_CFG_OWNER;  /* owned by CPU */
 
 	/* Response */
 	if (cmd->flags & MMC_RSP_PRESENT) {
-		desc->cmd_cfg &= ~CMD_CFG_NO_RESP;
+		cmd_cfg &= ~CMD_CFG_NO_RESP;
 		if (cmd->flags & MMC_RSP_136)
-			desc->cmd_cfg |= CMD_CFG_RESP_128;
-		desc->cmd_cfg |= CMD_CFG_RESP_NUM;
+			cmd_cfg |= CMD_CFG_RESP_128;
+		cmd_cfg |= CMD_CFG_RESP_NUM;
 		writel(0, host->regs + SD_EMMC_CMD_RSP);
 
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
 	if (cmd->data) {
-		desc->cmd_cfg |= CMD_CFG_DATA_IO;
+		cmd_cfg |= CMD_CFG_DATA_IO;
 		if (cmd->data->blocks > 1) {
-			desc->cmd_cfg |= CMD_CFG_BLOCK_MODE;
-			desc->cmd_cfg |=
-				(cmd->data->blocks & CMD_CFG_LENGTH_MASK) <<
-				CMD_CFG_LENGTH_SHIFT;
+			cmd_cfg |= CMD_CFG_BLOCK_MODE;
+			cmd_cfg |= (cmd->data->blocks & CMD_CFG_LENGTH_MASK) <<
+				   CMD_CFG_LENGTH_SHIFT;
 
 			/* check if block-size matches, if not update */
 			cfg = readl(host->regs + SD_EMMC_CFG);
@@ -497,48 +487,47 @@ static void meson_mmc_start_cmd(struct mmc_host *mmc, struct mmc_command *cmd)
 				writel(cfg, host->regs + SD_EMMC_CFG);
 			}
 		} else {
-			desc->cmd_cfg &= ~CMD_CFG_BLOCK_MODE;
-			desc->cmd_cfg |=
-				(cmd->data->blksz & CMD_CFG_LENGTH_MASK) <<
-				CMD_CFG_LENGTH_SHIFT;
+			cmd_cfg &= ~CMD_CFG_BLOCK_MODE;
+			cmd_cfg |= (cmd->data->blksz & CMD_CFG_LENGTH_MASK) <<
+				   CMD_CFG_LENGTH_SHIFT;
 		}
 
 		cmd->data->bytes_xfered = 0;
 		xfer_bytes = cmd->data->blksz * cmd->data->blocks;
 		if (cmd->data->flags & MMC_DATA_WRITE) {
-			desc->cmd_cfg |= CMD_CFG_DATA_WR;
+			cmd_cfg |= CMD_CFG_DATA_WR;
 			WARN_ON(xfer_bytes > host->bounce_buf_size);
 			sg_copy_to_buffer(cmd->data->sg, cmd->data->sg_len,
 					  host->bounce_buf, xfer_bytes);
 			cmd->data->bytes_xfered = xfer_bytes;
 			dma_wmb();
 		} else {
-			desc->cmd_cfg &= ~CMD_CFG_DATA_WR;
+			cmd_cfg &= ~CMD_CFG_DATA_WR;
 		}
 
 		if (xfer_bytes > 0) {
-			desc->cmd_cfg &= ~CMD_CFG_DATA_NUM;
-			desc->cmd_data = host->bounce_dma_addr & CMD_DATA_MASK;
+			cmd_cfg &= ~CMD_CFG_DATA_NUM;
+			cmd_data = host->bounce_dma_addr & CMD_DATA_MASK;
 		} else {
 			/* write data to data_addr */
-			desc->cmd_cfg |= CMD_CFG_DATA_NUM;
-			desc->cmd_data = 0;
+			cmd_cfg |= CMD_CFG_DATA_NUM;
+			cmd_data = 0;
 		}
 
 		cmd_cfg_timeout = 12;
 	} else {
-		desc->cmd_cfg &= ~CMD_CFG_DATA_IO;
+		cmd_cfg &= ~CMD_CFG_DATA_IO;
 		cmd_cfg_timeout = 10;
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
+	cmd_cfg |= CMD_CFG_END_OF_CHAIN;
+	writel(cmd_cfg, host->regs + SD_EMMC_CMD_CFG);
+	writel(cmd_data, host->regs + SD_EMMC_CMD_DAT);
 	wmb(); /* ensure descriptor is written before kicked */
 	writel(cmd->arg, host->regs + SD_EMMC_CMD_ARG);
 }
-- 
2.11.1


