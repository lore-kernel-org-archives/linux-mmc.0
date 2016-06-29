From: Ritesh Harjani <riteshh@codeaurora.org>
Subject: [PATCH RFC 7/8] mmc: sdhci-msm: Add check_power_status to sdhci-msm
Date: Wed, 29 Jun 2016 16:50:32 +0530
Message-ID: <1467199233-20506-8-git-send-email-riteshh@codeaurora.org>
References: <1467199233-20506-1-git-send-email-riteshh@codeaurora.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1467199233-20506-1-git-send-email-riteshh@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: ulf.hansson@linaro.org, linux-mmc@vger.kernel.org
Cc: linux-arm-msm@vger.kernel.org, adrian.hunter@intel.com, asutoshd@codeaurora.org, kdorfman@codeaurora.org, david.griego@linaro.org, stummala@codeaurora.org, venkatg@codeaurora.org, Ritesh Harjani <riteshh@codeaurora.org>
List-Id: linux-mmc@vger.kernel.org

This adds handler to check whether pwr_irq has
completed or not by adding sdhci_msm_check_power_status.

Signed-off-by: Ritesh Harjani <riteshh@codeaurora.org>
---
 drivers/mmc/host/sdhci-msm.c | 57 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
index 8badcf8..912ca6e 100644
--- a/drivers/mmc/host/sdhci-msm.c
+++ b/drivers/mmc/host/sdhci-msm.c
@@ -129,6 +129,8 @@ struct sdhci_msm_host {
 	int pwr_irq;
 	u32 curr_pwr_state;
 	u32 curr_io_level;
+	struct completion pwr_irq_completion;
+	spinlock_t pwr_irq_lock;
 };
 
 #define MAX_PROP_SIZE 32
@@ -595,14 +597,62 @@ static irqreturn_t sdhci_msm_pwr_irq(int irq, void *data)
 
 	pr_debug("%s: Handled IRQ(%d), ret=%d, ack=0x%x\n",
 		mmc_hostname(msm_host->mmc), irq, ret, irq_ack);
+	spin_lock_irqsave(&msm_host->pwr_irq_lock, flags);
 	if (pwr_state)
 		msm_host->curr_pwr_state = pwr_state;
 	if (io_level)
 		msm_host->curr_io_level = io_level;
+	complete(&msm_host->pwr_irq_completion);
+	spin_unlock_irqrestore(&msm_host->pwr_irq_lock, flags);
 
 	return IRQ_HANDLED;
 }
 
+static void sdhci_msm_check_power_status(struct sdhci_host *host, u32 req_type)
+{
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct sdhci_msm_host *msm_host = sdhci_pltfm_priv(pltfm_host);
+	unsigned long flags;
+	bool locked = false;
+	bool done = false;
+
+	pr_debug("%s: %s: power status before waiting 0x%x\n",
+		mmc_hostname(host->mmc), __func__,
+		readb_relaxed(msm_host->core_mem + CORE_PWRCTL_CTL));
+
+	if (spin_is_locked(&host->lock))
+		locked = true;
+
+	spin_lock_irqsave(&msm_host->pwr_irq_lock, flags);
+	pr_debug("%s: %s: request %d curr_pwr_state %x curr_io_level %x\n",
+			mmc_hostname(host->mmc), __func__, req_type,
+			msm_host->curr_pwr_state, msm_host->curr_io_level);
+	if ((req_type & msm_host->curr_pwr_state) ||
+			(req_type & msm_host->curr_io_level))
+		done = true;
+	spin_unlock_irqrestore(&msm_host->pwr_irq_lock, flags);
+
+	if (locked)
+		spin_unlock_irq(&host->lock);
+	/*
+	 * This is needed here to hanlde a case where IRQ gets
+	 * triggered even before this function is called so that
+	 * x->done counter of completion gets reset. Otherwise,
+	 * next call to wait_for_completion returns immediately
+	 * without actually waiting for the IRQ to be handled.
+	 */
+	if (done)
+		init_completion(&msm_host->pwr_irq_completion);
+	else
+		wait_for_completion(&msm_host->pwr_irq_completion);
+
+	if (locked)
+		spin_lock_irq(&host->lock);
+
+	pr_debug("%s: %s: request %d done\n", mmc_hostname(host->mmc),
+			__func__, req_type);
+}
+
 /* Platform specific tuning */
 static inline int msm_dll_poll_ck_out_en(struct sdhci_host *host, u8 poll)
 {
@@ -964,6 +1014,7 @@ static const struct sdhci_ops sdhci_msm_ops = {
 	.set_clock = sdhci_set_clock,
 	.set_bus_width = sdhci_set_bus_width,
 	.set_uhs_signaling = sdhci_set_uhs_signaling,
+	.check_power_status = sdhci_msm_check_power_status,
 };
 
 static const struct sdhci_pltfm_data sdhci_msm_pdata = {
@@ -1134,6 +1185,12 @@ static int sdhci_msm_probe(struct platform_device *pdev)
 		goto vreg_deinit;
 	}
 
+	init_completion(&msm_host->pwr_irq_completion);
+	spin_lock_init(&msm_host->pwr_irq_lock);
+
+	/* Enable pwr irq interrupts */
+	writel_relaxed(INT_MASK, (msm_host->core_mem + CORE_PWRCTL_MASK));
+
 	ret = sdhci_add_host(host);
 	if (ret)
 		goto vreg_deinit;
-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, 
a Linux Foundation Collaborative Project.
