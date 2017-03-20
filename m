From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 19/25] mmc: sdhci: Add CQE support
Date: Mon, 20 Mar 2017 19:50:47 +0200
Message-ID: <1490032253-6030-20-git-send-email-adrian.hunter@intel.com>
References: <1490032253-6030-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:18862 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756320AbdCTR6l (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 20 Mar 2017 13:58:41 -0400
In-Reply-To: <1490032253-6030-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Al Cooper <alcooperx@gmail.com>, Jaedon Shin <jaedon.shin@gmail.com>, Haibo Chen <haibo.chen@nxp.com>, Dong Aisheng <aisheng.dong@nxp.com>, Shawn Lin <shawn.lin@rock-chips.com>, Douglas Anderson <dianders@chromium.org>, Zach Brown <zach.brown@ni.com>, Ludovic Desroches <ludovic.desroches@atmel.com>, Jisheng Zhang <jszhang@marvell.com>, Yangbo Lu <yangbo.lu@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>, Weijun Yang <Weijun.Yang@csr.com>, Barry Song <Baohua.Song@csr.com>, Peter Griffin <peter.griffin@linaro.org>, Lee Jones <lee.jones@linaro.org>, Jon Hunter <jonathanh@nvidia.com>, Harjani Ritesh <riteshh@codeaurora.org>

Add an interrupt hook and helper functions for enabling, disabling and
delivering interrupts to a CQE.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci.c | 130 +++++++++++++++++++++++++++++++++++++++++++++--
 drivers/mmc/host/sdhci.h |  19 +++++++
 2 files changed, 146 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 7f1c0126342f..a33102fc800b 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -252,6 +252,8 @@ static void sdhci_init(struct sdhci_host *host, int soft)
 
 	sdhci_set_default_irqs(host);
 
+	host->cqe_on = false;
+
 	if (soft) {
 		/* force clock reconfiguration */
 		host->clock = 0;
@@ -2666,13 +2668,19 @@ static irqreturn_t sdhci_irq(int irq, void *dev_id)
 	}
 
 	do {
+		DBG("IRQ status 0x%08x\n", intmask);
+
+		if (host->ops->irq) {
+			intmask = host->ops->irq(host, intmask);
+			if (!intmask)
+				goto cont;
+		}
+
 		/* Clear selected interrupts. */
 		mask = intmask & (SDHCI_INT_CMD_MASK | SDHCI_INT_DATA_MASK |
 				  SDHCI_INT_BUS_POWER);
 		sdhci_writel(host, mask, SDHCI_INT_STATUS);
 
-		DBG("IRQ status 0x%08x\n", intmask);
-
 		if (intmask & (SDHCI_INT_CARD_INSERT | SDHCI_INT_CARD_REMOVE)) {
 			u32 present = sdhci_readl(host, SDHCI_PRESENT_STATE) &
 				      SDHCI_CARD_PRESENT;
@@ -2732,7 +2740,7 @@ static irqreturn_t sdhci_irq(int irq, void *dev_id)
 			unexpected |= intmask;
 			sdhci_writel(host, intmask, SDHCI_INT_STATUS);
 		}
-
+cont:
 		if (result == IRQ_NONE)
 			result = IRQ_HANDLED;
 
@@ -2961,6 +2969,119 @@ int sdhci_runtime_resume_host(struct sdhci_host *host)
 
 /*****************************************************************************\
  *                                                                           *
+ * Command Queue Engine (CQE) helpers                                        *
+ *                                                                           *
+\*****************************************************************************/
+
+void sdhci_cqe_enable(struct mmc_host *mmc)
+{
+	struct sdhci_host *host = mmc_priv(mmc);
+	unsigned long flags;
+	u8 ctrl;
+
+	spin_lock_irqsave(&host->lock, flags);
+
+	ctrl = sdhci_readb(host, SDHCI_HOST_CONTROL);
+	ctrl &= ~SDHCI_CTRL_DMA_MASK;
+	if (host->flags & SDHCI_USE_64_BIT_DMA)
+		ctrl |= SDHCI_CTRL_ADMA64;
+	else
+		ctrl |= SDHCI_CTRL_ADMA32;
+	sdhci_writeb(host, ctrl, SDHCI_HOST_CONTROL);
+
+	sdhci_writew(host, SDHCI_MAKE_BLKSZ(SDHCI_DEFAULT_BOUNDARY_ARG, 512),
+		     SDHCI_BLOCK_SIZE);
+
+	/* Set maximum timeout */
+	sdhci_writeb(host, 0xE, SDHCI_TIMEOUT_CONTROL);
+
+	host->ier = host->cqe_ier;
+
+	sdhci_writel(host, host->ier, SDHCI_INT_ENABLE);
+	sdhci_writel(host, host->ier, SDHCI_SIGNAL_ENABLE);
+
+	host->cqe_on = true;
+
+	pr_debug("%s: sdhci: CQE on, IRQ mask %#x, IRQ status %#x\n",
+		 mmc_hostname(mmc), host->ier,
+		 sdhci_readl(host, SDHCI_INT_STATUS));
+
+	mmiowb();
+	spin_unlock_irqrestore(&host->lock, flags);
+}
+EXPORT_SYMBOL_GPL(sdhci_cqe_enable);
+
+void sdhci_cqe_disable(struct mmc_host *mmc, bool recovery)
+{
+	struct sdhci_host *host = mmc_priv(mmc);
+	unsigned long flags;
+
+	spin_lock_irqsave(&host->lock, flags);
+
+	sdhci_set_default_irqs(host);
+
+	host->cqe_on = false;
+
+	if (recovery) {
+		sdhci_do_reset(host, SDHCI_RESET_CMD);
+		sdhci_do_reset(host, SDHCI_RESET_DATA);
+	}
+
+	pr_debug("%s: sdhci: CQE off, IRQ mask %#x, IRQ status %#x\n",
+		 mmc_hostname(mmc), host->ier,
+		 sdhci_readl(host, SDHCI_INT_STATUS));
+
+	mmiowb();
+	spin_unlock_irqrestore(&host->lock, flags);
+}
+EXPORT_SYMBOL_GPL(sdhci_cqe_disable);
+
+bool sdhci_cqe_irq(struct sdhci_host *host, u32 intmask, int *cmd_error,
+		   int *data_error)
+{
+	u32 mask;
+
+	if (!host->cqe_on)
+		return false;
+
+	if (intmask & (SDHCI_INT_INDEX | SDHCI_INT_END_BIT | SDHCI_INT_CRC))
+		*cmd_error = -EILSEQ;
+	else if (intmask & SDHCI_INT_TIMEOUT)
+		*cmd_error = -ETIMEDOUT;
+	else
+		*cmd_error = 0;
+
+	if (intmask & (SDHCI_INT_DATA_END_BIT | SDHCI_INT_DATA_CRC))
+		*data_error = -EILSEQ;
+	else if (intmask & SDHCI_INT_DATA_TIMEOUT)
+		*data_error = -ETIMEDOUT;
+	else if (intmask & SDHCI_INT_ADMA_ERROR)
+		*data_error = -EIO;
+	else
+		*data_error = 0;
+
+	/* Clear selected interrupts. */
+	mask = intmask & host->cqe_ier;
+	sdhci_writel(host, mask, SDHCI_INT_STATUS);
+
+	if (intmask & SDHCI_INT_BUS_POWER)
+		pr_err("%s: Card is consuming too much power!\n",
+		       mmc_hostname(host->mmc));
+
+	intmask &= ~(host->cqe_ier | SDHCI_INT_ERROR);
+	if (intmask) {
+		sdhci_writel(host, intmask, SDHCI_INT_STATUS);
+		pr_err("%s: CQE: Unexpected interrupt 0x%08x.\n",
+		       mmc_hostname(host->mmc), intmask);
+		sdhci_dumpregs(host);
+	}
+
+	return true;
+}
+EXPORT_SYMBOL_GPL(sdhci_cqe_irq);
+
+/*****************************************************************************\
+ *                                                                           *
  * Device allocation/registration                                            *
  *                                                                           *
 \*****************************************************************************/
@@ -2984,6 +3105,9 @@ struct sdhci_host *sdhci_alloc_host(struct device *dev,
 
 	host->flags = SDHCI_SIGNALING_330;
 
+	host->cqe_ier     = SDHCI_CQE_INT_MASK;
+	host->cqe_err_ier = SDHCI_CQE_INT_ERR_MASK;
+
 	return host;
 }
 
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 477b3f5bedfd..35b41da0a636 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -134,6 +134,7 @@
 #define  SDHCI_INT_CARD_REMOVE	0x00000080
 #define  SDHCI_INT_CARD_INT	0x00000100
 #define  SDHCI_INT_RETUNE	0x00001000
+#define  SDHCI_INT_CQE		0x00004000
 #define  SDHCI_INT_ERROR	0x00008000
 #define  SDHCI_INT_TIMEOUT	0x00010000
 #define  SDHCI_INT_CRC		0x00020000
@@ -158,6 +159,13 @@
 		SDHCI_INT_BLK_GAP)
 #define SDHCI_INT_ALL_MASK	((unsigned int)-1)
 
+#define SDHCI_CQE_INT_ERR_MASK ( \
+	SDHCI_INT_ADMA_ERROR | SDHCI_INT_BUS_POWER | SDHCI_INT_DATA_END_BIT | \
+	SDHCI_INT_DATA_CRC | SDHCI_INT_DATA_TIMEOUT | SDHCI_INT_INDEX | \
+	SDHCI_INT_END_BIT | SDHCI_INT_CRC | SDHCI_INT_TIMEOUT)
+
+#define SDHCI_CQE_INT_MASK (SDHCI_CQE_INT_ERR_MASK | SDHCI_INT_CQE)
+
 #define SDHCI_ACMD12_ERR	0x3C
 
 #define SDHCI_HOST_CONTROL2		0x3E
@@ -518,6 +526,10 @@ struct sdhci_host {
 	/* cached registers */
 	u32			ier;
 
+	bool			cqe_on;		/* CQE is operating */
+	u32			cqe_ier;	/* CQE interrupt mask */
+	u32			cqe_err_ier;	/* CQE error interrupt mask */
+
 	wait_queue_head_t	buf_ready_int;	/* Waitqueue for Buffer Read Ready interrupt */
 	unsigned int		tuning_done;	/* Condition flag set when CMD19 succeeds */
 
@@ -544,6 +556,8 @@ struct sdhci_ops {
 	void	(*set_power)(struct sdhci_host *host, unsigned char mode,
 			     unsigned short vdd);
 
+	u32		(*irq)(struct sdhci_host *host, u32 intmask);
+
 	int		(*enable_dma)(struct sdhci_host *host);
 	unsigned int	(*get_max_clock)(struct sdhci_host *host);
 	unsigned int	(*get_min_clock)(struct sdhci_host *host);
@@ -697,6 +711,11 @@ void sdhci_set_power_noreg(struct sdhci_host *host, unsigned char mode,
 int sdhci_runtime_resume_host(struct sdhci_host *host);
 #endif
 
+void sdhci_cqe_enable(struct mmc_host *mmc);
+void sdhci_cqe_disable(struct mmc_host *mmc, bool recovery);
+bool sdhci_cqe_irq(struct sdhci_host *host, u32 intmask, int *cmd_error,
+		   int *data_error);
+
 void sdhci_dumpregs(struct sdhci_host *host);
 
 #endif /* __SDHCI_HW_H */
-- 
1.9.1

