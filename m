From: akpm@linux-foundation.org
Subject: [patch 078/232] sdhci-of: fix SD clock calculation
Date: Tue, 22 Sep 2009 16:45:10 -0700
Message-ID: <200909222345.n8MNjAFg013781@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:55041 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752984AbZIWAPY (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 22 Sep 2009 20:15:24 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, avorontsov@ru.mvista.com, ben@fluff.org, david.vrabel@csr.com, galak@kernel.crashing.org, linux-mmc@vger.kernel.org, pierre@ossman.eu, s.hauer@pengutronix.de

From: Anton Vorontsov <avorontsov@ru.mvista.com>

Linear divisor's values in a register start at 0 (zero means "divide by
1").  Before this patch the code didn't account that fact, so SD cards
were running underclocked.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
Cc: Pierre Ossman <pierre@ossman.eu>
Cc: Kumar Gala <galak@kernel.crashing.org>
Cc: David Vrabel <david.vrabel@csr.com>
Cc: Ben Dooks <ben@fluff.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: <linux-mmc@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/mmc/host/sdhci-of.c |    1 +
 1 file changed, 1 insertion(+)

diff -puN drivers/mmc/host/sdhci-of.c~sdhci-of-fix-sd-clock-calculation drivers/mmc/host/sdhci-of.c
--- a/drivers/mmc/host/sdhci-of.c~sdhci-of-fix-sd-clock-calculation
+++ a/drivers/mmc/host/sdhci-of.c
@@ -136,6 +136,7 @@ static void esdhc_set_clock(struct sdhci
 	}
 
 	pre_div >>= 1;
+	div--;
 
 	setbits32(host->ioaddr + ESDHC_SYSTEM_CONTROL, ESDHC_CLOCK_IPGEN |
 		  ESDHC_CLOCK_HCKEN | ESDHC_CLOCK_PEREN |
_
