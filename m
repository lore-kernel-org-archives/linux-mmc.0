From: "Du, Alek" <alek.du@intel.com>
Subject: [PATCH] sdhci: fix the fake timeout bug
Date: Fri, 30 Nov 2018 15:00:28 +0800
Message-ID: <20181130150028.732896d8@xdu1-mobl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org, adrian.hunter@intel.com, ulf.hansson@linaro.org
Cc: linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

>From b893df3a1a937bd5fe22d39ceae93454a2e5e0e4 Mon Sep 17 00:00:00 2001
From: Alek Du <alek.du@intel.com>
Date: Fri, 30 Nov 2018 14:02:28 +0800
Subject: [PATCH] sdhci: fix the fake timeout bug

We observed some fake timeouts on some devices, the log is like this:

[ 7586.290201] mmc1: Timeout waiting for hardware cmd interrupt.
[ 7586.290420] mmc1: sdhci: ============ SDHCI REGISTER DUMP ===========
...
[ 7586.291774] mmc1: sdhci: Wake-up:   0x00000000 | Clock:    0x00000203

>From the clock control register dump, we are pretty sure the clock was
stabilized.

In other cases, we also observed:

[ 7596.530171] mmc1: Timeout waiting for hardware cmd interrupt.

and

[ 1956.534634] mmc1: Reset 0x2 never completed.

But we are pretty sure the mmc controller is working perfectly under low
system load.

After checking the sdhci code, we found the timeout check actually has a
little window that the CPU can be scheduled out and when it comes back,
the original time set or check is not valid.

Signed-off-by: Alek Du <alek.du@intel.com>
---
 drivers/mmc/host/sdhci.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 99bdae53fa2e..f88c49fc574e 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -218,12 +218,17 @@ void sdhci_reset(struct sdhci_host *host, u8 mask)
 	/* hw clears the bit when it's done */
 	while (sdhci_readb(host, SDHCI_SOFTWARE_RESET) & mask) {
 		if (ktime_after(ktime_get(), timeout)) {
+			/* check it again, since there is a window between
+			   bit check and time check */
+			if (!(sdhci_readb(host, SDHCI_SOFTWARE_RESET) & mask))
+				break;
 			pr_err("%s: Reset 0x%x never completed.\n",
 				mmc_hostname(host->mmc), (int)mask);
 			sdhci_dumpregs(host);
 			return;
+		} else {
+			udelay(10);
 		}
-		udelay(10);
 	}
 }
 EXPORT_SYMBOL_GPL(sdhci_reset);
@@ -1395,9 +1400,10 @@ void sdhci_send_command(struct sdhci_host *host, struct mmc_command *cmd)
 		timeout += DIV_ROUND_UP(cmd->busy_timeout, 1000) * HZ + HZ;
 	else
 		timeout += 10 * HZ;
-	sdhci_mod_timer(host, cmd->mrq, timeout);
 
 	sdhci_writew(host, SDHCI_MAKE_CMD(cmd->opcode, flags), SDHCI_COMMAND);
+	/* setup timer after command to avoid fake timeout */
+	sdhci_mod_timer(host, cmd->mrq, timeout);
 }
 EXPORT_SYMBOL_GPL(sdhci_send_command);
 
@@ -1611,12 +1617,19 @@ void sdhci_enable_clk(struct sdhci_host *host, u16 clk)
 	while (!((clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL))
 		& SDHCI_CLOCK_INT_STABLE)) {
 		if (ktime_after(ktime_get(), timeout)) {
+			/* check it again since there is a window between
+			   status check and time check */
+			if ((clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL))
+					& SDHCI_CLOCK_INT_STABLE)
+				break;
 			pr_err("%s: Internal clock never stabilised.\n",
 			       mmc_hostname(host->mmc));
 			sdhci_dumpregs(host);
 			return;
 		}
-		udelay(10);
+		else {
+			udelay(10);
+		}
 	}
 
 	clk |= SDHCI_CLOCK_CARD_EN;
-- 
2.17.1
