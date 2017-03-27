From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH 1/2] mmc: meson-gx: factor out setting block size
Date: Mon, 27 Mar 2017 21:57:11 +0200
Message-ID: <b9a9a85b-8975-abca-7901-b557ea7ccc13@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wr0-f194.google.com ([209.85.128.194]:33408 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751651AbdC0T5V (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 27 Mar 2017 15:57:21 -0400
Received: by mail-wr0-f194.google.com with SMTP id 20so16415966wrx.0
        for <linux-mmc@vger.kernel.org>; Mon, 27 Mar 2017 12:57:20 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@baylibre.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-amlogic@lists.infradead.org

Factor out setting the block size. This also contributes to reducing
complexity of function meson_mmc_start_cmd.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/mmc/host/meson-gx-mmc.c | 42 ++++++++++++++++++++++++++---------------
 1 file changed, 27 insertions(+), 15 deletions(-)

diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
index f5dd5cc7..0de32008 100644
--- a/drivers/mmc/host/meson-gx-mmc.c
+++ b/drivers/mmc/host/meson-gx-mmc.c
@@ -431,12 +431,36 @@ static void meson_mmc_request_done(struct mmc_host *mmc,
 	mmc_request_done(host->mmc, mrq);
 }
 
+static void meson_mmc_set_blksz(struct mmc_host *mmc, unsigned int blksz)
+{
+	struct meson_host *host = mmc_priv(mmc);
+	u32 cfg, blksz_old;
+
+	cfg = readl(host->regs + SD_EMMC_CFG);
+	blksz_old = FIELD_GET(CFG_BLK_LEN_MASK, cfg);
+
+	if (!is_power_of_2(blksz))
+		dev_err(host->dev, "blksz %u is not a power of 2\n", blksz);
+
+	blksz = ilog2(blksz);
+
+	/* check if block-size matches, if not update */
+	if (blksz == blksz_old)
+		return;
+
+	dev_dbg(host->dev, "%s: update blk_len %d -> %d\n", __func__,
+		blksz_old, blksz);
+
+	cfg &= ~CFG_BLK_LEN_MASK;
+	cfg |= FIELD_PREP(CFG_BLK_LEN_MASK, blksz);
+	writel(cfg, host->regs + SD_EMMC_CFG);
+}
+
 static void meson_mmc_start_cmd(struct mmc_host *mmc, struct mmc_command *cmd)
 {
 	struct meson_host *host = mmc_priv(mmc);
 	struct mmc_data *data = cmd->data;
-	u32 cfg, cmd_cfg = 0, cmd_data = 0;
-	u8 blk_len;
+	u32 cmd_cfg = 0, cmd_data = 0;
 	unsigned int xfer_bytes = 0;
 
 	/* Setup descriptors */
@@ -470,19 +494,7 @@ static void meson_mmc_start_cmd(struct mmc_host *mmc, struct mmc_command *cmd)
 			cmd_cfg |= CMD_CFG_BLOCK_MODE;
 			cmd_cfg |= FIELD_PREP(CMD_CFG_LENGTH_MASK,
 					      data->blocks);
-
-			/* check if block-size matches, if not update */
-			cfg = readl(host->regs + SD_EMMC_CFG);
-			blk_len = FIELD_GET(CFG_BLK_LEN_MASK, cfg);
-			if (blk_len != ilog2(data->blksz)) {
-				dev_dbg(host->dev, "%s: update blk_len %d -> %d\n",
-					__func__, blk_len,
-					ilog2(data->blksz));
-				blk_len = ilog2(data->blksz);
-				cfg &= ~CFG_BLK_LEN_MASK;
-				cfg |= FIELD_PREP(CFG_BLK_LEN_MASK, blk_len);
-				writel(cfg, host->regs + SD_EMMC_CFG);
-			}
+			meson_mmc_set_blksz(mmc, data->blksz);
 		} else {
 			cmd_cfg |= FIELD_PREP(CMD_CFG_LENGTH_MASK, data->blksz);
 		}
-- 
2.12.1

