From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH 07/18] mmc: meson-gx: check return value of
 sg_copy_[from,to]_buffer
Date: Tue, 14 Feb 2017 21:06:31 +0100
Message-ID: <5c7ff200-258a-f573-b552-63ba0d8a029b@gmail.com>
References: <420b75a9-b8c2-b3d7-ae60-3ed8a5a18ead@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:34206 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754589AbdBNUHj (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 14 Feb 2017 15:07:39 -0500
Received: by mail-wr0-f195.google.com with SMTP id c4so3370565wrd.1
        for <linux-mmc@vger.kernel.org>; Tue, 14 Feb 2017 12:07:39 -0800 (PST)
In-Reply-To: <420b75a9-b8c2-b3d7-ae60-3ed8a5a18ead@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@baylibre.com>
Cc: Carlo Caione <carlo@caione.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-amlogic@lists.infradead.org

So far it's only checked whether the requested transfer length exceeds
the bounce buffer size. Instead let's check that sg_copy_[from,to]_buffer
transferred exactly the number of requested bytes.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/mmc/host/meson-gx-mmc.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
index 423b4b17..f3963538 100644
--- a/drivers/mmc/host/meson-gx-mmc.c
+++ b/drivers/mmc/host/meson-gx-mmc.c
@@ -495,14 +495,14 @@ static void meson_mmc_start_cmd(struct mmc_host *mmc, struct mmc_command *cmd)
 		cmd->data->bytes_xfered = 0;
 		xfer_bytes = cmd->data->blksz * cmd->data->blocks;
 		if (cmd->data->flags & MMC_DATA_WRITE) {
-			cmd_cfg |= CMD_CFG_DATA_WR;
-			WARN_ON(xfer_bytes > host->bounce_buf_size);
-			sg_copy_to_buffer(cmd->data->sg, cmd->data->sg_len,
-					  host->bounce_buf, xfer_bytes);
+			size_t len = sg_copy_to_buffer(cmd->data->sg,
+						       cmd->data->sg_len,
+						       host->bounce_buf,
+						       host->bounce_buf_size);
+			WARN_ON(len != xfer_bytes);
 			cmd->data->bytes_xfered = xfer_bytes;
+			cmd_cfg |= CMD_CFG_DATA_WR;
 			dma_wmb();
-		} else {
-			cmd_cfg &= ~CMD_CFG_DATA_WR;
 		}
 
 		cmd_data = host->bounce_dma_addr & CMD_DATA_MASK;
@@ -657,10 +657,11 @@ static irqreturn_t meson_mmc_irq_thread(int irq, void *dev_id)
 
 	data = cmd->data;
 	if (data && data->flags & MMC_DATA_READ) {
+		size_t len = sg_copy_from_buffer(data->sg, data->sg_len,
+						 host->bounce_buf,
+						 host->bounce_buf_size);
 		xfer_bytes = data->blksz * data->blocks;
-		WARN_ON(xfer_bytes > host->bounce_buf_size);
-		sg_copy_from_buffer(data->sg, data->sg_len,
-				    host->bounce_buf, xfer_bytes);
+		WARN_ON(len != xfer_bytes);
 		data->bytes_xfered = xfer_bytes;
 	}
 
-- 
2.11.1


