From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH v2 4/4] mmc: meson-gx: add CMD23 mode
Date: Sat, 25 Mar 2017 11:28:13 +0100
Message-ID: <2802b35f-7f45-223c-11c4-3a51563b3330@gmail.com>
References: <aae9e7c7-d8a2-72b1-22f7-f0ad513d4667@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36286 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751242AbdCYK2k (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 25 Mar 2017 06:28:40 -0400
Received: by mail-wm0-f68.google.com with SMTP id x124so2332953wmf.3
        for <linux-mmc@vger.kernel.org>; Sat, 25 Mar 2017 03:28:39 -0700 (PDT)
In-Reply-To: <aae9e7c7-d8a2-72b1-22f7-f0ad513d4667@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@baylibre.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-amlogic@lists.infradead.org

CMD23 mode (use "set block count" command before transferring multiple
data blocks) typically is more performant as host / card know upfront
how many data blocks to expect. Therefore add support for this mode to
the driver.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
Reviewed-by: Kevin Hilman <khilman@baylibre.com>
---
v2:
- no changes
---
 drivers/mmc/host/meson-gx-mmc.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
index 810b68d5..f5dd5cc7 100644
--- a/drivers/mmc/host/meson-gx-mmc.c
+++ b/drivers/mmc/host/meson-gx-mmc.c
@@ -175,6 +175,17 @@ static unsigned int meson_mmc_get_timeout_msecs(struct mmc_data *data)
 	return min(timeout, 32768U); /* max. 2^15 ms */
 }
 
+static struct mmc_command *meson_mmc_get_next_command(struct mmc_command *cmd)
+{
+	if (cmd->opcode == MMC_SET_BLOCK_COUNT && !cmd->error)
+		return cmd->mrq->cmd;
+	else if (mmc_op_multi(cmd->opcode) &&
+		 (!cmd->mrq->sbc || cmd->error || cmd->data->error))
+		return cmd->mrq->stop;
+	else
+		return NULL;
+}
+
 static int meson_mmc_clk_set(struct meson_host *host, unsigned long clk_rate)
 {
 	struct mmc_host *mmc = host->mmc;
@@ -620,7 +631,7 @@ static irqreturn_t meson_mmc_irq(int irq, void *dev_id)
 static irqreturn_t meson_mmc_irq_thread(int irq, void *dev_id)
 {
 	struct meson_host *host = dev_id;
-	struct mmc_command *cmd = host->cmd;
+	struct mmc_command *next_cmd, *cmd = host->cmd;
 	struct mmc_data *data;
 	unsigned int xfer_bytes;
 
@@ -635,10 +646,11 @@ static irqreturn_t meson_mmc_irq_thread(int irq, void *dev_id)
 				    host->bounce_buf, xfer_bytes);
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
@@ -750,6 +762,7 @@ static int meson_mmc_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_div_clk;
 
+	mmc->caps |= MMC_CAP_CMD23;
 	mmc->max_blk_count = CMD_CFG_LENGTH_MASK;
 	mmc->max_req_size = mmc->max_blk_count * mmc->max_blk_size;
 
-- 
2.12.0


