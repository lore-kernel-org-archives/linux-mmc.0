From: Asutosh Das <asutoshd@codeaurora.org>
Subject: [PATCH 5/5] mmc: sdhci: add command queue support to sdhci
Date: Tue, 2 Dec 2014 17:32:41 +0530
Message-ID: <20141202120241.GA27704@asutoshd-ics.in.qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-arm-msm-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-arm-msm@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Adds command-queue support to SDHCi compliant drivers.

Signed-off-by: Asutosh Das <asutoshd@codeaurora.org>
Signed-off-by: Konstantin Dorfman <kdorfman@codeaurora.org>
---
 drivers/mmc/host/sdhci.c  | 89 +++++++++++++++++++++++++++++++++++++++++++++++
 drivers/mmc/host/sdhci.h  |  2 ++
 include/linux/mmc/sdhci.h |  1 +
 3 files changed, 92 insertions(+)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 9a79fc4..66d537e 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -25,6 +25,7 @@
 
 #include <linux/leds.h>
 
+#include <linux/mmc/cmdq_hci.h>
 #include <linux/mmc/mmc.h>
 #include <linux/mmc/host.h>
 #include <linux/mmc/card.h>
@@ -2422,6 +2423,20 @@ static void sdhci_data_irq(struct sdhci_host *host, u32 intmask)
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
 	irqreturn_t result;
@@ -2443,6 +2458,12 @@ static irqreturn_t sdhci_irq(int irq, void *dev_id)
 		goto out;
 	}
 
+	if (host->mmc->card && mmc_card_cmdq(host->mmc->card)) {
+		pr_debug("*** %s: cmdq intr: 0x%08x\n", mmc_hostname(host->mmc),
+			 intmask);
+		result = sdhci_cmdq_irq(host->mmc, intmask);
+		goto out;
+	}
 again:
 	DBG("*** %s got interrupt: 0x%08x\n",
 		mmc_hostname(host->mmc), intmask);
@@ -2769,6 +2790,64 @@ struct sdhci_host *sdhci_alloc_host(struct device *dev,
 
 EXPORT_SYMBOL_GPL(sdhci_alloc_host);
 
+#ifdef CONFIG_MMC_CQ_HCI
+static void sdhci_cmdq_clear_set_irqs(struct mmc_host *mmc, u32 clear, u32 set)
+{
+	struct sdhci_host *host = mmc_priv(mmc);
+
+	sdhci_clear_set_irqs(host, SDHCI_INT_ALL_MASK,
+			     SDHCI_INT_CMDQ_EN | SDHCI_INT_ERROR_MASK);
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
+#else
+static void sdhci_cmdq_clear_set_irqs(struct mmc_host *mmc, u32 clear, u32 set)
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
+#endif
+
+static const struct cmdq_host_ops sdhci_cmdq_ops = {
+	.clear_set_irqs = sdhci_cmdq_clear_set_irqs,
+	.set_data_timeout = sdhci_cmdq_set_data_timeout,
+	.dump_vendor_regs = sdhci_cmdq_dump_vendor_regs,
+};
+
 int sdhci_add_host(struct sdhci_host *host)
 {
 	struct mmc_host *mmc;
@@ -3259,6 +3338,16 @@ int sdhci_add_host(struct sdhci_host *host)
 #endif
 
 	mmiowb();
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
 
 	mmc_add_host(mmc);
 
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 0a3ed01..c1a9fa8 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -149,6 +149,8 @@
 		SDHCI_INT_DATA_TIMEOUT | SDHCI_INT_DATA_CRC | \
 		SDHCI_INT_DATA_END_BIT | SDHCI_INT_ADMA_ERROR | \
 		SDHCI_INT_BLK_GAP)
+
+#define SDHCI_INT_CMDQ_EN	(0x1 << 14)
 #define SDHCI_INT_ALL_MASK	((unsigned int)-1)
 
 #define SDHCI_ACMD12_ERR	0x3C
diff --git a/include/linux/mmc/sdhci.h b/include/linux/mmc/sdhci.h
index 7be12b8..dd9fe0d 100644
--- a/include/linux/mmc/sdhci.h
+++ b/include/linux/mmc/sdhci.h
@@ -184,6 +184,7 @@ struct sdhci_host {
 	unsigned int		tuning_mode;	/* Re-tuning mode supported by host */
 #define SDHCI_TUNING_MODE_1	0
 	struct timer_list	tuning_timer;	/* Timer for tuning */
+	struct cmdq_host *cq_host;
 
 	unsigned long private[0] ____cacheline_aligned;
 };
-- 
1.8.2.1

The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
