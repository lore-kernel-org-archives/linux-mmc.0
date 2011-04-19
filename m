From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH/RFC] MMC: remove unbalanced pm_runtime_suspend()
Date: Tue, 19 Apr 2011 12:46:20 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1104191230150.16641@axis700.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:65396 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754423Ab1DSKqY (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 19 Apr 2011 06:46:24 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Alan Stern <stern@rowland.harvard.edu>, Magnus Damm <damm@opensource.se>, Simon Horman <horms@verge.net.au>, "Rafael J. Wysocki" <rjw@sisk.pl>

MMC bus PM operations implement a .runtime_idle() method, which calls 
pm_runtime_suspend(), but this call is not balanced by a resume 
counterpart, which causes problems with repeated card-plug and driver-load 
cycles. Removing this method fixes the disbalance.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---

With this patch and with v2 of the MMCIF PM patch, that I'll be posting 
shortly, I can load / unload the driver, insert and remove the card and 
suspend and wake up the system multiple times and each time the full PM 
cycle is performed, going down to the platform callbacks. However, it 
might well be, that there's a more correct way to achieve the same.

diff --git a/drivers/mmc/core/bus.c b/drivers/mmc/core/bus.c
index 63667a8..44866a6 100644
--- a/drivers/mmc/core/bus.c
+++ b/drivers/mmc/core/bus.c
@@ -158,15 +158,9 @@ static int mmc_runtime_resume(struct device *dev)
 	return mmc_power_restore_host(card->host);
 }
 
-static int mmc_runtime_idle(struct device *dev)
-{
-	return pm_runtime_suspend(dev);
-}
-
 static const struct dev_pm_ops mmc_bus_pm_ops = {
 	.runtime_suspend	= mmc_runtime_suspend,
 	.runtime_resume		= mmc_runtime_resume,
-	.runtime_idle		= mmc_runtime_idle,
 };
 
 #define MMC_PM_OPS_PTR	(&mmc_bus_pm_ops)
