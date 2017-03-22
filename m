From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH 5/6] mmc: meson-gx: improve setting data->bytes_xfered
Date: Wed, 22 Mar 2017 22:33:53 +0100
Message-ID: <168682c3-1b46-28ec-36cc-65573efcb896@gmail.com>
References: <8bf58a83-d8d7-615c-c89b-87a62a3c9c40@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34769 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753756AbdCVVeX (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 22 Mar 2017 17:34:23 -0400
Received: by mail-wm0-f65.google.com with SMTP id u132so13036883wmg.1
        for <linux-mmc@vger.kernel.org>; Wed, 22 Mar 2017 14:34:22 -0700 (PDT)
In-Reply-To: <8bf58a83-d8d7-615c-c89b-87a62a3c9c40@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@baylibre.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-amlogic@lists.infradead.org

Centralize setting data->bytes_xfered in one place and make sure
that the number of transfererd bytes is set only if we receive
the end-of-chain interrupt and there was no error.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/mmc/host/meson-gx-mmc.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
index c4ddd820..87303404 100644
--- a/drivers/mmc/host/meson-gx-mmc.c
+++ b/drivers/mmc/host/meson-gx-mmc.c
@@ -484,7 +484,6 @@ static void meson_mmc_start_cmd(struct mmc_host *mmc, struct mmc_command *cmd)
 			WARN_ON(xfer_bytes > host->bounce_buf_size);
 			sg_copy_to_buffer(data->sg, data->sg_len,
 					  host->bounce_buf, xfer_bytes);
-			data->bytes_xfered = xfer_bytes;
 			dma_wmb();
 		}
 
@@ -539,6 +538,7 @@ static irqreturn_t meson_mmc_irq(int irq, void *dev_id)
 {
 	struct meson_host *host = dev_id;
 	struct mmc_command *cmd;
+	struct mmc_data *data;
 	u32 irq_en, status, raw_status;
 	irqreturn_t ret = IRQ_HANDLED;
 
@@ -550,6 +550,8 @@ static irqreturn_t meson_mmc_irq(int irq, void *dev_id)
 	if (WARN_ON(!cmd))
 		return IRQ_NONE;
 
+	data = cmd->data;
+
 	spin_lock(&host->lock);
 	irq_en = readl(host->regs + SD_EMMC_IRQ_EN);
 	raw_status = readl(host->regs + SD_EMMC_STATUS);
@@ -590,9 +592,11 @@ static irqreturn_t meson_mmc_irq(int irq, void *dev_id)
 	if (status & IRQ_SDIO)
 		dev_dbg(host->dev, "Unhandled IRQ: SDIO.\n");
 
-	if (status & (IRQ_END_OF_CHAIN | IRQ_RESP_STATUS))
+	if (status & (IRQ_END_OF_CHAIN | IRQ_RESP_STATUS)) {
+		if (data && !cmd->error)
+			data->bytes_xfered = data->blksz * data->blocks;
 		ret = IRQ_WAKE_THREAD;
-	else  {
+	} else {
 		dev_warn(host->dev, "Unknown IRQ! status=0x%04x: MMC CMD%u arg=0x%08x flags=0x%08x stop=%d\n",
 			 status, cmd->opcode, cmd->arg,
 			 cmd->flags, cmd->mrq->stop ? 1 : 0);
@@ -633,7 +637,6 @@ static irqreturn_t meson_mmc_irq_thread(int irq, void *dev_id)
 		WARN_ON(xfer_bytes > host->bounce_buf_size);
 		sg_copy_from_buffer(data->sg, data->sg_len,
 				    host->bounce_buf, xfer_bytes);
-		data->bytes_xfered = xfer_bytes;
 	}
 
 	if (!data || !data->stop || cmd->mrq->sbc)
-- 
2.12.0


