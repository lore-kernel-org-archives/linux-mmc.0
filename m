From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 2/2] mmc: tmio: fix a deadlock
Date: Thu, 14 Jul 2011 18:39:10 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1107141838380.10688@axis700.grange>
References: <Pine.LNX.4.64.1107141828470.10688@axis700.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:49291 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932076Ab1GNQjR (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 14 Jul 2011 12:39:17 -0400
In-Reply-To: <Pine.LNX.4.64.1107141828470.10688@axis700.grange>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Magnus Damm <damm@opensource.se>, "Rafael J. Wysocki" <rjw@sisk.pl>, Chris Ball <cjb@laptop.org>, Ian Molton <ian@mnementh.co.uk>, Simon Horman <horms@verge.net.au>

Currently the tmio-mmc driver contains a recursive runtime PM method
invocation, which leads to a deadlock on a mutex. Avoid it by taking
care not to request DMA too early.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 drivers/mmc/host/tmio_mmc.h     |    5 +++++
 drivers/mmc/host/tmio_mmc_dma.c |    5 ++++-
 drivers/mmc/host/tmio_mmc_pio.c |    4 ++--
 3 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/tmio_mmc.h b/drivers/mmc/host/tmio_mmc.h
index 551d1ef..60ba335 100644
--- a/drivers/mmc/host/tmio_mmc.h
+++ b/drivers/mmc/host/tmio_mmc.h
@@ -109,6 +109,7 @@ static inline void tmio_mmc_kunmap_atomic(struct scatterlist *sg,
 
 #if defined(CONFIG_MMC_SDHI) || defined(CONFIG_MMC_SDHI_MODULE)
 void tmio_mmc_start_dma(struct tmio_mmc_host *host, struct mmc_data *data);
+void tmio_mmc_enable_dma(struct tmio_mmc_host *host, bool enable);
 void tmio_mmc_request_dma(struct tmio_mmc_host *host, struct tmio_mmc_data *pdata);
 void tmio_mmc_release_dma(struct tmio_mmc_host *host);
 #else
@@ -117,6 +118,10 @@ static inline void tmio_mmc_start_dma(struct tmio_mmc_host *host,
 {
 }
 
+static inline void tmio_mmc_enable_dma(struct tmio_mmc_host *host, bool enable)
+{
+}
+
 static inline void tmio_mmc_request_dma(struct tmio_mmc_host *host,
 				 struct tmio_mmc_data *pdata)
 {
diff --git a/drivers/mmc/host/tmio_mmc_dma.c b/drivers/mmc/host/tmio_mmc_dma.c
index 7e86662..2aa616d 100644
--- a/drivers/mmc/host/tmio_mmc_dma.c
+++ b/drivers/mmc/host/tmio_mmc_dma.c
@@ -22,8 +22,11 @@
 
 #define TMIO_MMC_MIN_DMA_LEN 8
 
-static void tmio_mmc_enable_dma(struct tmio_mmc_host *host, bool enable)
+void tmio_mmc_enable_dma(struct tmio_mmc_host *host, bool enable)
 {
+	if (!host->chan_tx || !host->chan_rx)
+		return;
+
 #if defined(CONFIG_SUPERH) || defined(CONFIG_ARCH_SHMOBILE)
 	/* Switch DMA mode on or off - SuperH specific? */
 	sd_ctrl_write16(host, CTL_DMA_ENABLE, enable ? 2 : 0);
diff --git a/drivers/mmc/host/tmio_mmc_pio.c b/drivers/mmc/host/tmio_mmc_pio.c
index 221ffb7..1f16357 100644
--- a/drivers/mmc/host/tmio_mmc_pio.c
+++ b/drivers/mmc/host/tmio_mmc_pio.c
@@ -984,7 +984,7 @@ int tmio_mmc_host_resume(struct device *dev)
 	if (host->pm_global) {
 		/* Runtime PM resume callback didn't run */
 		tmio_mmc_reset(host);
-		tmio_mmc_request_dma(host, host->pdata);
+		tmio_mmc_enable_dma(host, true);
 		host->pm_global = false;
 	}
 
@@ -1007,7 +1007,7 @@ int tmio_mmc_host_runtime_resume(struct device *dev)
 	struct tmio_mmc_data *pdata = host->pdata;
 
 	tmio_mmc_reset(host);
-	tmio_mmc_request_dma(host, host->pdata);
+	tmio_mmc_enable_dma(host, true);
 
 	if (pdata->power) {
 		/* Only entered after a card-insert interrupt */
-- 
1.7.2.5

