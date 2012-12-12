From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 07/14] mmc: sh-mmcif: fix missing and consolidate IO completion timeouts
Date: Wed, 12 Dec 2012 15:38:11 +0100
Message-ID: <1355323098-18061-8-git-send-email-g.liakhovetski@gmx.de>
References: <1355323098-18061-1-git-send-email-g.liakhovetski@gmx.de>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1355323098-18061-1-git-send-email-g.liakhovetski@gmx.de>
Sender: linux-sh-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Chris Ball <cjb@laptop.org>
List-Id: linux-mmc@vger.kernel.org

Read block and write block operations are currently missing completion
timeouts. Add missing timeouts and consolidate them at one location.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 drivers/mmc/host/sh_mmcif.c |   45 +++++++++++++++++++++----------------------
 1 files changed, 22 insertions(+), 23 deletions(-)

diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
index 092c415..ac4c3c3 100644
--- a/drivers/mmc/host/sh_mmcif.c
+++ b/drivers/mmc/host/sh_mmcif.c
@@ -564,7 +564,6 @@ static void sh_mmcif_single_read(struct sh_mmcif_host *host,
 			   BLOCK_SIZE_MASK) + 3;
 
 	host->wait_for = MMCIF_WAIT_FOR_READ;
-	schedule_delayed_work(&host->timeout_work, host->timeout);
 
 	/* buf read enable */
 	sh_mmcif_bitset(host, MMCIF_CE_INT_MASK, MASK_MBUFREN);
@@ -606,7 +605,7 @@ static void sh_mmcif_multi_read(struct sh_mmcif_host *host,
 	host->sg_idx = 0;
 	host->sg_blkidx = 0;
 	host->pio_ptr = sg_virt(data->sg);
-	schedule_delayed_work(&host->timeout_work, host->timeout);
+
 	sh_mmcif_bitset(host, MMCIF_CE_INT_MASK, MASK_MBUFREN);
 }
 
@@ -629,7 +628,6 @@ static bool sh_mmcif_mread_block(struct sh_mmcif_host *host)
 	if (!sh_mmcif_next_block(host, p))
 		return false;
 
-	schedule_delayed_work(&host->timeout_work, host->timeout);
 	sh_mmcif_bitset(host, MMCIF_CE_INT_MASK, MASK_MBUFREN);
 
 	return true;
@@ -642,7 +640,6 @@ static void sh_mmcif_single_write(struct sh_mmcif_host *host,
 			   BLOCK_SIZE_MASK) + 3;
 
 	host->wait_for = MMCIF_WAIT_FOR_WRITE;
-	schedule_delayed_work(&host->timeout_work, host->timeout);
 
 	/* buf write enable */
 	sh_mmcif_bitset(host, MMCIF_CE_INT_MASK, MASK_MBUFWEN);
@@ -684,7 +681,7 @@ static void sh_mmcif_multi_write(struct sh_mmcif_host *host,
 	host->sg_idx = 0;
 	host->sg_blkidx = 0;
 	host->pio_ptr = sg_virt(data->sg);
-	schedule_delayed_work(&host->timeout_work, host->timeout);
+
 	sh_mmcif_bitset(host, MMCIF_CE_INT_MASK, MASK_MBUFWEN);
 }
 
@@ -707,7 +704,6 @@ static bool sh_mmcif_mwrite_block(struct sh_mmcif_host *host)
 	if (!sh_mmcif_next_block(host, p))
 		return false;
 
-	schedule_delayed_work(&host->timeout_work, host->timeout);
 	sh_mmcif_bitset(host, MMCIF_CE_INT_MASK, MASK_MBUFWEN);
 
 	return true;
@@ -900,7 +896,6 @@ static void sh_mmcif_stop_cmd(struct sh_mmcif_host *host,
 	}
 
 	host->wait_for = MMCIF_WAIT_FOR_STOP;
-	schedule_delayed_work(&host->timeout_work, host->timeout);
 }
 
 static void sh_mmcif_request(struct mmc_host *mmc, struct mmc_request *mrq)
@@ -1121,6 +1116,7 @@ static irqreturn_t sh_mmcif_irqt(int irq, void *dev_id)
 {
 	struct sh_mmcif_host *host = dev_id;
 	struct mmc_request *mrq = host->mrq;
+	bool wait = false;
 
 	cancel_delayed_work_sync(&host->timeout_work);
 
@@ -1133,29 +1129,24 @@ static irqreturn_t sh_mmcif_irqt(int irq, void *dev_id)
 		/* We're too late, the timeout has already kicked in */
 		return IRQ_HANDLED;
 	case MMCIF_WAIT_FOR_CMD:
-		if (sh_mmcif_end_cmd(host))
-			/* Wait for data */
-			return IRQ_HANDLED;
+		/* Wait for data? */
+		wait = sh_mmcif_end_cmd(host);
 		break;
 	case MMCIF_WAIT_FOR_MREAD:
-		if (sh_mmcif_mread_block(host))
-			/* Wait for more data */
-			return IRQ_HANDLED;
+		/* Wait for more data? */
+		wait = sh_mmcif_mread_block(host);
 		break;
 	case MMCIF_WAIT_FOR_READ:
-		if (sh_mmcif_read_block(host))
-			/* Wait for data end */
-			return IRQ_HANDLED;
+		/* Wait for data end? */
+		wait = sh_mmcif_read_block(host);
 		break;
 	case MMCIF_WAIT_FOR_MWRITE:
-		if (sh_mmcif_mwrite_block(host))
-			/* Wait data to write */
-			return IRQ_HANDLED;
+		/* Wait data to write? */
+		wait = sh_mmcif_mwrite_block(host);
 		break;
 	case MMCIF_WAIT_FOR_WRITE:
-		if (sh_mmcif_write_block(host))
-			/* Wait for data end */
-			return IRQ_HANDLED;
+		/* Wait for data end? */
+		wait = sh_mmcif_write_block(host);
 		break;
 	case MMCIF_WAIT_FOR_STOP:
 		if (host->sd_error) {
@@ -1174,6 +1165,12 @@ static irqreturn_t sh_mmcif_irqt(int irq, void *dev_id)
 		BUG();
 	}
 
+	if (wait) {
+		schedule_delayed_work(&host->timeout_work, host->timeout);
+		/* Wait for more data */
+		return IRQ_HANDLED;
+	}
+
 	if (host->wait_for != MMCIF_WAIT_FOR_STOP) {
 		struct mmc_data *data = mrq->data;
 		if (!mrq->cmd->error && data && !data->error)
@@ -1182,8 +1179,10 @@ static irqreturn_t sh_mmcif_irqt(int irq, void *dev_id)
 
 		if (mrq->stop && !mrq->cmd->error && (!data || !data->error)) {
 			sh_mmcif_stop_cmd(host, mrq);
-			if (!mrq->stop->error)
+			if (!mrq->stop->error) {
+				schedule_delayed_work(&host->timeout_work, host->timeout);
 				return IRQ_HANDLED;
+			}
 		}
 	}
 
-- 
1.7.2.5

