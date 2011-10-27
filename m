From: "Shawn.Dong" <shawn.dong.cx@gmail.com>
Subject: [PATCH]mmc: sdhci: use udelay instead of mdelay for some cases
Date: Thu, 27 Oct 2011 12:18:53 +0800
Message-ID: <20111027041851.GA18442@gmail.com>
Reply-To: "Shawn.Dong" <shawn.dong.cx@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:42106 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750801Ab1J0EcN (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 27 Oct 2011 00:32:13 -0400
Received: by gyb13 with SMTP id 13so2251698gyb.19
        for <linux-mmc@vger.kernel.org>; Wed, 26 Oct 2011 21:32:12 -0700 (PDT)
Content-Disposition: inline
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

sdhci_set_clock or sdhci_reset or sdhci_send_command may be used in
critical region which is protected by spin_lock_irqsave. Thus, these
functions will delay the responsing of the kernel interrupts.

So in this case, using a mdelay will cause unnecessary latency. Our
hardware, in most case will not cause 1ms to finish its job. Using
udelay instead can reduce it.

By default, sdhci_do_set_ios will need about 1ms to finish in my platform.
After using udelay instead, sdhci_do_set_ios only need a few microseconds.

Signed-off-by: Shawn.Dong <Shawn.dong.cx@gmail.com>
---
 drivers/mmc/host/sdhci.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 6d8eea3..9314cd1 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -195,7 +195,7 @@ static void sdhci_reset(struct sdhci_host *host, u8 mask)
 		host->clock = 0;
 
 	/* Wait max 100 ms */
-	timeout = 100;
+	timeout = 10000;
 
 	/* hw clears the bit when it's done */
 	while (sdhci_readb(host, SDHCI_SOFTWARE_RESET) & mask) {
@@ -206,7 +206,7 @@ static void sdhci_reset(struct sdhci_host *host, u8 mask)
 			return;
 		}
 		timeout--;
-		mdelay(1);
+		udelay(10);
 	}
 
 	if (host->ops->platform_reset_exit)
@@ -959,7 +959,7 @@ static void sdhci_send_command(struct sdhci_host *host, struct mmc_command *cmd)
 	WARN_ON(host->cmd);
 
 	/* Wait max 10 ms */
-	timeout = 10;
+	timeout = 1000;
 
 	mask = SDHCI_CMD_INHIBIT;
 	if ((cmd->data != NULL) || (cmd->flags & MMC_RSP_BUSY))
@@ -980,7 +980,7 @@ static void sdhci_send_command(struct sdhci_host *host, struct mmc_command *cmd)
 			return;
 		}
 		timeout--;
-		mdelay(1);
+		udelay(10);
 	}
 
 	mod_timer(&host->timer, jiffies + 10 * HZ);
@@ -1140,7 +1140,7 @@ static void sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
 	sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
 
 	/* Wait max 20 ms */
-	timeout = 20;
+	timeout = 2000;
 	while (!((clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL))
 		& SDHCI_CLOCK_INT_STABLE)) {
 		if (timeout == 0) {
@@ -1150,7 +1150,7 @@ static void sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
 			return;
 		}
 		timeout--;
-		mdelay(1);
+		udelay(10);
 	}
 
 	clk |= SDHCI_CLOCK_CARD_EN;
-- 
1.7.3.4

