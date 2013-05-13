From: Ulf Hansson <ulf.hansson@stericsson.com>
Subject: [PATCH] mmc: mmci: Support for CMD23
Date: Mon, 13 May 2013 16:33:32 +0200
Message-ID: <1368455612-20786-1-git-send-email-ulf.hansson@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog111.obsmtp.com ([207.126.144.131]:59713 "EHLO
	eu1sys200aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751205Ab3EMOeK (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 13 May 2013 10:34:10 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, Russell King <linux@arm.linux.org.uk>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Ulf Hansson <ulf.hansson@linaro.org>

From: Ulf Hansson <ulf.hansson@linaro.org>

Support added for transmission of CMD23 during multi block read or
write. In order to activate this feature, MMC_CAP_CMD23 flag needs
to be enabled in the capabilities field. Note that CMD23 support is
mandatory to support features like reliable write, data tag, context
ID, packed command.

This patch is based upon a patch from Saugata Das.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/mmc/host/mmci.c |   14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index f4f3038..27f29bb 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -842,7 +842,7 @@ mmci_data_irq(struct mmci_host *host, struct mmc_data *data,
 			/* The error clause is handled above, success! */
 			data->bytes_xfered = data->blksz * data->blocks;
 
-		if (!data->stop) {
+		if (!data->stop || host->mrq->sbc) {
 			mmci_request_end(host, data->mrq);
 		} else {
 			mmci_start_command(host, data->stop, 0);
@@ -855,6 +855,7 @@ mmci_cmd_irq(struct mmci_host *host, struct mmc_command *cmd,
 	     unsigned int status)
 {
 	void __iomem *base = host->base;
+	bool sbc = (cmd == host->mrq->sbc);
 
 	host->cmd = NULL;
 
@@ -869,7 +870,7 @@ mmci_cmd_irq(struct mmci_host *host, struct mmc_command *cmd,
 		cmd->resp[3] = readl(base + MMCIRESPONSE3);
 	}
 
-	if (!cmd->data || cmd->error) {
+	if ((!sbc && !cmd->data) || cmd->error) {
 		if (host->data) {
 			/* Terminate the DMA transfer */
 			if (dma_inprogress(host)) {
@@ -878,7 +879,9 @@ mmci_cmd_irq(struct mmci_host *host, struct mmc_command *cmd,
 			}
 			mmci_stop_data(host);
 		}
-		mmci_request_end(host, cmd->mrq);
+		mmci_request_end(host, host->mrq);
+	} else if (sbc) {
+		mmci_start_command(host, host->mrq->cmd, 0);
 	} else if (!(cmd->data->flags & MMC_DATA_READ)) {
 		mmci_start_data(host, cmd->data);
 	}
@@ -1119,7 +1122,10 @@ static void mmci_request(struct mmc_host *mmc, struct mmc_request *mrq)
 	if (mrq->data && mrq->data->flags & MMC_DATA_READ)
 		mmci_start_data(host, mrq->data);
 
-	mmci_start_command(host, mrq->cmd, 0);
+	if (mrq->sbc)
+		mmci_start_command(host, mrq->sbc, 0);
+	else
+		mmci_start_command(host, mrq->cmd, 0);
 
 	spin_unlock_irqrestore(&host->lock, flags);
 }
-- 
1.7.10

