From: Yoshihiro Kaneko <ykaneko0929@gmail.com>
Subject: [PATCH/RFC] mmc: sh_mmcif: Add exclusion between cmd and interrupt
Date: Sun, 15 Feb 2015 23:46:46 +0900
Message-ID: <1424011607-3682-1-git-send-email-ykaneko0929@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pd0-f169.google.com ([209.85.192.169]:33803 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754998AbbBOOrN (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 15 Feb 2015 09:47:13 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, linux-sh@vger.kernel.org

From: Kouichi Tomita <kouichi.tomita.yn@renesas.com>

A command end interrupt should not be processed between command issue
and setting of wait_for flag. It expects already the flag to be set.
Therefore the exclusive control was added.

Signed-off-by: Kouichi Tomita <kouichi.tomita.yn@renesas.com>
Signed-off-by: Yoshihiro Kaneko <ykaneko0929@gmail.com>
---

This patch is based on next branch of Chris Ball's mmc tree.

 drivers/mmc/host/sh_mmcif.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
index 7d9d6a3..e5d0b42 100644
--- a/drivers/mmc/host/sh_mmcif.c
+++ b/drivers/mmc/host/sh_mmcif.c
@@ -875,6 +875,7 @@ static void sh_mmcif_start_cmd(struct sh_mmcif_host *host,
 	struct mmc_command *cmd = mrq->cmd;
 	u32 opc = cmd->opcode;
 	u32 mask;
+	unsigned long flags;
 
 	switch (opc) {
 	/* response busy check */
@@ -909,10 +910,12 @@ static void sh_mmcif_start_cmd(struct sh_mmcif_host *host,
 	/* set arg */
 	sh_mmcif_writel(host->addr, MMCIF_CE_ARG, cmd->arg);
 	/* set cmd */
+	spin_lock_irqsave(&host->lock, flags);
 	sh_mmcif_writel(host->addr, MMCIF_CE_CMD_SET, opc);
 
 	host->wait_for = MMCIF_WAIT_FOR_CMD;
 	schedule_delayed_work(&host->timeout_work, host->timeout);
+	spin_unlock_irqrestore(&host->lock, flags);
 }
 
 static void sh_mmcif_stop_cmd(struct sh_mmcif_host *host,
@@ -1171,6 +1174,12 @@ static irqreturn_t sh_mmcif_irqt(int irq, void *dev_id)
 	struct sh_mmcif_host *host = dev_id;
 	struct mmc_request *mrq;
 	bool wait = false;
+	unsigned long flags;
+	int wait_work;
+
+	spin_lock_irqsave(&host->lock, flags);
+	wait_work = host->wait_for;
+	spin_unlock_irqrestore(&host->lock, flags);
 
 	cancel_delayed_work_sync(&host->timeout_work);
 
@@ -1188,7 +1197,7 @@ static irqreturn_t sh_mmcif_irqt(int irq, void *dev_id)
 	 * All handlers return true, if processing continues, and false, if the
 	 * request has to be completed - successfully or not
 	 */
-	switch (host->wait_for) {
+	switch (wait_work) {
 	case MMCIF_WAIT_FOR_REQUEST:
 		/* We're too late, the timeout has already kicked in */
 		mutex_unlock(&host->thread_lock);
-- 
1.9.1

