From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH] mmc: prohibit card detection when host is not ready
Date: Thu, 14 Jun 2012 10:59:24 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1206141057500.30810@axis700.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:63308 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755189Ab2FNI7i (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 14 Jun 2012 04:59:38 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Chris Ball <cjb@laptop.org>, Magnus Damm <magnus.damm@gmail.com>

Currently mmc host drivers have to decide, whether to enable card detection
before calling mmc_add_host(), in which case a card insertion event can
arrive before the host has been completely initialised, or after
mmc_add_host(), in which case the initial card detection can be problematic.
This patch adds an explicit indication, when card detection should not be
carried out. With it in place enabling card detection before calling
mmc_add_host() should be safe. Similarly, disabling it again after calling
mmc_remove_host() will avoid any races.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 drivers/mmc/core/core.c |    2 ++
 drivers/mmc/core/host.c |    2 ++
 2 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 4aa8658..385cadf 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -2099,6 +2099,7 @@ void mmc_rescan(struct work_struct *work)
 void mmc_start_host(struct mmc_host *host)
 {
 	host->f_init = max(freqs[0], host->f_min);
+	host->rescan_disable = 0;
 	mmc_power_up(host);
 	mmc_detect_change(host, 0);
 }
@@ -2112,6 +2113,7 @@ void mmc_stop_host(struct mmc_host *host)
 	spin_unlock_irqrestore(&host->lock, flags);
 #endif
 
+	host->rescan_disable = 1;
 	cancel_delayed_work_sync(&host->detect);
 	mmc_flush_scheduled_work();
 
diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
index 74cf29a5..597f189 100644
--- a/drivers/mmc/core/host.c
+++ b/drivers/mmc/core/host.c
@@ -313,6 +313,8 @@ struct mmc_host *mmc_alloc_host(int extra, struct device *dev)
 	if (!host)
 		return NULL;
 
+	/* scanning will be enabled when we're ready */
+	host->rescan_disable = 1;
 	spin_lock(&mmc_host_lock);
 	err = idr_get_new(&mmc_host_idr, host, &host->index);
 	spin_unlock(&mmc_host_lock);
-- 
1.7.2.5

