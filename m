From: Haijun Zhang <Haijun.Zhang@freescale.com>
Subject: [PATCH] mmc:sdhci: Wait longer for command with busy flags
Date: Wed, 31 Jul 2013 16:21:44 +0800
Message-ID: <1375258904-25163-1-git-send-email-Haijun.Zhang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-db8lp0189.outbound.messaging.microsoft.com ([213.199.154.189]:41552
	"EHLO db8outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755898Ab3GaJOK (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 31 Jul 2013 05:14:10 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: cbouatmailru@gmail.com, cjb@laptop.org, Haijun Zhang <Haijun.Zhang@freescale.com>

When command with busy flags send and also data busy end interrupt
will be generate, the command will be finished when data transfer
complete or data busy state end, Sometimes this will expend more than
10*Hz time to finish this command, so we should wait longer to detect
command complete timeout err.

Signed-off-by: Haijun Zhang <Haijun.Zhang@freescale.com>
---
 drivers/mmc/host/sdhci.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index a78bd4f..7b89ed6 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -986,6 +986,7 @@ static void sdhci_send_command(struct sdhci_host *host, struct mmc_command *cmd)
 	int flags;
 	u32 mask;
 	unsigned long timeout;
+	u32 timer = 10;
 
 	WARN_ON(host->cmd);
 
@@ -1014,6 +1015,17 @@ static void sdhci_send_command(struct sdhci_host *host, struct mmc_command *cmd)
 		mdelay(1);
 	}
 
+	/*
+	 * When send a commmand with busy state and also the data busy end
+	 * interrupt can be generate, the command will be finished when date
+	 * transfer complete or busy state end. Sometimes this will expend
+	 * more than 10*HZ, In this case whe should wait longer to detect
+	 * command complete timeout err.
+	 */
+	if ((host->cmd->flags & MMC_RSP_BUSY) &&
+			!(host->quirks & SDHCI_QUIRK_NO_BUSY_IRQ))
+		timer = 1000;
+
 	mod_timer(&host->timer, jiffies + 10 * HZ);
 
 	host->cmd = cmd;
-- 
1.8.0


