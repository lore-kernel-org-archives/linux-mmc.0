From: akpm@linux-foundation.org
Subject: [patch 15/41] omap_hsmmc: remove unused local `state'
Date: Thu, 09 Sep 2010 16:37:46 -0700
Message-ID: <201009092337.o89NblG9014209@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:43818 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754389Ab0IIXsU (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 9 Sep 2010 19:48:20 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, saaguirre@ti.com, cjb@laptop.org, linux-mmc@vger.kernel.org, madhu.cr@ti.com, matt@console-pimps.org

From: Sergio Aguirre <saaguirre@ti.com>

This fixes the following warning:

drivers/mmc/host/omap_hsmmc.c: In function 'omap_hsmmc_suspend':
drivers/mmc/host/omap_hsmmc.c:2275: warning: unused variable 'state'

Introduced by commit ID:

  commit 1a13f8fa76c880be41d6b1e6a2b44404bcbfdf9e
  Author: Matt Fleming <matt@console-pimps.org>
  Date:   Wed May 26 14:42:08 2010 -0700

      mmc: remove the "state" argument to mmc_suspend_host()

The unique usage of this var was removed there, and missed
removing the respective declaration aswell.

Signed-off-by: Sergio Aguirre <saaguirre@ti.com>
Signed-off-by: Chris Ball <cjb@laptop.org>
Acked-by: Matt Fleming <matt@console-pimps.org>
Cc: Madhusudhan Chikkature <madhu.cr@ti.com>
Cc: <linux-mmc@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/mmc/host/omap_hsmmc.c |    1 -
 1 file changed, 1 deletion(-)

diff -puN drivers/mmc/host/omap_hsmmc.c~omap_hsmmc-remove-unused-state-variable drivers/mmc/host/omap_hsmmc.c
--- a/drivers/mmc/host/omap_hsmmc.c~omap_hsmmc-remove-unused-state-variable
+++ a/drivers/mmc/host/omap_hsmmc.c
@@ -2305,7 +2305,6 @@ static int omap_hsmmc_suspend(struct dev
 	int ret = 0;
 	struct platform_device *pdev = to_platform_device(dev);
 	struct omap_hsmmc_host *host = platform_get_drvdata(pdev);
-	pm_message_t state = PMSG_SUSPEND; /* unused by MMC core */
 
 	if (host && host->suspended)
 		return 0;
_
