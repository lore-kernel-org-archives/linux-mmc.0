From: Chris Ball <cjb@laptop.org>
Subject: Re: sdhci : reduce irq off latency
Date: Sat, 28 Aug 2010 03:23:43 +0100
Message-ID: <20100828022343.GA6429@void.printf.net>
References: <4C19E5C3.2080700@parrot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:57896 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752971Ab0H1CXr (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 27 Aug 2010 22:23:47 -0400
Content-Disposition: inline
In-Reply-To: <4C19E5C3.2080700@parrot.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Matthieu CASTET <matthieu.castet@parrot.com>
Cc: Kyungmin Park <kmpark@infradead.org>, linux-mmc@vger.kernel.org

Hi Matthieu,

This patch didn't make it upstream.  Kyungmin offered a suggestion for 
fixing it -- would you like to resend an updated patch?

(As a minor aside, I have a fairly irrational preference for 
"time_after(jiffies, timeout)" over "time_is_before_jiffies(timeout)",
because the latter reads as the inverse of what it actually does to me.
They compile to the same code.)

Date: Thu, 17 Jun 2010 11:07:15 +0200
From: Matthieu CASTET <matthieu.castet@parrot.com>

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


The problem is that sdhci_reset [1] does busy pooling (with a granularity 
of 1 ms) on a register up to a timeout of 100 ms.

With the current code, we got irq off during 2*1ms. With the attached  
patch we reduce irq off to 30 us.

Note that worst case 100 ms irq off still exist.

Signed-off-by: Matthieu CASTET <matthieu.castet@parrot.com>
Signed-off-by: Chris Ball <cjb@laptop.org>
---

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


-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
