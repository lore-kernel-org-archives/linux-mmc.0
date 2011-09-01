From: Venkatraman S <svenkatr@ti.com>
Subject: [PATCH 2/2] omap: hsmmc: Don't hold spinlock during dma configuration
Date: Fri, 2 Sep 2011 00:35:57 +0530
Message-ID: <1314903957-24408-3-git-send-email-svenkatr@ti.com>
References: <y>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:44191 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757438Ab1IATHy (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 1 Sep 2011 15:07:54 -0400
In-Reply-To: <y>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org
Cc: per.forlin@linaro.org, cjb@laptop.org, Venkatraman S <svenkatr@ti.com>

No need to hold the spinlock during a rather long dma configuration
sequence inside dma callback, which doesn't need it.

Signed-off-by: Venkatraman S <svenkatr@ti.com>
---
 drivers/mmc/host/omap_hsmmc.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 5b7776c..c5fd413 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -1384,10 +1384,10 @@ static void omap_hsmmc_dma_cb(int lch, u16 ch_status, void *cb_data)
 	data = host->mrq->data;
 	host->dma_sg_idx++;
 	if (host->dma_sg_idx < host->dma_len) {
+		spin_unlock(&host->irq_lock);
 		/* Fire up the next transfer. */
 		omap_hsmmc_config_dma_params(host, data,
 					   data->sg + host->dma_sg_idx);
-		spin_unlock(&host->irq_lock);
 		return;
 	}
 
-- 
1.7.1

