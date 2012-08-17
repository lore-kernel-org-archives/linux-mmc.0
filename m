From: Venkatraman S <svenkatr@ti.com>
Subject: [PATCH 07/10] mmc: omap_hsmmc: consolidate flush posted writes for HSMMC IRQs
Date: Sat, 18 Aug 2012 00:22:27 +0530
Message-ID: <1345229550-8672-8-git-send-email-svenkatr@ti.com>
References: <1345229550-8672-1-git-send-email-svenkatr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:55057 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932379Ab2HQSx6 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 17 Aug 2012 14:53:58 -0400
In-Reply-To: <1345229550-8672-1-git-send-email-svenkatr@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org
Cc: cjb@laptop.org, balajitk@ti.com, vishp@ti.com, Venkatraman S <svenkatr@ti.com>

Flushing spurious IRQs from HSMMC IP is done twice in
omap_hsmmc_irq and omap_hsmmc_do_irq.
Consolidate them to one location.

Signed-off-by: Venkatraman S <svenkatr@ti.com>
---
 drivers/mmc/host/omap_hsmmc.c | 17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 4bc55ac..20453c8 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -969,15 +969,6 @@ static void omap_hsmmc_do_irq(struct omap_hsmmc_host *host, int status)
 	struct mmc_data *data;
 	int end_cmd = 0, end_trans = 0;
 
-	if (!host->req_in_progress) {
-		do {
-			OMAP_HSMMC_WRITE(host->base, STAT, status);
-			/* Flush posted write */
-			status = OMAP_HSMMC_READ(host->base, STAT);
-		} while (status & INT_EN_MASK);
-		return;
-	}
-
 	data = host->data;
 	dev_vdbg(mmc_dev(host->mmc), "IRQ Status is %x\n", status);
 
@@ -1028,8 +1019,6 @@ static void omap_hsmmc_do_irq(struct omap_hsmmc_host *host, int status)
 		}
 	}
 
-	OMAP_HSMMC_WRITE(host->base, STAT, status);
-
 	if (end_cmd || ((status & CC) && host->cmd))
 		omap_hsmmc_cmd_done(host, host->cmd);
 	if ((end_trans || (status & TC)) && host->mrq)
@@ -1045,11 +1034,13 @@ static irqreturn_t omap_hsmmc_irq(int irq, void *dev_id)
 	int status;
 
 	status = OMAP_HSMMC_READ(host->base, STAT);
-	do {
+	while (status & INT_EN_MASK && host->req_in_progress) {
 		omap_hsmmc_do_irq(host, status);
+
 		/* Flush posted write */
+		OMAP_HSMMC_WRITE(host->base, STAT, status);
 		status = OMAP_HSMMC_READ(host->base, STAT);
-	} while (status & INT_EN_MASK);
+	}
 
 	return IRQ_HANDLED;
 }
-- 
1.7.11.1.25.g0e18bef

