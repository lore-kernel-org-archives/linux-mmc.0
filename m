From: Sahitya Tummala <stummala@codeaurora.org>
Subject: [PATCH V2 5/7] mmc: msm_sdcc: Use MCI_INT_MASK0 for PIO interrupts
Date: Mon,  2 May 2011 18:09:18 +0530
Message-ID: <1304339958-8657-1-git-send-email-stummala@codeaurora.org>
References: <1303796066-6784-5-git-send-email-stummala@codeaurora.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1303796066-6784-5-git-send-email-stummala@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: davidb@codeaurora.org, bryanh@codeaurora.org, dwalker@fifo99.com
Cc: linux-mmc@vger.kernel.org, linux-arm-msm@vger.kernel.org, san@google.com, sboyd@codeaurora.org, Sahitya Tummala <stummala@codeaurora.org>, Murali Palnati <palnatim@codeaurora.org>
List-Id: linux-mmc@vger.kernel.org

Not all targets have IRQ1 line routed from the SD controller to
the processor. So we cannot rely on IRQ1 for PIO interrupts.
This patch moves all PIO interrupts to IRQ0 and enables the PIO
mode.

Signed-off-by: Murali Palnati <palnatim@codeaurora.org>
Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>
---
 drivers/mmc/host/msm_sdcc.c |   20 ++++++++++++++++----
 drivers/mmc/host/msm_sdcc.h |    5 +++++
 2 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/msm_sdcc.c b/drivers/mmc/host/msm_sdcc.c
index be45b6a..908524b 100644
--- a/drivers/mmc/host/msm_sdcc.c
+++ b/drivers/mmc/host/msm_sdcc.c
@@ -213,7 +213,8 @@ msmsdcc_dma_exec_func(struct msm_dmov_cmd *cmd)
 	msmsdcc_writel(host, host->cmd_timeout, MMCIDATATIMER);
 	msmsdcc_writel(host, (unsigned int)host->curr.xfer_size,
 		       MMCIDATALENGTH);
-	msmsdcc_writel(host, host->cmd_pio_irqmask, MMCIMASK1);
+	msmsdcc_writel(host, (msmsdcc_readl(host, MMCIMASK0) &
+			(~MCI_IRQ_PIO)) | host->cmd_pio_irqmask, MMCIMASK0);
 	msmsdcc_writel(host, host->cmd_datactrl, MMCIDATACTRL);
 
 	if (host->cmd_cmd) {
@@ -543,7 +544,9 @@ msmsdcc_start_data(struct msmsdcc_host *host, struct mmc_data *data,
 
 		msmsdcc_writel(host, host->curr.xfer_size, MMCIDATALENGTH);
 
-		msmsdcc_writel(host, pio_irqmask, MMCIMASK1);
+		msmsdcc_writel(host, (msmsdcc_readl(host, MMCIMASK0) &
+				(~MCI_IRQ_PIO)) | pio_irqmask, MMCIMASK0);
+
 		msmsdcc_writel(host, datactrl, MMCIDATACTRL);
 
 		if (cmd) {
@@ -659,8 +662,13 @@ msmsdcc_pio_irq(int irq, void *dev_id)
 {
 	struct msmsdcc_host	*host = dev_id;
 	uint32_t		status;
+	u32 mci_mask0;
 
 	status = msmsdcc_readl(host, MMCISTATUS);
+	mci_mask0 = msmsdcc_readl(host, MMCIMASK0);
+
+	if (((mci_mask0 & status) & MCI_IRQ_PIO) == 0)
+		return IRQ_NONE;
 
 	do {
 		unsigned long flags;
@@ -719,10 +727,12 @@ msmsdcc_pio_irq(int irq, void *dev_id)
 	} while (1);
 
 	if (status & MCI_RXACTIVE && host->curr.xfer_remain < MCI_FIFOSIZE)
-		msmsdcc_writel(host, MCI_RXDATAAVLBLMASK, MMCIMASK1);
+		msmsdcc_writel(host, (mci_mask0 & (~MCI_IRQ_PIO)) |
+					MCI_RXDATAAVLBLMASK, MMCIMASK0);
 
 	if (!host->curr.xfer_remain)
-		msmsdcc_writel(host, 0, MMCIMASK1);
+		msmsdcc_writel(host, (mci_mask0 & (~MCI_IRQ_PIO)) | 0,
+					MMCIMASK0);
 
 	return IRQ_HANDLED;
 }
@@ -854,6 +864,8 @@ msmsdcc_irq(int irq, void *dev_id)
 	do {
 		status = msmsdcc_readl(host, MMCISTATUS);
 		status &= msmsdcc_readl(host, MMCIMASK0);
+		if ((status & (~MCI_IRQ_PIO)) == 0)
+			break;
 		msmsdcc_writel(host, status, MMCICLEAR);
 
 		if (status & MCI_SDIOINTR)
diff --git a/drivers/mmc/host/msm_sdcc.h b/drivers/mmc/host/msm_sdcc.h
index fa626ed..402028d 100644
--- a/drivers/mmc/host/msm_sdcc.h
+++ b/drivers/mmc/host/msm_sdcc.h
@@ -140,6 +140,11 @@
 	MCI_DATATIMEOUTMASK|MCI_TXUNDERRUNMASK|MCI_RXOVERRUNMASK|	\
 	MCI_CMDRESPENDMASK|MCI_CMDSENTMASK|MCI_DATAENDMASK|MCI_PROGDONEMASK)
 
+#define MCI_IRQ_PIO \
+	(MCI_RXDATAAVLBLMASK | MCI_TXDATAAVLBLMASK | MCI_RXFIFOEMPTYMASK | \
+	 MCI_TXFIFOEMPTYMASK | MCI_RXFIFOFULLMASK | MCI_TXFIFOFULLMASK | \
+	 MCI_RXFIFOHALFFULLMASK | MCI_TXFIFOHALFEMPTYMASK | \
+	 MCI_RXACTIVEMASK | MCI_TXACTIVEMASK)
 /*
  * The size of the FIFO in bytes.
  */
-- 
1.7.1

--
Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
