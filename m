From: Matthieu CASTET <matthieu.castet@parrot.com>
Subject: Re: sdhci : reduce irq off latency
Date: Fri, 18 Jun 2010 09:57:01 +0200
Message-ID: <4C1B26CD.5070405@parrot.com>
References: <4C19E5C3.2080700@parrot.com> <AANLkTinZ8If_JswEhoOShRZbQSjlh1uKgFYasnsfFeRx@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="------------070001040209090206030202"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from co202.xi-lite.net ([149.6.83.202]:40076 "EHLO co202.xi-lite.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756346Ab0FRH5I (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 18 Jun 2010 03:57:08 -0400
In-Reply-To: <AANLkTinZ8If_JswEhoOShRZbQSjlh1uKgFYasnsfFeRx@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kyungmin Park <kmpark@infradead.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

--------------070001040209090206030202
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

Thanks you for the test.

here a new version of the patch. It doesn't replace mdelay with jiffies 
anymore. It changes mdelay to udelay (the granularity of 1 ms becomes 10 
us).
I didn't mesure irq off latency with this patch.

Matthieu


Kyungmin Park a écrit :
> Hi,
> 
> Not good news. This patch make a hang at probe time.
> it's tested against commit 7e27d6e778cd87b6f2415515d7127eba53fe5d02
> Author: Linus Torvalds <torvalds@linux-foundation.org>
> Date:   Fri Jun 11 19:14:04 2010 -0700
> 
>     Linux 2.6.35-rc3
> 
> Thank you,
> Kyungmin Park
> 
> On Thu, Jun 17, 2010 at 6:07 PM, Matthieu CASTET
> <matthieu.castet@parrot.com> wrote:
>> sdhci code got tasklets (sdhci_tasklet_card and sdhci_tasklet_finish),
>> that does :
>> {
>> spin_lock_irqsave
>>
>> if (cond) {
>> sdhci_reset
>> sdhci_reset
>> }
>>
>> spin_unlock_irqrestore
>> }
>>
>> sdhci_reset {
>> ...
>> while (read_reg) {
>> if (timeout == 0)
>>   break;
>> timeout--;
>> mdelay(1);
>> }
>> ...
>> }
>>
>>
>> The problem is that sdhci_reset [1] does busy pooling (with a granularity of
>> 1 ms) on a register up to a timeout of 100 ms.
>>
>> With the current code, we got irq off during 2*1ms. With the attached patch
>> we reduce irq off to 30 us.
>>
>> Note that worst case 100 ms irq off still exist.
>>
>> Signed-off-by: Matthieu CASTET <matthieu.castet@parrot.com>
>>
>>

--------------070001040209090206030202
Content-Type: text/x-diff; name="sdhci.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline; filename="sdhci.diff"

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index c6d1bd8..fa06c70 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -157,7 +157,7 @@ static void sdhci_reset(struct sdhci_host *host, u8 mask)
 		host->clock = 0;
 
 	/* Wait max 100 ms */
-	timeout = 100;
+	timeout = 100*100;
 
 	/* hw clears the bit when it's done */
 	while (sdhci_readb(host, SDHCI_SOFTWARE_RESET) & mask) {
@@ -168,7 +168,7 @@ static void sdhci_reset(struct sdhci_host *host, u8 mask)
 			return;
 		}
 		timeout--;
-		mdelay(1);
+		udelay(10);
 	}
 
 	if (host->quirks & SDHCI_QUIRK_RESTORE_IRQS_AFTER_RESET)
@@ -882,7 +882,7 @@ static void sdhci_send_command(struct sdhci_host *host, struct mmc_command *cmd)
 	WARN_ON(host->cmd);
 
 	/* Wait max 10 ms */
-	timeout = 10;
+	timeout = 10*100;
 
 	mask = SDHCI_CMD_INHIBIT;
 	if ((cmd->data != NULL) || (cmd->flags & MMC_RSP_BUSY))
@@ -903,7 +903,7 @@ static void sdhci_send_command(struct sdhci_host *host, struct mmc_command *cmd)
 			return;
 		}
 		timeout--;
-		mdelay(1);
+		udelay(10);
 	}
 
 	mod_timer(&host->timer, jiffies + 10 * HZ);
@@ -1007,7 +1007,7 @@ static void sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
 	sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
 
 	/* Wait max 20 ms */
-	timeout = 20;
+	timeout = 20*100;
 	while (!((clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL))
 		& SDHCI_CLOCK_INT_STABLE)) {
 		if (timeout == 0) {
@@ -1017,7 +1017,7 @@ static void sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
 			return;
 		}
 		timeout--;
-		mdelay(1);
+		udelay(10);
 	}
 
 	clk |= SDHCI_CLOCK_CARD_EN;

--------------070001040209090206030202--
