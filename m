From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH] mmc: omap: Fix NULL pointer dereference if
 mmc_omap_new_slot() fails
Date: Mon, 28 May 2012 03:36:42 -0700
Message-ID: <20120528103641.GA12766@atomide.com>
References: <20120528065347.GR17852@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:42527 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753209Ab2E1Kgp (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 28 May 2012 06:36:45 -0400
Content-Disposition: inline
In-Reply-To: <20120528065347.GR17852@atomide.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Venkatraman S <svenkatr@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Chris Ball <cjb@laptop.org>

Commit b01a4f1c (mmc: omap: convert to per instance workqueue) initializes
the workqueue too late causing the following:

Unable to handle kernel NULL pointer dereference at virtual address 00000000
pgd = c0004000
[00000000] *pgd=00000000
Internal error: Oops: 5 [#1] SMP ARM
Modules linked in:
CPU: 0    Not tainted  (3.4.0-08218-gb48b2c3 #158)
PC is at __queue_work+0x8/0x46c
LR is at queue_work_on+0x38/0x40
pc : [<c005bb4c>]    lr : [<c005c00c>]    psr: 60000193
sp : c0691e1c  ip : 00000000  fp : c07374ac
r10: c7aae400  r9 : c0395700  r8 : 00000100
r7 : c0691e70  r6 : 00000000  r5 : 00000000  r4 : c7aae440
r3 : 00000001  r2 : c7aae440  r1 : 00000000  r0 : 00000000
Flags: nZCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
Control: 00c5387d  Table: 80004000  DAC: 00000017
Process swapper/0 (pid: 0, stack limit = 0xc06902f8)
Stack: (0xc0691e1c to 0xc0692000)

Fix this by initializing the workqueue before mmc_omap_remove_slot()
get called. Tested on n770, looks like n800 at least still has some
other issue with MMC.

Signed-off-by: Tony Lindgren <tony@atomide.com>

--- a/drivers/mmc/host/omap.c
+++ b/drivers/mmc/host/omap.c
@@ -1485,24 +1485,27 @@ static int __devinit mmc_omap_probe(struct platform_device *pdev)
 	}
 
 	host->nr_slots = pdata->nr_slots;
+
+	host->mmc_omap_wq = alloc_workqueue("mmc_omap", 0, 0);
+	if (!host->mmc_omap_wq)
+		goto err_plat_cleanup;
+
 	for (i = 0; i < pdata->nr_slots; i++) {
 		ret = mmc_omap_new_slot(host, i);
 		if (ret < 0) {
 			while (--i >= 0)
 				mmc_omap_remove_slot(host->slots[i]);
 
-			goto err_plat_cleanup;
+			goto err_destroy_wq;
 		}
 	}
 
 	host->reg_shift = (cpu_is_omap7xx() ? 1 : 2);
 
-	host->mmc_omap_wq = alloc_workqueue("mmc_omap", 0, 0);
-	if (!host->mmc_omap_wq)
-		goto err_plat_cleanup;
-
 	return 0;
 
+err_destroy_wq:
+	destroy_workqueue(host->mmc_omap_wq);
 err_plat_cleanup:
 	if (pdata->cleanup)
 		pdata->cleanup(&pdev->dev);
