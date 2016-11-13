From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH 1/2] mmc: tmio: fix wrong bitmask for SDIO irqs
Date: Sun, 13 Nov 2016 15:29:11 +0100
Message-ID: <20161113142912.4041-2-wsa+renesas@sang-engineering.com>
References: <20161113142912.4041-1-wsa+renesas@sang-engineering.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:46116 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751810AbcKMO3Y (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Sun, 13 Nov 2016 09:29:24 -0500
In-Reply-To: <20161113142912.4041-1-wsa+renesas@sang-engineering.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, Simon Horman <horms@verge.net.au>, Wolfram Sang <wsa+renesas@sang-engineering.com>

Commit 7729c7a232a953 ("mmc: tmio: Provide separate interrupt handlers")
refactored the sdio irq handler and wrongly used the mask for SD irqs,
not for SDIO irqs. This doesn't really matter in practice because both
values keep the only interrupt we are interested in. But still, this is
wrong and wants to be fixed.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/mmc/host/tmio_mmc_pio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/tmio_mmc_pio.c b/drivers/mmc/host/tmio_mmc_pio.c
index dbc3cb14f3321b..2b04e6e87192c7 100644
--- a/drivers/mmc/host/tmio_mmc_pio.c
+++ b/drivers/mmc/host/tmio_mmc_pio.c
@@ -741,7 +741,7 @@ static void tmio_mmc_sdio_irq(int irq, void *devid)
 		return;
 
 	status = sd_ctrl_read16(host, CTL_SDIO_STATUS);
-	ireg = status & TMIO_SDIO_MASK_ALL & ~host->sdcard_irq_mask;
+	ireg = status & TMIO_SDIO_MASK_ALL & ~host->sdio_irq_mask;
 
 	sdio_status = status & ~TMIO_SDIO_MASK_ALL;
 	if (pdata->flags & TMIO_MMC_SDIO_STATUS_QUIRK)
-- 
2.9.3

