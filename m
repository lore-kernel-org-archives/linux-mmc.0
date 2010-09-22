From: Philip Rakity <prakity@marvell.com>
Subject: [PATCH] sdhci: print out controller name for register debug
Date: Wed, 22 Sep 2010 15:25:13 -0700
Message-ID: <1CE3965A-95E9-41A7-8333-432778AAC336@marvell.com>
References: <43E4817426ED174AA81263BCECB4351D131745CF98@sc-vexch3.marvell.com>
 <53E1B390-48DD-4E33-B51F-1B039AFD13A2@marvell.com>
 <4B9DEAE2.3030707@nokia.com>
 <3A9599CE-49EE-4A18-89E0-22B17090CA43@marvell.com>
 <4BA72971.1070804@nokia.com>
 <639D1595-D908-473C-9A41-71B493DCD0C0@marvell.com>
 <4BB052F6.5080808@nokia.com>
 <A9891FF4-9D4D-4F5C-ACE9-B272B53CCC08@marvell.com>
 <20100920061459.GA9353@pengutronix.de>
 <5F58EC42-069D-4469-BF13-F741674BE763@marvell.com>
 <57E26860-E2EC-4510-B928-62BCC7DC1AF8@marvell.com>
 <4C984B01.2000005@nokia.com>
 <F0EF1C13-8902-4839-9D76-C3045018660E@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from dakia3.marvell.com ([65.219.4.28]:54972 "EHLO
	dakia3.marvell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750746Ab0IVWZR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 22 Sep 2010 18:25:17 -0400
In-Reply-To: <F0EF1C13-8902-4839-9D76-C3045018660E@marvell.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@nokia.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: Mark Brown <markb@marvell.com>

>From 928a3fef14d44f4179cfe075380ad760720fea9e Mon Sep 17 00:00:00 2001
From: Philip Rakity <prakity@marvell.com>
Date: Wed, 22 Sep 2010 15:22:25 -0700
Subject: [PATCH] sdhci: print out controller name for register debug

In a multi-controller environment it is helpful to know which controller
has problems.

Signed-off-by: Philip Rakity <prakity@marvell.com>
---
 drivers/mmc/host/sdhci.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index e2b1f32..6b8ca32 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -47,7 +47,8 @@ static void sdhci_finish_command(struct sdhci_host *);
 
 static void sdhci_dumpregs(struct sdhci_host *host)
 {
-	printk(KERN_DEBUG DRIVER_NAME ": ============== REGISTER DUMP ==============\n");
+	printk(KERN_DEBUG DRIVER_NAME ": =========== REGISTER DUMP (%s)===========\n",
+		mmc_hostname(host->mmc));
 
 	printk(KERN_DEBUG DRIVER_NAME ": Sys addr: 0x%08x | Version:  0x%08x\n",
 		sdhci_readl(host, SDHCI_DMA_ADDRESS),
-- 
1.6.0.4

