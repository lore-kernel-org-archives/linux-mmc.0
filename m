From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH 4/5] mmc: meson-gx: add support for CMD23 mode
Date: Wed, 15 Mar 2017 20:34:20 +0100
Message-ID: <3f10855e-0930-2a50-47d4-62c7a9f1e2ba@gmail.com>
References: <f1f8dae2-e976-4d42-99dc-34d08cb3d628@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:33222 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750774AbdCOTfC (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 15 Mar 2017 15:35:02 -0400
Received: by mail-wr0-f195.google.com with SMTP id g10so3276893wrg.0
        for <linux-mmc@vger.kernel.org>; Wed, 15 Mar 2017 12:35:01 -0700 (PDT)
In-Reply-To: <f1f8dae2-e976-4d42-99dc-34d08cb3d628@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@baylibre.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-amlogic@lists.infradead.org

This patch adds CMD23 support to the meson-gx driver. Typically it's
more performant if host and card know upfront how many blocks to
transfer.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/mmc/host/meson-gx-mmc.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
index b0dc2cdd..425060da 100644
--- a/drivers/mmc/host/meson-gx-mmc.c
+++ b/drivers/mmc/host/meson-gx-mmc.c
@@ -175,6 +175,16 @@ struct sd_emmc_desc {
 #define CMD_RESP_MASK (~0x1)
 #define CMD_RESP_SRAM BIT(0)
 
+static struct mmc_command *meson_mmc_get_next_command(struct mmc_command *cmd)
+{
+	if (cmd->opcode == MMC_SET_BLOCK_COUNT && !cmd->error)
+		return cmd->mrq->cmd;
+	else if (mmc_op_multi(cmd->opcode) && (!cmd->mrq->sbc || cmd->error))
+		return cmd->mrq->stop;
+	else
+		return NULL;
+}
+
 static int meson_mmc_clk_set(struct meson_host *host, unsigned long clk_rate)
 {
 	struct mmc_host *mmc = host->mmc;
@@ -621,7 +631,7 @@ static irqreturn_t meson_mmc_irq(int irq, void *dev_id)
 static irqreturn_t meson_mmc_irq_thread(int irq, void *dev_id)
 {
 	struct meson_host *host = dev_id;
-	struct mmc_command *cmd = host->cmd;
+	struct mmc_command *next_cmd, *cmd = host->cmd;
 	struct mmc_data *data;
 	unsigned int xfer_bytes;
 
@@ -637,10 +647,11 @@ static irqreturn_t meson_mmc_irq_thread(int irq, void *dev_id)
 		data->bytes_xfered = xfer_bytes;
 	}
 
-	if (!data || !data->stop || cmd->mrq->sbc)
-		meson_mmc_request_done(host->mmc, cmd->mrq);
+	next_cmd = meson_mmc_get_next_command(cmd);
+	if (next_cmd)
+		meson_mmc_start_cmd(host->mmc, next_cmd);
 	else
-		meson_mmc_start_cmd(host->mmc, data->stop);
+		meson_mmc_request_done(host->mmc, cmd->mrq);
 
 	return IRQ_HANDLED;
 }
@@ -751,6 +762,7 @@ static int meson_mmc_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_div_clk;
 
+	mmc->caps |= MMC_CAP_CMD23;
 	mmc->max_blk_count = CMD_CFG_LENGTH_MASK;
 	mmc->max_req_size = mmc->max_blk_count * mmc->max_blk_size;
 
-- 
2.12.0


