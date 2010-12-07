From: Sahitya Tummala <stummala@codeaurora.org>
Subject: [PATCH 5/5] mmc: msm_sdcc: Check for only DATA_END interrupt to end a request
Date: Tue,  7 Dec 2010 16:25:16 +0530
Message-ID: <1291719316-23948-5-git-send-email-stummala@codeaurora.org>
References: <1291719316-23948-1-git-send-email-stummala@codeaurora.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from wolverine01.qualcomm.com ([199.106.114.254]:8608 "EHLO
	wolverine01.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751856Ab0LGK4Q (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 7 Dec 2010 05:56:16 -0500
In-Reply-To: <1291719316-23948-1-git-send-email-stummala@codeaurora.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: cjb@laptop.org, linux-mmc@vger.kernel.org
Cc: san@google.com, linux-arm-msm@vger.kernel.org, Sahitya Tummala <stummala@codeaurora.org>

The current code checks for both DATA_END and DATA_BLK_END bits in
MCI_STATUS register and ends a request only if both are set at a time.
The hardware doesn't always set DATA_BLK_END when DATA_END is set.
But DATA_END status itself is sufficient condition from hardware that
data transfer is done and hence, check for only DATA_END interrupt in
software to end a request.

Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>
---
 drivers/mmc/host/msm_sdcc.c |   15 ++++-----------
 drivers/mmc/host/msm_sdcc.h |    1 -
 2 files changed, 4 insertions(+), 12 deletions(-)

diff --git a/drivers/mmc/host/msm_sdcc.c b/drivers/mmc/host/msm_sdcc.c
index 355d799..23b6f57 100644
--- a/drivers/mmc/host/msm_sdcc.c
+++ b/drivers/mmc/host/msm_sdcc.c
@@ -190,7 +190,7 @@ static void
 msmsdcc_stop_data(struct msmsdcc_host *host)
 {
 	host->curr.data = NULL;
-	host->curr.got_dataend = host->curr.got_datablkend = 0;
+	host->curr.got_dataend = 0;
 }
 
 uint32_t msmsdcc_fifo_addr(struct msmsdcc_host *host)
@@ -277,8 +277,7 @@ msmsdcc_dma_complete_tlet(unsigned long data)
 	host->dma.sg = NULL;
 	host->dma.busy = 0;
 
-	if ((host->curr.got_dataend && host->curr.got_datablkend)
-	     || mrq->data->error) {
+	if (host->curr.got_dataend || mrq->data->error) {
 
 		/*
 		 * If we've already gotten our DATAEND / DATABLKEND
@@ -506,7 +505,6 @@ msmsdcc_start_data(struct msmsdcc_host *host, struct mmc_data *data,
 	host->curr.xfer_remain = host->curr.xfer_size;
 	host->curr.data_xfered = 0;
 	host->curr.got_dataend = 0;
-	host->curr.got_datablkend = 0;
 
 	memset(&host->pio, 0, sizeof(host->pio));
 
@@ -827,14 +825,10 @@ msmsdcc_handle_irq_data(struct msmsdcc_host *host, u32 status,
 	if (!host->curr.got_dataend && (status & MCI_DATAEND))
 		host->curr.got_dataend = 1;
 
-	if (!host->curr.got_datablkend && (status & MCI_DATABLOCKEND))
-		host->curr.got_datablkend = 1;
-
 	/*
 	 * If DMA is still in progress, we complete via the completion handler
 	 */
-	if (host->curr.got_dataend && host->curr.got_datablkend &&
-	    !host->dma.busy) {
+	if (host->curr.got_dataend && !host->dma.busy) {
 		/*
 		 * There appears to be an issue in the controller where
 		 * if you request a small block transfer (< fifo size),
@@ -871,8 +865,7 @@ msmsdcc_irq(int irq, void *dev_id)
 
 	do {
 		status = msmsdcc_readl(host, MMCISTATUS);
-		status &= (msmsdcc_readl(host, MMCIMASK0) |
-					      MCI_DATABLOCKENDMASK);
+		status &= msmsdcc_readl(host, MMCIMASK0);
 		msmsdcc_writel(host, status, MMCICLEAR);
 
 		if (status & MCI_SDIOINTR)
diff --git a/drivers/mmc/host/msm_sdcc.h b/drivers/mmc/host/msm_sdcc.h
index ac79ed9..9a14144 100644
--- a/drivers/mmc/host/msm_sdcc.h
+++ b/drivers/mmc/host/msm_sdcc.h
@@ -190,7 +190,6 @@ struct msmsdcc_curr_req {
 	unsigned int		xfer_remain;	/* Bytes remaining to send */
 	unsigned int		data_xfered;	/* Bytes acked by BLKEND irq */
 	int			got_dataend;
-	int			got_datablkend;
 	int			user_pages;
 };
 
-- 
1.7.1

--
Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
