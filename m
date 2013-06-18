From: "Shimoda, Yoshihiro" <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH v2] mmc: sh_mmcif: add SET_BLOCK_COUNT support
Date: Tue, 18 Jun 2013 12:15:12 +0900
Message-ID: <51BFD0C0.4080908@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from relmlor3.renesas.com ([210.160.252.173]:41954 "EHLO
	relmlor3.renesas.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752247Ab3FRDPP (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 17 Jun 2013 23:15:15 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: cjb@laptop.org
Cc: linux-mmc@vger.kernel.org, SH-Linux <linux-sh@vger.kernel.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>

This patch adds SET_BLOCK_COUNT(CMD23) support to sh_mmcif driver.
If we add MMC_CAP_CMD23 to ".caps" of sh_mmcif_plat_data, the mmc
core driver will use CMD23. Then, the sh_mmcif driver can use
Reliable Write feature.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 about v2:
  - remove the wait_for_completion() to process the .request() asynchronously.

 drivers/mmc/host/sh_mmcif.c |   64 +++++++++++++++++++++++++++++++++++++++---
 1 files changed, 59 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
index 8ef5efa..8f66532 100644
--- a/drivers/mmc/host/sh_mmcif.c
+++ b/drivers/mmc/host/sh_mmcif.c
@@ -223,7 +223,8 @@ enum mmcif_wait_for {

 struct sh_mmcif_host {
 	struct mmc_host *mmc;
-	struct mmc_request *mrq;
+	struct mmc_request *mrq;	/* current mmc_request pointer */
+	struct mmc_request *mrq_orig;	/* original .request()'s pointer */
 	struct platform_device *pd;
 	struct clk *hclk;
 	unsigned int clk;
@@ -244,6 +245,7 @@ struct sh_mmcif_host {
 	bool power;
 	bool card_present;
 	struct mutex thread_lock;
+	struct mmc_request mrq_sbc;	/* mmc_request for SBC */

 	/* DMA support */
 	struct dma_chan		*chan_rx;
@@ -802,7 +804,11 @@ static u32 sh_mmcif_set_cmd(struct sh_mmcif_host *host,
 		tmp |= CMD_SET_DWEN;
 	/* CMLTE/CMD12EN */
 	if (opc == MMC_READ_MULTIPLE_BLOCK || opc == MMC_WRITE_MULTIPLE_BLOCK) {
-		tmp |= CMD_SET_CMLTE | CMD_SET_CMD12EN;
+		/* If SBC, we don't use CMD12(STOP) */
+		if (mrq->sbc)
+			tmp |= CMD_SET_CMLTE;
+		else
+			tmp |= CMD_SET_CMLTE | CMD_SET_CMD12EN;
 		sh_mmcif_bitset(host, MMCIF_CE_BLOCK_SET,
 				data->blocks << 16);
 	}
@@ -936,9 +942,27 @@ static void sh_mmcif_request(struct mmc_host *mmc, struct mmc_request *mrq)
 		break;
 	}

-	host->mrq = mrq;
+	if (mrq->sbc) {
+		/* Store original mrq to mrq_orig */
+		host->mrq_orig = mrq;
+
+		/* Copy original mrq data to mrq_sbc */
+		host->mrq_sbc = *mrq;

-	sh_mmcif_start_cmd(host, mrq);
+		/* Switch the mrq_sbc.cmd for SBC */
+		host->mrq_sbc.cmd = mrq->sbc;
+		host->mrq_sbc.sbc = NULL;
+		host->mrq_sbc.data = NULL;
+		host->mrq_sbc.stop = NULL;
+
+		/* Set current mrq pointer to mrq_sbc */
+		host->mrq = &host->mrq_sbc;
+	} else {
+		/* Set current mrq pointer to original mrq */
+		host->mrq = mrq;
+	}
+
+	sh_mmcif_start_cmd(host, host->mrq);
 }

 static int sh_mmcif_clk_update(struct sh_mmcif_host *host)
@@ -1212,13 +1236,35 @@ static irqreturn_t sh_mmcif_irqt(int irq, void *dev_id)
 		return IRQ_HANDLED;
 	}

+	if (mrq->sbc && (mrq->cmd->opcode == MMC_WRITE_MULTIPLE_BLOCK) &&
+			(host->wait_for != MMCIF_WAIT_FOR_WRITE_END)) {
+		/* Wait for end of data phase */
+		host->wait_for = MMCIF_WAIT_FOR_WRITE_END;
+		sh_mmcif_bitset(host, MMCIF_CE_INT_MASK, MASK_MDTRANE);
+		schedule_delayed_work(&host->timeout_work, host->timeout);
+		mutex_unlock(&host->thread_lock);
+		return IRQ_HANDLED;
+	}
+
+	if (mrq->sbc && (mrq->cmd->opcode == MMC_READ_MULTIPLE_BLOCK) &&
+			(host->wait_for != MMCIF_WAIT_FOR_READ_END)) {
+		/* Wait for end of data phase */
+		host->wait_for = MMCIF_WAIT_FOR_READ_END;
+		sh_mmcif_bitset(host, MMCIF_CE_INT_MASK, MASK_MBUFRE);
+		schedule_delayed_work(&host->timeout_work, host->timeout);
+		mutex_unlock(&host->thread_lock);
+		return IRQ_HANDLED;
+	}
+
 	if (host->wait_for != MMCIF_WAIT_FOR_STOP) {
 		struct mmc_data *data = mrq->data;
 		if (!mrq->cmd->error && data && !data->error)
 			data->bytes_xfered =
 				data->blocks * data->blksz;

-		if (mrq->stop && !mrq->cmd->error && (!data || !data->error)) {
+		/* If SBC, we don't use CMD12(STOP) */
+		if (mrq->stop && !mrq->cmd->error && (!data || !data->error) &&
+		    !mrq->sbc) {
 			sh_mmcif_stop_cmd(host, mrq);
 			if (!mrq->stop->error) {
 				schedule_delayed_work(&host->timeout_work, host->timeout);
@@ -1228,6 +1274,14 @@ static irqreturn_t sh_mmcif_irqt(int irq, void *dev_id)
 		}
 	}

+	if ((mrq->cmd->opcode == MMC_SET_BLOCK_COUNT) && !mrq->cmd->error) {
+		/* Send the original .request() command */
+		host->mrq = host->mrq_orig;
+		sh_mmcif_start_cmd(host, host->mrq);
+		mutex_unlock(&host->thread_lock);
+		return IRQ_HANDLED;
+	}
+
 	host->wait_for = MMCIF_WAIT_FOR_REQUEST;
 	host->state = STATE_IDLE;
 	host->mrq = NULL;
-- 
1.7.1
