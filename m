From: Venkatraman S <svenkatr@ti.com>
Subject: [PATCH v2 3/8] mmc: omap: use runtime put sync in probe error patch
Date: Fri, 16 Mar 2012 19:08:59 +0530
Message-ID: <1331905144-31655-4-git-send-email-svenkatr@ti.com>
References: <y>
 <1331905144-31655-1-git-send-email-svenkatr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:41773 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755349Ab2CPNk3 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 16 Mar 2012 09:40:29 -0400
In-Reply-To: <1331905144-31655-1-git-send-email-svenkatr@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org
Cc: cjb@laptop.org, balajitk@ti.com, balbi@ti.com, Venkatraman S <svenkatr@ti.com>, stable <stable@vger.kernel.org>

From: Balaji T K <balajitk@ti.com>

pm_runtime_put_sync instead of autosuspend pm runtime API
because iounmap(host->base) follows immediately.

Reported-by: Rajendra Nayak <rnayak@ti.com>
Signed-off-by: Balaji T K <balajitk@ti.com>
Signed-off-by: Venkatraman S <svenkatr@ti.com>
Cc: stable <stable@vger.kernel.org>
---
 drivers/mmc/host/omap_hsmmc.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index d682c5e..baa06f9 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -2013,8 +2013,7 @@ err_reg:
 err_irq_cd_init:
 	free_irq(host->irq, host);
 err_irq:
-	pm_runtime_mark_last_busy(host->dev);
-	pm_runtime_put_autosuspend(host->dev);
+	pm_runtime_put_sync(host->dev);
 	pm_runtime_disable(host->dev);
 	clk_put(host->fclk);
 	if (host->got_dbclk) {
-- 
1.7.10.rc0.41.gfa678

