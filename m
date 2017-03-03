From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH v4 10/10] mmc: meson-gx: replace magic timeout numbers with
 constants
Date: Fri, 3 Mar 2017 21:00:22 +0100
Message-ID: <db125858-a82b-fb0b-d009-1eb474273fb3@gmail.com>
References: <62912f3d-2307-cfff-3c69-c8b8ffaeb474@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:34825 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752320AbdCCUAx (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 3 Mar 2017 15:00:53 -0500
Received: by mail-wr0-f195.google.com with SMTP id u108so10557374wrb.2
        for <linux-mmc@vger.kernel.org>; Fri, 03 Mar 2017 12:00:52 -0800 (PST)
In-Reply-To: <62912f3d-2307-cfff-3c69-c8b8ffaeb474@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@baylibre.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-amlogic@lists.infradead.org

Replace timeout magic numbers with proper constants.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
Acked-by: Kevin Hilman <khilman@baylibre.com>
---
v3:
- added to patch series
v4:
- added acked-by
---
 drivers/mmc/host/meson-gx-mmc.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
index 5281014e..f244fcf9 100644
--- a/drivers/mmc/host/meson-gx-mmc.c
+++ b/drivers/mmc/host/meson-gx-mmc.c
@@ -116,6 +116,8 @@
 
 #define SD_EMMC_CFG_BLK_SIZE 512 /* internal buffer max: 512 bytes */
 #define SD_EMMC_CFG_RESP_TIMEOUT 256 /* in clock cycles */
+#define SD_EMMC_CMD_TIMEOUT 1024 /* in ms */
+#define SD_EMMC_CMD_TIMEOUT_DATA 4096 /* in ms */
 #define SD_EMMC_CFG_CMD_GAP 16 /* in clock cycles */
 #define MUX_CLK_NUM_PARENTS 2
 
@@ -498,10 +500,10 @@ static void meson_mmc_start_cmd(struct mmc_host *mmc, struct mmc_command *cmd)
 
 		desc->cmd_data = host->bounce_dma_addr & CMD_DATA_MASK;
 
-		cmd_cfg_timeout = 12;
+		cmd_cfg_timeout = ilog2(SD_EMMC_CMD_TIMEOUT_DATA);
 	} else {
 		desc->cmd_cfg &= ~CMD_CFG_DATA_IO;
-		cmd_cfg_timeout = 10;
+		cmd_cfg_timeout = ilog2(SD_EMMC_CMD_TIMEOUT);
 	}
 	desc->cmd_cfg |= (cmd_cfg_timeout & CMD_CFG_TIMEOUT_MASK) <<
 		CMD_CFG_TIMEOUT_SHIFT;
-- 
2.11.1



