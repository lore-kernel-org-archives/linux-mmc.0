From: Balaji T K <balajitk@ti.com>
Subject: [PATCH 3/4] mmc: omap: use runtime put sync in probe error patch
Date: Fri, 24 Feb 2012 21:14:33 +0530
Message-ID: <1330098274-12048-4-git-send-email-balajitk@ti.com>
References: <1330098274-12048-1-git-send-email-balajitk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:48960 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756761Ab2BXPnk (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 24 Feb 2012 10:43:40 -0500
In-Reply-To: <1330098274-12048-1-git-send-email-balajitk@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, cjb@laptop.org
Cc: linux-omap@vger.kernel.org, Balaji T K <balajitk@ti.com>

pm_runtime_put_sync instead of autosuspend pm runtime API
because iounmap(host->base) follows immediately.

Reported-by: Rajendra Nayak <rnayak@ti.com>
Signed-off-by: Balaji T K <balajitk@ti.com>
---
 drivers/mmc/host/omap_hsmmc.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index c39fb8f..2576c36 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -2101,8 +2101,7 @@ err_reg:
 err_irq_cd_init:
 	free_irq(host->irq, host);
 err_irq:
-	pm_runtime_mark_last_busy(host->dev);
-	pm_runtime_put_autosuspend(host->dev);
+	pm_runtime_put_sync(host->dev);
 	clk_put(host->fclk);
 	if (host->got_dbclk) {
 		clk_disable(host->dbclk);
-- 
1.7.0.4

