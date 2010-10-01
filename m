From: Philip Rakity <prakity@marvell.com>
Subject: [PATCH] sdhci: adjust sd 3.0 host controller spec clock divider
Date: Thu, 30 Sep 2010 20:03:14 -0700
Message-ID: <CDD4A6CE-487A-4740-87BA-96EEBF1E8217@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:56970 "HELO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751542Ab0JADKR convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 30 Sep 2010 23:10:17 -0400
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

>From 8136dcbf78b5f9914caffbedf0ac2bc86426002c Mon Sep 17 00:00:00 2001
From: Philip Rakity <prakity@marvell.com>
Date: Thu, 30 Sep 2010 15:34:24 -0700
Subject: [PATCH] sdhci: adjust sd 3.0 host controller spec clock divider

The sd 3.0 host spec does not require the clock divider to be a power of 2.

Signed-off-by: Philip Rakity <prakity@marvell.com>
---
 drivers/mmc/host/sdhci.c |    8 +++-----
 1 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 96c7f60..73a94fe 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1003,14 +1003,12 @@ static void sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
 		goto out;
 
 	if (host->version >= SDHCI_SPEC_300) {
-		/* Version 3.00 divisors must be a multiple of 2. */
 		if (host->max_clk <= clock)
 			div = 1;
 		else {
-			for (div = 2; div < SDHCI_MAX_DIV_SPEC_300; div += 2) {
-				if ((host->max_clk / div) <= clock)
-					break;
-			}
+			div = host->max_clk/clock;
+			if (host->max_clk % clock)
+				div++;
 		}
 	} else {
 		/* Version 2.00 divisors must be a power of 2. */
-- 
1.6.0.4

