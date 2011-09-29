From: Barry Song <Barry.Song@csr.com>
Subject: [PATCH] mmc: sdhci: shorten the interval to wait SDHCI_PRESENT_STATE set after sending cmd
Date: Wed, 28 Sep 2011 20:58:52 -0700
Message-ID: <1317268732-11653-1-git-send-email-Barry.Song@csr.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from cluster-d.mailcontrol.com ([85.115.60.190]:36064 "EHLO
	cluster-d.mailcontrol.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751986Ab1I2D7u (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 28 Sep 2011 23:59:50 -0400
Received: from rly24d.srv.mailcontrol.com (localhost.localdomain [127.0.0.1])
	by rly24d.srv.mailcontrol.com (MailControl) with ESMTP id p8T3xn5h014555
	for <linux-mmc@vger.kernel.org>; Thu, 29 Sep 2011 04:59:49 +0100
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by rly24d.srv.mailcontrol.com (MailControl) id p8T3xFFd011884
	for <linux-mmc@vger.kernel.org>; Thu, 29 Sep 2011 04:59:15 +0100
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: cjb@laptop.org
Cc: linux-mmc@vger.kernel.org, workgroup.linux@csr.com, Barry Song <Baohua.Song@csr.com>

From: Barry Song <Baohua.Song@csr.com>

now we wait 1ms after every loop, in the worst case, 1ms will be wasted.
that both decreases sd performance and increases cpu usage.
This patch shorten the interval to 1us, then in the worst case, only 1us
is wasted.

Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 drivers/mmc/host/sdhci.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 0e02cc1..13bcb96 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -935,8 +935,8 @@ static void sdhci_send_command(struct sdhci_host *host, struct mmc_command *cmd)
 
 	WARN_ON(host->cmd);
 
-	/* Wait max 10 ms */
-	timeout = 10;
+	/* Wait max 10000 us */
+	timeout = 10000;
 
 	mask = SDHCI_CMD_INHIBIT;
 	if ((cmd->data != NULL) || (cmd->flags & MMC_RSP_BUSY))
@@ -957,7 +957,7 @@ static void sdhci_send_command(struct sdhci_host *host, struct mmc_command *cmd)
 			return;
 		}
 		timeout--;
-		mdelay(1);
+		udelay(1);
 	}
 
 	mod_timer(&host->timer, jiffies + 10 * HZ);
-- 
1.7.1



Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
More information can be found at www.csr.com. Follow CSR on Twitter at http://twitter.com/CSR_PLC and read our blog at www.csr.com/blog
