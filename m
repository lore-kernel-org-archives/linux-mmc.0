From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 2/3] mmc: mmci: Move all CMD irq handling to mmci_cmd_irq()
Date: Mon, 16 Jun 2014 09:58:02 +0200
Message-ID: <1402905483-22567-3-git-send-email-ulf.hansson@linaro.org>
References: <1402905483-22567-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-la0-f41.google.com ([209.85.215.41]:48363 "EHLO
	mail-la0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754358AbaFPH6O (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 16 Jun 2014 03:58:14 -0400
Received: by mail-la0-f41.google.com with SMTP id hz20so2793851lab.0
        for <linux-mmc@vger.kernel.org>; Mon, 16 Jun 2014 00:58:12 -0700 (PDT)
In-Reply-To: <1402905483-22567-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, Russell King <linux@arm.linux.org.uk>
Cc: linux-mmc@vger.kernel.org, Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, Peter Maydell <peter.maydell@linaro.org>, John Stultz <john.stultz@linaro.org>

This patch won't change the behavior of how mmci deals with CMD irqs.
By moving code from mmci_irq() to mmci_cmd_irq(), we getter a better
overview of what going on.

Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: John Stultz <john.stultz@linaro.org>
Cc: Russell King <linux@arm.linux.org.uk>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/host/mmci.c |   22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index a723ed2..5d20bfba 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -960,9 +960,17 @@ mmci_cmd_irq(struct mmci_host *host, struct mmc_command *cmd,
 	     unsigned int status)
 {
 	void __iomem *base = host->base;
-	bool sbc = (cmd == host->mrq->sbc);
-	bool busy_resp = host->variant->busy_detect &&
-			(cmd->flags & MMC_RSP_BUSY);
+	bool sbc, busy_resp;
+
+	if (!cmd)
+		return;
+
+	sbc = (cmd == host->mrq->sbc);
+	busy_resp = host->variant->busy_detect && (cmd->flags & MMC_RSP_BUSY);
+
+	if (!((status|host->busy_status) & (MCI_CMDCRCFAIL|MCI_CMDTIMEOUT|
+		MCI_CMDSENT|MCI_CMDRESPEND)))
+		return;
 
 	/* Check if we need to wait for busy completion. */
 	if (host->busy_status && (status & MCI_ST_CARDBUSY))
@@ -1209,8 +1217,6 @@ static irqreturn_t mmci_irq(int irq, void *dev_id)
 	spin_lock(&host->lock);
 
 	do {
-		struct mmc_command *cmd;
-
 		status = readl(host->base + MMCISTATUS);
 
 		if (host->singleirq) {
@@ -1230,11 +1236,7 @@ static irqreturn_t mmci_irq(int irq, void *dev_id)
 
 		dev_dbg(mmc_dev(host->mmc), "irq0 (data+cmd) %08x\n", status);
 
-		cmd = host->cmd;
-		if ((status|host->busy_status) & (MCI_CMDCRCFAIL|MCI_CMDTIMEOUT|
-			MCI_CMDSENT|MCI_CMDRESPEND) && cmd)
-			mmci_cmd_irq(host, cmd, status);
-
+		mmci_cmd_irq(host, host->cmd, status);
 		mmci_data_irq(host, host->data, status);
 
 		/* Don't poll for busy completion in irq context. */
-- 
1.7.9.5

