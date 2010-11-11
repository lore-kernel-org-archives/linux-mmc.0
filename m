From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH] mmc: fix rmmod race for card-detection polling hosts
Date: Thu, 11 Nov 2010 17:32:25 +0100 (CET)
Message-ID: <Pine.LNX.4.64.1011111730170.15747@axis700.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout-de.gmx.net ([213.165.64.22]:46646 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1754337Ab0KKQcT (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 11 Nov 2010 11:32:19 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Chris Ball <cjb@laptop.org>

MMC hosts, using polling for card detection by defining the MMC_CAP_NEEDS_POLL
flag, have a race on rmmod, where the delayed work is cancelled without
waiting for completed polling. To prevent this a _sync version of the work
cancellation has to be used.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---

Chris, if this bug is old enough, this should also go to stable 
eventually.

 drivers/mmc/core/core.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 8f86d70..31ae07a 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -1559,7 +1559,7 @@ void mmc_stop_host(struct mmc_host *host)
 
 	if (host->caps & MMC_CAP_DISABLE)
 		cancel_delayed_work(&host->disable);
-	cancel_delayed_work(&host->detect);
+	cancel_delayed_work_sync(&host->detect);
 	mmc_flush_scheduled_work();
 
 	/* clear pm flags now and let card drivers set them as needed */
-- 
1.7.2.3

