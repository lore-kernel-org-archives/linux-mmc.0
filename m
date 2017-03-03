From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH v4 1/10] mmc: meson-gx: simplify bounce buffer setting in
 meson_mmc_start_cmd
Date: Fri, 3 Mar 2017 20:51:31 +0100
Message-ID: <6e9c0183-2c78-6c47-939c-4e65b3bec254@gmail.com>
References: <62912f3d-2307-cfff-3c69-c8b8ffaeb474@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:36029 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751842AbdCCUAk (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 3 Mar 2017 15:00:40 -0500
Received: by mail-wr0-f195.google.com with SMTP id l37so14500066wrc.3
        for <linux-mmc@vger.kernel.org>; Fri, 03 Mar 2017 12:00:39 -0800 (PST)
In-Reply-To: <62912f3d-2307-cfff-3c69-c8b8ffaeb474@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@baylibre.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-amlogic@lists.infradead.org

Core ensures that there are no commands with cmd->data being set and
nothing to transfer. And we don't have to reset bit CMD_CFG_DATA_NUM
because cmd_cfg was zero-initialized and this bit isn't set.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
Acked-by: Kevin Hilman <khilman@baylibre.com>
---
v2:
- adjusted commit message because branch xfer_bytes == 0 is never reached
- added acked-by
v3:
- no changes
v4:
- no changes
---
 drivers/mmc/host/meson-gx-mmc.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
index 5a959783..07a7399c 100644
--- a/drivers/mmc/host/meson-gx-mmc.c
+++ b/drivers/mmc/host/meson-gx-mmc.c
@@ -516,14 +516,7 @@ static void meson_mmc_start_cmd(struct mmc_host *mmc, struct mmc_command *cmd)
 			desc->cmd_cfg &= ~CMD_CFG_DATA_WR;
 		}
 
-		if (xfer_bytes > 0) {
-			desc->cmd_cfg &= ~CMD_CFG_DATA_NUM;
-			desc->cmd_data = host->bounce_dma_addr & CMD_DATA_MASK;
-		} else {
-			/* write data to data_addr */
-			desc->cmd_cfg |= CMD_CFG_DATA_NUM;
-			desc->cmd_data = 0;
-		}
+		desc->cmd_data = host->bounce_dma_addr & CMD_DATA_MASK;
 
 		cmd_cfg_timeout = 12;
 	} else {
-- 
2.11.1


