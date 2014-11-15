From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [patch] mmc: toshsd: move dereference below check for NULL
Date: Sat, 15 Nov 2014 21:56:41 +0300
Message-ID: <20141115185641.GA6530@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:29632 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754297AbaKOSzp (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 15 Nov 2014 13:55:45 -0500
Content-Disposition: inline
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <chris@printf.net>, Ondrej Zary <linux@rainbow-software.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, kernel-janitors@vger.kernel.org

We check for NULL pointers after dereferencing so it's too late.  Oddly
enough, Smatch misses this code but complains about the caller passing
NULL pointers to this function:

	drivers/mmc/host/toshsd.c:389 toshsd_irq()
	error: we previously assumed 'host->cmd' could be null (see line 349)

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/mmc/host/toshsd.c b/drivers/mmc/host/toshsd.c
index edb06d6..4666262 100644
--- a/drivers/mmc/host/toshsd.c
+++ b/drivers/mmc/host/toshsd.c
@@ -206,14 +206,14 @@ static irqreturn_t toshsd_thread_irq(int irq, void *dev_id)
 static void toshsd_cmd_irq(struct toshsd_host *host)
 {
 	struct mmc_command *cmd = host->cmd;
-	u8 *buf = (u8 *) cmd->resp;
+	u8 *buf;
 	u16 data;
 
 	if (!host->cmd) {
 		dev_warn(&host->pdev->dev, "Spurious CMD irq\n");
 		return;
 	}
-
+	buf = (u8 *)cmd->resp;
 	host->cmd = NULL;
 
 	if (cmd->flags & MMC_RSP_PRESENT && cmd->flags & MMC_RSP_136) {
