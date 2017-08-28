From: Jerome Brunet <jbrunet@baylibre.com>
Subject: [PATCH v3 08/13] mmc: meson-gx: simplify interrupt handler
Date: Mon, 28 Aug 2017 16:29:10 +0200
Message-ID: <20170828142915.27020-9-jbrunet@baylibre.com>
References: <20170828142915.27020-1-jbrunet@baylibre.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wr0-f175.google.com ([209.85.128.175]:33423 "EHLO
        mail-wr0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751304AbdH1O32 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 28 Aug 2017 10:29:28 -0400
Received: by mail-wr0-f175.google.com with SMTP id k94so2261172wrc.0
        for <linux-mmc@vger.kernel.org>; Mon, 28 Aug 2017 07:29:27 -0700 (PDT)
In-Reply-To: <20170828142915.27020-1-jbrunet@baylibre.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@baylibre.com>, Carlo Caione <carlo@caione.org>
Cc: Jerome Brunet <jbrunet@baylibre.com>, linux-mmc@vger.kernel.org, linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

No functional change, just improve interrupt handler readability

Reviewed-by: Kevin Hilman <khilman@baylibre.com>
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/mmc/host/meson-gx-mmc.c | 93 +++++++++++++++++------------------------
 1 file changed, 39 insertions(+), 54 deletions(-)

diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
index 43aabb793121..3914c3a82cc4 100644
--- a/drivers/mmc/host/meson-gx-mmc.c
+++ b/drivers/mmc/host/meson-gx-mmc.c
@@ -78,16 +78,22 @@
 #define   STATUS_BUSY BIT(31)
 
 #define SD_EMMC_IRQ_EN 0x4c
-#define   IRQ_EN_MASK GENMASK(13, 0)
 #define   IRQ_RXD_ERR_MASK GENMASK(7, 0)
 #define   IRQ_TXD_ERR BIT(8)
 #define   IRQ_DESC_ERR BIT(9)
 #define   IRQ_RESP_ERR BIT(10)
+#define   IRQ_CRC_ERR \
+	(IRQ_RXD_ERR_MASK | IRQ_TXD_ERR | IRQ_DESC_ERR | IRQ_RESP_ERR)
 #define   IRQ_RESP_TIMEOUT BIT(11)
 #define   IRQ_DESC_TIMEOUT BIT(12)
+#define   IRQ_TIMEOUTS \
+	(IRQ_RESP_TIMEOUT | IRQ_DESC_TIMEOUT)
 #define   IRQ_END_OF_CHAIN BIT(13)
 #define   IRQ_RESP_STATUS BIT(14)
 #define   IRQ_SDIO BIT(15)
+#define   IRQ_EN_MASK \
+	(IRQ_CRC_ERR | IRQ_TIMEOUTS | IRQ_END_OF_CHAIN | IRQ_RESP_STATUS |\
+	 IRQ_SDIO)
 
 #define SD_EMMC_CMD_CFG 0x50
 #define SD_EMMC_CMD_ARG 0x54
@@ -760,57 +766,40 @@ static irqreturn_t meson_mmc_irq(int irq, void *dev_id)
 	struct mmc_command *cmd;
 	struct mmc_data *data;
 	u32 irq_en, status, raw_status;
-	irqreturn_t ret = IRQ_HANDLED;
+	irqreturn_t ret = IRQ_NONE;
 
-	if (WARN_ON(!host))
+	if (WARN_ON(!host) || WARN_ON(!host->cmd))
 		return IRQ_NONE;
 
-	cmd = host->cmd;
-
-	if (WARN_ON(!cmd))
-		return IRQ_NONE;
+	spin_lock(&host->lock);
 
+	cmd = host->cmd;
 	data = cmd->data;
-
-	spin_lock(&host->lock);
 	irq_en = readl(host->regs + SD_EMMC_IRQ_EN);
 	raw_status = readl(host->regs + SD_EMMC_STATUS);
 	status = raw_status & irq_en;
 
-	if (!status) {
-		dev_warn(host->dev, "Spurious IRQ! status=0x%08x, irq_en=0x%08x\n",
-			 raw_status, irq_en);
-		ret = IRQ_NONE;
-		goto out;
-	}
-
-	meson_mmc_read_resp(host->mmc, cmd);
-
 	cmd->error = 0;
-	if (status & IRQ_RXD_ERR_MASK) {
-		dev_dbg(host->dev, "Unhandled IRQ: RXD error\n");
-		cmd->error = -EILSEQ;
-	}
-	if (status & IRQ_TXD_ERR) {
-		dev_dbg(host->dev, "Unhandled IRQ: TXD error\n");
-		cmd->error = -EILSEQ;
-	}
-	if (status & IRQ_DESC_ERR)
-		dev_dbg(host->dev, "Unhandled IRQ: Descriptor error\n");
-	if (status & IRQ_RESP_ERR) {
-		dev_dbg(host->dev, "Unhandled IRQ: Response error\n");
+	if (status & IRQ_CRC_ERR) {
+		dev_dbg(host->dev, "CRC Error - status 0x%08x\n", status);
 		cmd->error = -EILSEQ;
+		ret = IRQ_HANDLED;
+		goto out;
 	}
-	if (status & IRQ_RESP_TIMEOUT) {
-		dev_dbg(host->dev, "Unhandled IRQ: Response timeout\n");
+
+	if (status & IRQ_TIMEOUTS) {
+		dev_dbg(host->dev, "Timeout - status 0x%08x\n", status);
 		cmd->error = -ETIMEDOUT;
+		ret = IRQ_HANDLED;
+		goto out;
 	}
-	if (status & IRQ_DESC_TIMEOUT) {
-		dev_dbg(host->dev, "Unhandled IRQ: Descriptor timeout\n");
-		cmd->error = -ETIMEDOUT;
+
+	meson_mmc_read_resp(host->mmc, cmd);
+
+	if (status & IRQ_SDIO) {
+		dev_dbg(host->dev, "IRQ: SDIO TODO.\n");
+		ret = IRQ_HANDLED;
 	}
-	if (status & IRQ_SDIO)
-		dev_dbg(host->dev, "Unhandled IRQ: SDIO.\n");
 
 	if (status & (IRQ_END_OF_CHAIN | IRQ_RESP_STATUS)) {
 		if (data && !cmd->error)
@@ -818,26 +807,20 @@ static irqreturn_t meson_mmc_irq(int irq, void *dev_id)
 		if (meson_mmc_bounce_buf_read(data) ||
 		    meson_mmc_get_next_command(cmd))
 			ret = IRQ_WAKE_THREAD;
-	} else {
-		dev_warn(host->dev, "Unknown IRQ! status=0x%04x: MMC CMD%u arg=0x%08x flags=0x%08x stop=%d\n",
-			 status, cmd->opcode, cmd->arg,
-			 cmd->flags, cmd->mrq->stop ? 1 : 0);
-		if (cmd->data) {
-			struct mmc_data *data = cmd->data;
-
-			dev_warn(host->dev, "\tblksz %u blocks %u flags 0x%08x (%s%s)",
-				 data->blksz, data->blocks, data->flags,
-				 data->flags & MMC_DATA_WRITE ? "write" : "",
-				 data->flags & MMC_DATA_READ ? "read" : "");
-		}
+		else
+			ret = IRQ_HANDLED;
 	}
 
 out:
-	/* ack all (enabled) interrupts */
-	writel(status, host->regs + SD_EMMC_STATUS);
+	/* ack all enabled interrupts */
+	writel(irq_en, host->regs + SD_EMMC_STATUS);
 
 	if (ret == IRQ_HANDLED)
 		meson_mmc_request_done(host->mmc, cmd->mrq);
+	else if (ret == IRQ_NONE)
+		dev_warn(host->dev,
+			 "Unexpected IRQ! status=0x%08x, irq_en=0x%08x\n",
+			 raw_status, irq_en);
 
 	spin_unlock(&host->lock);
 	return ret;
@@ -1017,10 +1000,12 @@ static int meson_mmc_probe(struct platform_device *pdev)
 	/* Stop execution */
 	writel(0, host->regs + SD_EMMC_START);
 
-	/* clear, ack, enable all interrupts */
+	/* clear, ack and enable interrupts */
 	writel(0, host->regs + SD_EMMC_IRQ_EN);
-	writel(IRQ_EN_MASK, host->regs + SD_EMMC_STATUS);
-	writel(IRQ_EN_MASK, host->regs + SD_EMMC_IRQ_EN);
+	writel(IRQ_CRC_ERR | IRQ_TIMEOUTS | IRQ_END_OF_CHAIN,
+	       host->regs + SD_EMMC_STATUS);
+	writel(IRQ_CRC_ERR | IRQ_TIMEOUTS | IRQ_END_OF_CHAIN,
+	       host->regs + SD_EMMC_IRQ_EN);
 
 	ret = devm_request_threaded_irq(&pdev->dev, irq, meson_mmc_irq,
 					meson_mmc_irq_thread, IRQF_SHARED,
-- 
2.9.5

