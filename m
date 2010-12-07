From: Sahitya Tummala <stummala@codeaurora.org>
Subject: [PATCH 1/5] mmc: msm_sdcc: Fix possible circular locking dependency warning
Date: Tue,  7 Dec 2010 16:25:12 +0530
Message-ID: <1291719316-23948-1-git-send-email-stummala@codeaurora.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from wolverine01.qualcomm.com ([199.106.114.254]:37145 "EHLO
	wolverine01.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751856Ab0LGKzs (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 7 Dec 2010 05:55:48 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: cjb@laptop.org, linux-mmc@vger.kernel.org
Cc: san@google.com, linux-arm-msm@vger.kernel.org, Sahitya Tummala <stummala@codeaurora.org>

In the context of request processing thread, data mover lock is
acquired after the host lock.  In another context, in the completion
handler of data mover the locks are acquired in the reverse order,
resulting in possible circular lock dependency warning. Hence,
schedule a tasklet to process the dma completion so as to avoid
nested locks.

Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>
---
 drivers/mmc/host/msm_sdcc.c |   49 +++++++++++++++++++++++++++++--------------
 drivers/mmc/host/msm_sdcc.h |    3 ++
 2 files changed, 36 insertions(+), 16 deletions(-)

diff --git a/drivers/mmc/host/msm_sdcc.c b/drivers/mmc/host/msm_sdcc.c
index 1290d14..b147971 100644
--- a/drivers/mmc/host/msm_sdcc.c
+++ b/drivers/mmc/host/msm_sdcc.c
@@ -189,42 +189,40 @@ msmsdcc_dma_exec_func(struct msm_dmov_cmd *cmd)
 }
 
 static void
-msmsdcc_dma_complete_func(struct msm_dmov_cmd *cmd,
-			  unsigned int result,
-			  struct msm_dmov_errdata *err)
+msmsdcc_dma_complete_tlet(unsigned long data)
 {
-	struct msmsdcc_dma_data	*dma_data =
-		container_of(cmd, struct msmsdcc_dma_data, hdr);
-	struct msmsdcc_host	*host = dma_data->host;
+	struct msmsdcc_host *host = (struct msmsdcc_host *)data;
 	unsigned long		flags;
 	struct mmc_request	*mrq;
+	struct msm_dmov_errdata err;
 
 	spin_lock_irqsave(&host->lock, flags);
 	host->dma.active = 0;
 
+	err = host->dma.err;
 	mrq = host->curr.mrq;
 	BUG_ON(!mrq);
 	WARN_ON(!mrq->data);
 
-	if (!(result & DMOV_RSLT_VALID)) {
+	if (!(host->dma.result & DMOV_RSLT_VALID)) {
 		pr_err("msmsdcc: Invalid DataMover result\n");
 		goto out;
 	}
 
-	if (result & DMOV_RSLT_DONE) {
+	if (host->dma.result & DMOV_RSLT_DONE) {
 		host->curr.data_xfered = host->curr.xfer_size;
 	} else {
 		/* Error or flush  */
-		if (result & DMOV_RSLT_ERROR)
+		if (host->dma.result & DMOV_RSLT_ERROR)
 			pr_err("%s: DMA error (0x%.8x)\n",
-			       mmc_hostname(host->mmc), result);
-		if (result & DMOV_RSLT_FLUSH)
+			       mmc_hostname(host->mmc), host->dma.result);
+		if (host->dma.result & DMOV_RSLT_FLUSH)
 			pr_err("%s: DMA channel flushed (0x%.8x)\n",
-			       mmc_hostname(host->mmc), result);
-		if (err)
-			pr_err("Flush data: %.8x %.8x %.8x %.8x %.8x %.8x\n",
-			       err->flush[0], err->flush[1], err->flush[2],
-			       err->flush[3], err->flush[4], err->flush[5]);
+			       mmc_hostname(host->mmc), host->dma.result);
+
+		pr_err("Flush data: %.8x %.8x %.8x %.8x %.8x %.8x\n",
+		       err.flush[0], err.flush[1], err.flush[2],
+		       err.flush[3], err.flush[4], err.flush[5]);
 		if (!mrq->data->error)
 			mrq->data->error = -EIO;
 	}
@@ -273,6 +271,22 @@ out:
 	return;
 }
 
+static void
+msmsdcc_dma_complete_func(struct msm_dmov_cmd *cmd,
+			  unsigned int result,
+			  struct msm_dmov_errdata *err)
+{
+	struct msmsdcc_dma_data	*dma_data =
+		container_of(cmd, struct msmsdcc_dma_data, hdr);
+	struct msmsdcc_host *host = dma_data->host;
+
+	dma_data->result = result;
+	if (err)
+		memcpy(&dma_data->err, err, sizeof(struct msm_dmov_errdata));
+
+	tasklet_schedule(&host->dma_tlet);
+}
+
 static int validate_dma(struct msmsdcc_host *host, struct mmc_data *data)
 {
 	if (host->dma.channel == -1)
@@ -1118,6 +1132,9 @@ msmsdcc_probe(struct platform_device *pdev)
 	host->dmares = dmares;
 	spin_lock_init(&host->lock);
 
+	tasklet_init(&host->dma_tlet, msmsdcc_dma_complete_tlet,
+			(unsigned long)host);
+
 	/*
 	 * Setup DMA
 	 */
diff --git a/drivers/mmc/host/msm_sdcc.h b/drivers/mmc/host/msm_sdcc.h
index ff2b0f7..996990d 100644
--- a/drivers/mmc/host/msm_sdcc.h
+++ b/drivers/mmc/host/msm_sdcc.h
@@ -172,6 +172,8 @@ struct msmsdcc_dma_data {
 	struct msmsdcc_host		*host;
 	int				busy; /* Set if DM is busy */
 	int				active;
+	unsigned int			result;
+	struct msm_dmov_errdata		err;
 };
 
 struct msmsdcc_pio_data {
@@ -235,6 +237,7 @@ struct msmsdcc_host {
 	int			cmdpoll;
 	struct msmsdcc_stats	stats;
 
+	struct tasklet_struct	dma_tlet;
 	/* Command parameters */
 	unsigned int		cmd_timeout;
 	unsigned int		cmd_pio_irqmask;
-- 
1.7.1

--
Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
