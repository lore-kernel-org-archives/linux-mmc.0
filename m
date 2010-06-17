From: Matthieu CASTET <matthieu.castet@parrot.com>
Subject: sdhci : reduce irq off latency
Date: Thu, 17 Jun 2010 11:07:15 +0200
Message-ID: <4C19E5C3.2080700@parrot.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="------------060701060907000003090709"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from co202.xi-lite.net ([149.6.83.202]:57010 "EHLO co202.xi-lite.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752285Ab0FQJN6 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 17 Jun 2010 05:13:58 -0400
Received: from ONYX.xi-lite.lan (unknown [193.34.35.243])
	by co202.xi-lite.net (Postfix) with ESMTPS id D41632602F8
	for <linux-mmc@vger.kernel.org>; Thu, 17 Jun 2010 11:07:17 +0200 (CEST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

--------------060701060907000003090709
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit

sdhci code got tasklets (sdhci_tasklet_card and sdhci_tasklet_finish),
that does :
{
spin_lock_irqsave

if (cond) {
sdhci_reset
sdhci_reset
}

spin_unlock_irqrestore
}

sdhci_reset {
...
while (read_reg) {
if (timeout == 0)
    break;
timeout--;
mdelay(1);
}
...
}


The problem is that sdhci_reset [1] does busy pooling (with a 
granularity of 1 ms) on a register up to a timeout of 100 ms.

With the current code, we got irq off during 2*1ms. With the attached 
patch we reduce irq off to 30 us.

Note that worst case 100 ms irq off still exist.

Signed-off-by: Matthieu CASTET <matthieu.castet@parrot.com>


--------------060701060907000003090709
Content-Type: text/x-diff; name="sdhci.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline; filename="sdhci.diff"

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index c6d1bd8..03d6bde 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -157,18 +157,17 @@ static void sdhci_reset(struct sdhci_host *host, u8 mask)
 		host->clock = 0;
 
 	/* Wait max 100 ms */
-	timeout = 100;
+	timeout = jiffies + msecs_to_jiffies(100);
 
 	/* hw clears the bit when it's done */
 	while (sdhci_readb(host, SDHCI_SOFTWARE_RESET) & mask) {
-		if (timeout == 0) {
+		if (time_is_before_jiffies(timeout)) {
 			printk(KERN_ERR "%s: Reset 0x%x never completed.\n",
 				mmc_hostname(host->mmc), (int)mask);
 			sdhci_dumpregs(host);
 			return;
 		}
-		timeout--;
-		mdelay(1);
+		cpu_relax();
 	}
 
 	if (host->quirks & SDHCI_QUIRK_RESTORE_IRQS_AFTER_RESET)
@@ -882,7 +881,7 @@ static void sdhci_send_command(struct sdhci_host *host, struct mmc_command *cmd)
 	WARN_ON(host->cmd);
 
 	/* Wait max 10 ms */
-	timeout = 10;
+	timeout = jiffies + msecs_to_jiffies(10);
 
 	mask = SDHCI_CMD_INHIBIT;
 	if ((cmd->data != NULL) || (cmd->flags & MMC_RSP_BUSY))
@@ -894,7 +893,7 @@ static void sdhci_send_command(struct sdhci_host *host, struct mmc_command *cmd)
 		mask &= ~SDHCI_DATA_INHIBIT;
 
 	while (sdhci_readl(host, SDHCI_PRESENT_STATE) & mask) {
-		if (timeout == 0) {
+		if (time_is_before_jiffies(timeout)) {
 			printk(KERN_ERR "%s: Controller never released "
 				"inhibit bit(s).\n", mmc_hostname(host->mmc));
 			sdhci_dumpregs(host);
@@ -902,8 +901,7 @@ static void sdhci_send_command(struct sdhci_host *host, struct mmc_command *cmd)
 			tasklet_schedule(&host->finish_tasklet);
 			return;
 		}
-		timeout--;
-		mdelay(1);
+		cpu_relax();
 	}
 
 	mod_timer(&host->timer, jiffies + 10 * HZ);
@@ -1007,17 +1005,16 @@ static void sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
 	sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
 
 	/* Wait max 20 ms */
-	timeout = 20;
+	timeout = jiffies + msecs_to_jiffies(20)
 	while (!((clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL))
 		& SDHCI_CLOCK_INT_STABLE)) {
-		if (timeout == 0) {
+		if (time_is_before_jiffies(timeout)) {
 			printk(KERN_ERR "%s: Internal clock never "
 				"stabilised.\n", mmc_hostname(host->mmc));
 			sdhci_dumpregs(host);
 			return;
 		}
-		timeout--;
-		mdelay(1);
+		cpu_relax();
 	}
 
 	clk |= SDHCI_CLOCK_CARD_EN;

--------------060701060907000003090709--
