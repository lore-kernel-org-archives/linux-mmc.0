From: Ritesh Harjani <riteshh@codeaurora.org>
Subject: [PATCH RFC 10/10] mmc: sdhci: add command queue support to sdhci
Date: Wed, 15 Jun 2016 18:31:14 +0530
Message-ID: <1465995674-15816-11-git-send-email-riteshh@codeaurora.org>
References: <1465995674-15816-1-git-send-email-riteshh@codeaurora.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:43813 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753154AbcFONDR (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 15 Jun 2016 09:03:17 -0400
In-Reply-To: <1465995674-15816-1-git-send-email-riteshh@codeaurora.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org, linux-mmc@vger.kernel.org
Cc: adrian.hunter@intel.com, alex.lemberg@sandisk.com, mateusz.nowak@intel.com, Yuliy.Izrailov@sandisk.com, jh80.chung@samsung.com, dongas86@gmail.com, asutoshd@codeaurora.org, zhangfei.gao@gmail.com, sthumma@codeaurora.org, kdorfman@codeaurora.org, david.griego@linaro.org, stummala@codeaurora.org, venkatg@codeaurora.org, Subhash Jadavani <subhashj@codeaurora.org>, Ritesh Harjani <riteshh@codeaurora.org>

From: Asutosh Das <asutoshd@codeaurora.org>

Adds command-queue support to SDHCi compliant drivers.

Signed-off-by: Asutosh Das <asutoshd@codeaurora.org>
Signed-off-by: Konstantin Dorfman <kdorfman@codeaurora.org>
Signed-off-by: Venkat Gopalakrishnan <venkatg@codeaurora.org>
[subhashj@codeaurora.org: fixed trivial merge conflicts and
compilation error]
Signed-off-by: Subhash Jadavani <subhashj@codeaurora.org>
[riteshh@codeaurora.org: fixed merge conflicts]
Signed-off-by: Ritesh Harjani <riteshh@codeaurora.org>
---
 drivers/mmc/host/sdhci.c | 146 +++++++++++++++++++++++++++++++++++++++++++++--
 drivers/mmc/host/sdhci.h |   6 ++
 2 files changed, 148 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index ca38018..7ca5520 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -32,6 +32,7 @@
 #include <linux/mmc/slot-gpio.h>
 
 #include "sdhci.h"
+#include "cmdq_hci.h"
 
 #define DRIVER_NAME "sdhci"
 
@@ -2486,6 +2487,20 @@ static void sdhci_data_irq(struct sdhci_host *host, u32 intmask)
 	}
 }
 
+#ifdef CONFIG_MMC_CQ_HCI
+static irqreturn_t sdhci_cmdq_irq(struct mmc_host *mmc, u32 intmask)
+{
+	return cmdq_irq(mmc, intmask);
+}
+
+#else
+static irqreturn_t sdhci_cmdq_irq(struct mmc_host *mmc, u32 intmask)
+{
+	pr_err("%s: rxd cmdq-irq when disabled !!!!\n", mmc_hostname(mmc));
+	return IRQ_NONE;
+}
+#endif
+
 static irqreturn_t sdhci_irq(int irq, void *dev_id)
 {
 	irqreturn_t result = IRQ_NONE;
@@ -2507,6 +2522,15 @@ static irqreturn_t sdhci_irq(int irq, void *dev_id)
 	}
 
 	do {
+		if (host->mmc->card && mmc_card_cmdq(host->mmc->card) &&
+		    !mmc_host_halt(host->mmc)) {
+			pr_debug("*** %s: cmdq intr: 0x%08x\n",
+					mmc_hostname(host->mmc),
+					intmask);
+			result = sdhci_cmdq_irq(host->mmc, intmask);
+			goto out;
+		}
+
 		/* Clear selected interrupts. */
 		mask = intmask & (SDHCI_INT_CMD_MASK | SDHCI_INT_DATA_MASK |
 				  SDHCI_INT_BUS_POWER);
@@ -2862,6 +2886,106 @@ static int sdhci_set_dma_mask(struct sdhci_host *host)
 	return ret;
 }
 
+#ifdef CONFIG_MMC_CQ_HCI
+static void sdhci_cmdq_clear_set_irqs(struct mmc_host *mmc, bool clear)
+{
+	struct sdhci_host *host = mmc_priv(mmc);
+	u32 ier = 0;
+
+	ier &= ~SDHCI_INT_ALL_MASK;
+
+	if (clear) {
+		ier = SDHCI_INT_CMDQ_EN | SDHCI_INT_ERROR_MASK;
+		sdhci_writel(host, ier, SDHCI_INT_ENABLE);
+		sdhci_writel(host, ier, SDHCI_SIGNAL_ENABLE);
+	} else {
+		ier = SDHCI_INT_BUS_POWER | SDHCI_INT_DATA_END_BIT |
+			     SDHCI_INT_DATA_CRC | SDHCI_INT_DATA_TIMEOUT |
+			     SDHCI_INT_INDEX | SDHCI_INT_END_BIT |
+			     SDHCI_INT_CRC | SDHCI_INT_TIMEOUT |
+			     SDHCI_INT_DATA_END | SDHCI_INT_RESPONSE |
+			     SDHCI_INT_ACMD12ERR;
+		sdhci_writel(host, ier, SDHCI_INT_ENABLE);
+		sdhci_writel(host, ier, SDHCI_SIGNAL_ENABLE);
+	}
+}
+
+static void sdhci_cmdq_set_data_timeout(struct mmc_host *mmc, u32 val)
+{
+	struct sdhci_host *host = mmc_priv(mmc);
+
+	sdhci_writeb(host, val, SDHCI_TIMEOUT_CONTROL);
+}
+
+static void sdhci_cmdq_dump_vendor_regs(struct mmc_host *mmc)
+{
+	struct sdhci_host *host = mmc_priv(mmc);
+
+	sdhci_dumpregs(host);
+}
+
+static int sdhci_cmdq_init(struct sdhci_host *host, struct mmc_host *mmc,
+			   bool dma64)
+{
+	return cmdq_init(host->cq_host, mmc, dma64);
+}
+
+static void sdhci_cmdq_set_block_size(struct mmc_host *mmc)
+{
+	struct sdhci_host *host = mmc_priv(mmc);
+
+	sdhci_set_blk_size_reg(host, 512, 0);
+}
+
+static void sdhci_cmdq_clear_set_dumpregs(struct mmc_host *mmc, bool set)
+{
+	struct sdhci_host *host = mmc_priv(mmc);
+
+	if (host->ops->clear_set_dumpregs)
+		host->ops->clear_set_dumpregs(host, set);
+}
+#else
+static void sdhci_cmdq_clear_set_irqs(struct mmc_host *mmc, bool clear)
+{
+
+}
+
+static void sdhci_cmdq_set_data_timeout(struct mmc_host *mmc, u32 val)
+{
+
+}
+
+static void sdhci_cmdq_dump_vendor_regs(struct mmc_host *mmc)
+{
+
+}
+
+static int sdhci_cmdq_init(struct sdhci_host *host, struct mmc_host *mmc,
+			   bool dma64)
+{
+	return -ENOSYS;
+}
+
+static void sdhci_cmdq_set_block_size(struct mmc_host *mmc)
+{
+
+}
+
+static void sdhci_cmdq_clear_set_dumpregs(struct mmc_host *mmc, bool set)
+{
+
+}
+
+#endif
+
+static const struct cmdq_host_ops sdhci_cmdq_ops = {
+	.clear_set_irqs = sdhci_cmdq_clear_set_irqs,
+	.set_data_timeout = sdhci_cmdq_set_data_timeout,
+	.dump_vendor_regs = sdhci_cmdq_dump_vendor_regs,
+	.set_block_size = sdhci_cmdq_set_block_size,
+	.clear_set_dumpregs = sdhci_cmdq_clear_set_dumpregs,
+};
+
 int sdhci_add_host(struct sdhci_host *host)
 {
 	struct mmc_host *mmc;
@@ -3387,11 +3511,25 @@ int sdhci_add_host(struct sdhci_host *host)
 
 	mmc_add_host(mmc);
 
-	pr_info("%s: SDHCI controller on %s [%s] using %s\n",
-		mmc_hostname(mmc), host->hw_name, dev_name(mmc_dev(mmc)),
+	if (mmc->caps2 &  MMC_CAP2_CMD_QUEUE) {
+		bool dma64 = (host->flags & SDHCI_USE_ADMA_64BIT) ?
+			true : false;
+		ret = sdhci_cmdq_init(host, mmc, dma64);
+		if (ret)
+			pr_err("%s: CMDQ init: failed (%d)\n",
+			       mmc_hostname(host->mmc), ret);
+		else
+			host->cq_host->ops = &sdhci_cmdq_ops;
+	}
+
+	pr_info("%s: SDHCI controller on %s [%s] using %s in %s mode\n",
+	mmc_hostname(mmc), host->hw_name, dev_name(mmc_dev(mmc)),
 		(host->flags & SDHCI_USE_ADMA) ?
-		(host->flags & SDHCI_USE_64_BIT_DMA) ? "ADMA 64-bit" : "ADMA" :
-		(host->flags & SDHCI_USE_SDMA) ? "DMA" : "PIO");
+		((host->flags & SDHCI_USE_ADMA_64BIT) ?
+		"64-bit ADMA" : "32-bit ADMA") :
+		((host->flags & SDHCI_USE_SDMA) ? "DMA" : "PIO"),
+		((mmc->caps2 &  MMC_CAP2_CMD_QUEUE) && !ret) ?
+		"CMDQ" : "legacy");
 
 	sdhci_enable_card_detection(host);
 
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 0f39f4f..3a21a41 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -150,6 +150,8 @@
 		SDHCI_INT_DATA_TIMEOUT | SDHCI_INT_DATA_CRC | \
 		SDHCI_INT_DATA_END_BIT | SDHCI_INT_ADMA_ERROR | \
 		SDHCI_INT_BLK_GAP)
+
+#define SDHCI_INT_CMDQ_EN	(0x1 << 14)
 #define SDHCI_INT_ALL_MASK	((unsigned int)-1)
 
 #define SDHCI_ACMD12_ERR	0x3C
@@ -452,6 +454,7 @@ struct sdhci_host {
 #define SDHCI_SDIO_IRQ_ENABLED	(1<<9)	/* SDIO irq enabled */
 #define SDHCI_SDR104_NEEDS_TUNING (1<<10)	/* SDR104/HS200 needs tuning */
 #define SDHCI_USE_64_BIT_DMA	(1<<12)	/* Use 64-bit DMA */
+#define SDHCI_USE_ADMA_64BIT	(1<<12)	/* Host is 64-bit ADMA capable */
 #define SDHCI_HS400_TUNING	(1<<13)	/* Tuning for HS400 */
 
 	unsigned int version;	/* SDHCI spec. version */
@@ -515,6 +518,8 @@ struct sdhci_host {
 	unsigned int		tuning_mode;	/* Re-tuning mode supported by host */
 #define SDHCI_TUNING_MODE_1	0
 
+	struct cmdq_host *cq_host;
+
 	unsigned long private[0] ____cacheline_aligned;
 };
 
@@ -550,6 +555,7 @@ struct sdhci_ops {
 	void    (*adma_workaround)(struct sdhci_host *host, u32 intmask);
 	void	(*platform_init)(struct sdhci_host *host);
 	void    (*card_event)(struct sdhci_host *host);
+	void	(*clear_set_dumpregs)(struct sdhci_host *host, bool set);
 	void	(*voltage_switch)(struct sdhci_host *host);
 	int	(*select_drive_strength)(struct sdhci_host *host,
 					 struct mmc_card *card,
-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, 
a Linux Foundation Collaborative Project.

