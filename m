From: akpm@linux-foundation.org
Subject: [patch 083/232] sdhci-of: cleanup eSDHC's set_clock() a little bit
Date: Tue, 22 Sep 2009 16:45:16 -0700
Message-ID: <200909222345.n8MNjGTI013969@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:54447 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753408AbZIVXr4 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 22 Sep 2009 19:47:56 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, avorontsov@ru.mvista.com, ben@fluff.org, david.vrabel@csr.com, galak@kernel.crashing.org, linux-mmc@vger.kernel.org, pierre@ossman.eu, s.hauer@pengutronix.de

From: Anton Vorontsov <avorontsov@ru.mvista.com>

- Get rid of incomprehensible "if { for { if } }" construction for the
  exponential divisor calculation. The first if statement isn't correct
  at all, since it should check for "host->max_clk / pre_div / 16 >
  clock". The error doesn't cause any bugs because the check in the for
  loop does the right thing, and so the outer check becomes useless;

- For the linear divisor do the same: a single while statement is more
  readable than for + if construction;

- Add dev_dbg() that prints desired and actual clock frequency.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
Cc: Pierre Ossman <pierre@ossman.eu>
Cc: Kumar Gala <galak@kernel.crashing.org>
Cc: David Vrabel <david.vrabel@csr.com>
Cc: Ben Dooks <ben@fluff.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: <linux-mmc@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/mmc/host/sdhci-of.c |   19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff -puN drivers/mmc/host/sdhci-of.c~sdhci-of-cleanup-esdhcs-set_clock-a-little-bit drivers/mmc/host/sdhci-of.c
--- a/drivers/mmc/host/sdhci-of.c~sdhci-of-cleanup-esdhcs-set_clock-a-little-bit
+++ a/drivers/mmc/host/sdhci-of.c
@@ -121,8 +121,8 @@ static void esdhc_writeb(struct sdhci_ho
 
 static void esdhc_set_clock(struct sdhci_host *host, unsigned int clock)
 {
-	int div;
 	int pre_div = 2;
+	int div = 1;
 
 	clrbits32(host->ioaddr + ESDHC_SYSTEM_CONTROL, ESDHC_CLOCK_IPGEN |
 		  ESDHC_CLOCK_HCKEN | ESDHC_CLOCK_PEREN | ESDHC_CLOCK_MASK);
@@ -130,17 +130,14 @@ static void esdhc_set_clock(struct sdhci
 	if (clock == 0)
 		goto out;
 
-	if (host->max_clk / 16 > clock) {
-		for (; pre_div < 256; pre_div *= 2) {
-			if (host->max_clk / pre_div < clock * 16)
-				break;
-		}
-	}
+	while (host->max_clk / pre_div / 16 > clock && pre_div < 256)
+		pre_div *= 2;
 
-	for (div = 1; div <= 16; div++) {
-		if (host->max_clk / (div * pre_div) <= clock)
-			break;
-	}
+	while (host->max_clk / pre_div / div > clock && div < 16)
+		div++;
+
+	dev_dbg(mmc_dev(host->mmc), "desired SD clock: %d, actual: %d\n",
+		clock, host->max_clk / pre_div / div);
 
 	pre_div >>= 1;
 	div--;
_
