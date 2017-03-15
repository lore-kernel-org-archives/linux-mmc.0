From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH 3/5] mmc: meson-gx: use block mode also for just one block
Date: Wed, 15 Mar 2017 20:34:11 +0100
Message-ID: <13c861ba-9ab0-92e6-8e9a-f7d26ad36b7b@gmail.com>
References: <f1f8dae2-e976-4d42-99dc-34d08cb3d628@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35433 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750774AbdCOTfB (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 15 Mar 2017 15:35:01 -0400
Received: by mail-wm0-f68.google.com with SMTP id z63so6331491wmg.2
        for <linux-mmc@vger.kernel.org>; Wed, 15 Mar 2017 12:35:00 -0700 (PDT)
In-Reply-To: <f1f8dae2-e976-4d42-99dc-34d08cb3d628@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@baylibre.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-amlogic@lists.infradead.org

Currently block mode isn't used if just one block has to be transferred.
Change this to use block mode also in this case. This helps to simplify
the code in function meson_mmc_start_cmd which is quite (too?) complex
currently.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/mmc/host/meson-gx-mmc.c | 40 +++++++++++++++-------------------------
 1 file changed, 15 insertions(+), 25 deletions(-)

diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
index e675601e..b0dc2cdd 100644
--- a/drivers/mmc/host/meson-gx-mmc.c
+++ b/drivers/mmc/host/meson-gx-mmc.c
@@ -458,31 +458,21 @@ static void meson_mmc_start_cmd(struct mmc_host *mmc, struct mmc_command *cmd)
 
 	/* data? */
 	if (cmd->data) {
-		desc->cmd_cfg |= CMD_CFG_DATA_IO;
-		if (cmd->data->blocks > 1) {
-			desc->cmd_cfg |= CMD_CFG_BLOCK_MODE;
-			desc->cmd_cfg |=
-				(cmd->data->blocks & CMD_CFG_LENGTH_MASK) <<
-				CMD_CFG_LENGTH_SHIFT;
-
-			/* check if block-size matches, if not update */
-			cfg = readl(host->regs + SD_EMMC_CFG);
-			blk_len = cfg & (CFG_BLK_LEN_MASK << CFG_BLK_LEN_SHIFT);
-			blk_len >>= CFG_BLK_LEN_SHIFT;
-			if (blk_len != ilog2(cmd->data->blksz)) {
-				dev_dbg(host->dev, "%s: update blk_len %d -> %d\n",
-					__func__, blk_len,
-					ilog2(cmd->data->blksz));
-				blk_len = ilog2(cmd->data->blksz);
-				cfg &= ~(CFG_BLK_LEN_MASK << CFG_BLK_LEN_SHIFT);
-				cfg |= blk_len << CFG_BLK_LEN_SHIFT;
-				writel(cfg, host->regs + SD_EMMC_CFG);
-			}
-		} else {
-			desc->cmd_cfg &= ~CMD_CFG_BLOCK_MODE;
-			desc->cmd_cfg |=
-				(cmd->data->blksz & CMD_CFG_LENGTH_MASK) <<
-				CMD_CFG_LENGTH_SHIFT;
+		desc->cmd_cfg |= CMD_CFG_DATA_IO | CMD_CFG_BLOCK_MODE;
+		desc->cmd_cfg |= (cmd->data->blocks & CMD_CFG_LENGTH_MASK) <<
+				 CMD_CFG_LENGTH_SHIFT;
+
+		/* check if block-size matches, if not update */
+		cfg = readl(host->regs + SD_EMMC_CFG);
+		blk_len = cfg & (CFG_BLK_LEN_MASK << CFG_BLK_LEN_SHIFT);
+		blk_len >>= CFG_BLK_LEN_SHIFT;
+		if (blk_len != ilog2(cmd->data->blksz)) {
+			dev_dbg(host->dev, "%s: update blk_len %d -> %d\n",
+				__func__, blk_len, ilog2(cmd->data->blksz));
+			blk_len = ilog2(cmd->data->blksz);
+			cfg &= ~(CFG_BLK_LEN_MASK << CFG_BLK_LEN_SHIFT);
+			cfg |= blk_len << CFG_BLK_LEN_SHIFT;
+			writel(cfg, host->regs + SD_EMMC_CFG);
 		}
 
 		cmd->data->bytes_xfered = 0;
-- 
2.12.0


