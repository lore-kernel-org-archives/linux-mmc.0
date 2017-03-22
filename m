From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH 6/6] mmc: meson-gx: simplify setting timeout configuration
 parameters
Date: Wed, 22 Mar 2017 22:34:01 +0100
Message-ID: <8105b3e7-9c80-038e-9cfe-53139d6892ce@gmail.com>
References: <8bf58a83-d8d7-615c-c89b-87a62a3c9c40@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34933 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753759AbdCVVeZ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 22 Mar 2017 17:34:25 -0400
Received: by mail-wm0-f65.google.com with SMTP id z133so13143852wmb.2
        for <linux-mmc@vger.kernel.org>; Wed, 22 Mar 2017 14:34:18 -0700 (PDT)
In-Reply-To: <8bf58a83-d8d7-615c-c89b-87a62a3c9c40@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@baylibre.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-amlogic@lists.infradead.org

We don't need variable cmd_cfg_timeout, so remove it and simplify the
code a little.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/mmc/host/meson-gx-mmc.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
index 87303404..b917765c 100644
--- a/drivers/mmc/host/meson-gx-mmc.c
+++ b/drivers/mmc/host/meson-gx-mmc.c
@@ -426,7 +426,7 @@ static void meson_mmc_start_cmd(struct mmc_host *mmc, struct mmc_command *cmd)
 	struct meson_host *host = mmc_priv(mmc);
 	struct mmc_data *data = cmd->data;
 	u32 cfg, cmd_cfg = 0, cmd_data = 0;
-	u8 blk_len, cmd_cfg_timeout;
+	u8 blk_len;
 	unsigned int xfer_bytes = 0;
 
 	/* Setup descriptors */
@@ -454,6 +454,9 @@ static void meson_mmc_start_cmd(struct mmc_host *mmc, struct mmc_command *cmd)
 	/* data? */
 	if (data) {
 		cmd_cfg |= CMD_CFG_DATA_IO;
+		cmd_cfg |= ilog2(SD_EMMC_CMD_TIMEOUT_DATA) <<
+			   CMD_CFG_TIMEOUT_SHIFT;
+
 		if (data->blocks > 1) {
 			cmd_cfg |= CMD_CFG_BLOCK_MODE;
 			cmd_cfg |= (data->blocks & CMD_CFG_LENGTH_MASK) <<
@@ -488,13 +491,9 @@ static void meson_mmc_start_cmd(struct mmc_host *mmc, struct mmc_command *cmd)
 		}
 
 		cmd_data = host->bounce_dma_addr & CMD_DATA_MASK;
-
-		cmd_cfg_timeout = ilog2(SD_EMMC_CMD_TIMEOUT_DATA);
 	} else {
-		cmd_cfg_timeout = ilog2(SD_EMMC_CMD_TIMEOUT);
+		cmd_cfg |= ilog2(SD_EMMC_CMD_TIMEOUT) << CMD_CFG_TIMEOUT_SHIFT;
 	}
-	cmd_cfg |= (cmd_cfg_timeout & CMD_CFG_TIMEOUT_MASK) <<
-		   CMD_CFG_TIMEOUT_SHIFT;
 
 	host->cmd = cmd;
 
-- 
2.12.0


