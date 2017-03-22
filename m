From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH 2/6] mmc: meson-gx: replace cmd->data in meson_mmc_start_cmd
Date: Wed, 22 Mar 2017 22:33:44 +0100
Message-ID: <8c9c00f8-fd74-c9ae-552e-f518ae7844ce@gmail.com>
References: <8bf58a83-d8d7-615c-c89b-87a62a3c9c40@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wr0-f193.google.com ([209.85.128.193]:36813 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753656AbdCVVeQ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 22 Mar 2017 17:34:16 -0400
Received: by mail-wr0-f193.google.com with SMTP id l37so28562316wrc.3
        for <linux-mmc@vger.kernel.org>; Wed, 22 Mar 2017 14:34:15 -0700 (PDT)
In-Reply-To: <8bf58a83-d8d7-615c-c89b-87a62a3c9c40@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@baylibre.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-amlogic@lists.infradead.org

Replace cmd->data with a local variable to simplify code a little.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/mmc/host/meson-gx-mmc.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
index 04a55577..1b20ec1a 100644
--- a/drivers/mmc/host/meson-gx-mmc.c
+++ b/drivers/mmc/host/meson-gx-mmc.c
@@ -424,6 +424,7 @@ static void meson_mmc_request_done(struct mmc_host *mmc,
 static void meson_mmc_start_cmd(struct mmc_host *mmc, struct mmc_command *cmd)
 {
 	struct meson_host *host = mmc_priv(mmc);
+	struct mmc_data *data = cmd->data;
 	struct sd_emmc_desc *desc, desc_tmp;
 	u32 cfg;
 	u8 blk_len, cmd_cfg_timeout;
@@ -456,41 +457,41 @@ static void meson_mmc_start_cmd(struct mmc_host *mmc, struct mmc_command *cmd)
 	}
 
 	/* data? */
-	if (cmd->data) {
+	if (data) {
 		desc->cmd_cfg |= CMD_CFG_DATA_IO;
-		if (cmd->data->blocks > 1) {
+		if (data->blocks > 1) {
 			desc->cmd_cfg |= CMD_CFG_BLOCK_MODE;
 			desc->cmd_cfg |=
-				(cmd->data->blocks & CMD_CFG_LENGTH_MASK) <<
+				(data->blocks & CMD_CFG_LENGTH_MASK) <<
 				CMD_CFG_LENGTH_SHIFT;
 
 			/* check if block-size matches, if not update */
 			cfg = readl(host->regs + SD_EMMC_CFG);
 			blk_len = cfg & (CFG_BLK_LEN_MASK << CFG_BLK_LEN_SHIFT);
 			blk_len >>= CFG_BLK_LEN_SHIFT;
-			if (blk_len != ilog2(cmd->data->blksz)) {
+			if (blk_len != ilog2(data->blksz)) {
 				dev_dbg(host->dev, "%s: update blk_len %d -> %d\n",
 					__func__, blk_len,
-					ilog2(cmd->data->blksz));
-				blk_len = ilog2(cmd->data->blksz);
+					ilog2(data->blksz));
+				blk_len = ilog2(data->blksz);
 				cfg &= ~(CFG_BLK_LEN_MASK << CFG_BLK_LEN_SHIFT);
 				cfg |= blk_len << CFG_BLK_LEN_SHIFT;
 				writel(cfg, host->regs + SD_EMMC_CFG);
 			}
 		} else {
 			desc->cmd_cfg |=
-				(cmd->data->blksz & CMD_CFG_LENGTH_MASK) <<
+				(data->blksz & CMD_CFG_LENGTH_MASK) <<
 				CMD_CFG_LENGTH_SHIFT;
 		}
 
-		cmd->data->bytes_xfered = 0;
-		xfer_bytes = cmd->data->blksz * cmd->data->blocks;
-		if (cmd->data->flags & MMC_DATA_WRITE) {
+		data->bytes_xfered = 0;
+		xfer_bytes = data->blksz * data->blocks;
+		if (data->flags & MMC_DATA_WRITE) {
 			desc->cmd_cfg |= CMD_CFG_DATA_WR;
 			WARN_ON(xfer_bytes > host->bounce_buf_size);
-			sg_copy_to_buffer(cmd->data->sg, cmd->data->sg_len,
+			sg_copy_to_buffer(data->sg, data->sg_len,
 					  host->bounce_buf, xfer_bytes);
-			cmd->data->bytes_xfered = xfer_bytes;
+			data->bytes_xfered = xfer_bytes;
 			dma_wmb();
 		}
 
-- 
2.12.0


