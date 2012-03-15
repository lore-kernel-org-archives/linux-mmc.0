From: Venkatraman S <svenkatr@ti.com>
Subject: [PATCH RESEND 3/8] mmc: omap: use runtime put sync in probe error patch
Date: Thu, 15 Mar 2012 20:03:37 +0530
Message-ID: <1331822022-26714-4-git-send-email-svenkatr@ti.com>
References: <y>
 <1331822022-26714-1-git-send-email-svenkatr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <1331822022-26714-1-git-send-email-svenkatr@ti.com>
Sender: linux-omap-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org
Cc: cjb@laptop.org, balajitk@ti.com, balbi@ti.com
List-Id: linux-mmc@vger.kernel.org

From: Balaji T K <balajitk@ti.com>

pm_runtime_put_sync instead of autosuspend pm runtime API
because iounmap(host->base) follows immediately.

Reported-by: Rajendra Nayak <rnayak@ti.com>
Signed-off-by: Balaji T K <balajitk@ti.com>
---
 drivers/mmc/host/omap_hsmmc.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index db8af43..0f8d34b 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -2014,8 +2014,7 @@ err_reg:
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

