From: Saugata Das <saugata.das@stericsson.com>
Subject: [PATCH V2] mmci.c: CMD23 support
Date: Thu, 2 Feb 2012 10:40:59 +0530
Message-ID: <1328159459-15372-1-git-send-email-saugata.das@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog118.obsmtp.com ([207.126.144.145]:48684 "EHLO
	eu1sys200aog118.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750746Ab2BBFLN (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 2 Feb 2012 00:11:13 -0500
Received: from zeta.dmz-us.st.com (ns4.st.com [167.4.16.71])
	by beta.dmz-us.st.com (STMicroelectronics) with ESMTP id 4DD6F48
	for <linux-mmc@vger.kernel.org>; Thu,  2 Feb 2012 05:11:00 +0000 (GMT)
Received: from relay2.stm.gmessaging.net (unknown [10.230.100.18])
	by zeta.dmz-us.st.com (STMicroelectronics) with ESMTP id 9B4134D
	for <linux-mmc@vger.kernel.org>; Thu,  2 Feb 2012 04:04:42 +0000 (GMT)
Received: from exdcvycastm022.EQ1STM.local (alteon-source-exch [10.230.100.61])
	(using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(Client CN "exdcvycastm022", Issuer "exdcvycastm022" (not verified))
	by relay2.stm.gmessaging.net (Postfix) with ESMTPS id F1386A807D
	for <linux-mmc@vger.kernel.org>; Thu,  2 Feb 2012 06:11:06 +0100 (CET)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

From: Saugata Das <saugata.das@linaro.org>

Support added for transmission of CMD23 during multi block read or
write. In order to activate this feature, MMC_CAP_CMD23 flag needs
to be enabled in the capabilities field. Note that CMD23 support is
mandatory to support features like reliable write, data tag, context
ID, packed command.

Signed-off-by: Saugata Das <saugata.das@linaro.org>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/mmc/host/mmci.c |   12 +++++++++---
 1 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 8eabf99..21f75da 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -726,7 +726,7 @@ mmci_data_irq(struct mmci_host *host, struct mmc_data *data,
 			/* The error clause is handled above, success! */
 			data->bytes_xfered = data->blksz * data->blocks;
 
-		if (!data->stop) {
+		if (!data->stop || host->mrq->sbc) {
 			mmci_request_end(host, data->mrq);
 		} else {
 			mmci_start_command(host, data->stop, 0);
@@ -739,6 +739,7 @@ mmci_cmd_irq(struct mmci_host *host, struct mmc_command *cmd,
 	     unsigned int status)
 {
 	void __iomem *base = host->base;
+	bool sbc = !!(host->mrq->sbc && (host->mrq->sbc == host->cmd));
 
 	host->cmd = NULL;
 
@@ -753,10 +754,12 @@ mmci_cmd_irq(struct mmci_host *host, struct mmc_command *cmd,
 		cmd->resp[3] = readl(base + MMCIRESPONSE3);
 	}
 
-	if (!cmd->data || cmd->error) {
+	if ((!sbc && !cmd->data) || cmd->error) {
 		if (host->data)
 			mmci_stop_data(host);
 		mmci_request_end(host, cmd->mrq);
+	} else if (sbc) {
+		mmci_start_command(host, host->mrq->cmd, 0);
 	} else if (!(cmd->data->flags & MMC_DATA_READ)) {
 		mmci_start_data(host, cmd->data);
 	}
@@ -998,7 +1001,10 @@ static void mmci_request(struct mmc_host *mmc, struct mmc_request *mrq)
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
1.7.4.3

