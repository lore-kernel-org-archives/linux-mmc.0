From: Vijay Viswanath <vviswana@codeaurora.org>
Subject: [PATCH 3/5] mmc: sdhci-msm: Add support to wait for power irq
Date: Fri, 18 Aug 2017 10:49:40 +0530
Message-ID: <1503033582-48703-4-git-send-email-vviswana@codeaurora.org>
References: <1503033582-48703-1-git-send-email-vviswana@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1503033582-48703-1-git-send-email-vviswana@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: adrian.hunter@intel.com, ulf.hansson@linaro.org, will.deacon@arm.com
Cc: linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, asutoshd@codeaurora.org, stummala@codeaurora.org, riteshh@codeaurora.org, subhashj@codeaurora.org, Vijay Viswanath <vviswana@codeaurora.org>
List-Id: linux-mmc@vger.kernel.org

From: Sahitya Tummala <stummala@codeaurora.org>

Add support API which will check if power irq is expected to be
generated and wait for the power irq to come and complete if the irq is
expected.

Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>
Signed-off-by: Vijay Viswanath <vviswana@codeaurora.org>
---
 drivers/mmc/host/sdhci-msm.c | 125 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 123 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
index f3e0489..6d3b1fd 100644
--- a/drivers/mmc/host/sdhci-msm.c
+++ b/drivers/mmc/host/sdhci-msm.c
@@ -123,6 +123,10 @@
 #define CMUX_SHIFT_PHASE_MASK	(7 << CMUX_SHIFT_PHASE_SHIFT)
 
 #define MSM_MMC_AUTOSUSPEND_DELAY_MS	50
+
+/* Timeout value to avoid infinite waiting for pwr_irq */
+#define MSM_PWR_IRQ_TIMEOUT_MS 5000
+
 struct sdhci_msm_host {
 	struct platform_device *pdev;
 	void __iomem *core_mem;	/* MSM SDCC mapped address */
@@ -138,6 +142,11 @@ struct sdhci_msm_host {
 	bool calibration_done;
 	u8 saved_tuning_phase;
 	bool use_cdclp533;
+	u32 curr_pwr_state;
+	u32 curr_io_level;
+#ifdef CONFIG_MMC_SDHCI_IO_ACCESSORS
+	struct completion pwr_irq_completion;
+#endif
 };
 
 static unsigned int msm_get_clock_rate_for_bus_mode(struct sdhci_host *host,
@@ -995,6 +1004,90 @@ static void sdhci_msm_set_uhs_signaling(struct sdhci_host *host,
 		sdhci_msm_hs400(host, &mmc->ios);
 }
 
+#ifdef CONFIG_MMC_SDHCI_IO_ACCESSORS
+static inline void sdhci_msm_init_pwr_irq_completion(
+		struct sdhci_msm_host *msm_host)
+{
+	init_completion(&msm_host->pwr_irq_completion);
+}
+
+static inline void sdhci_msm_complete_pwr_irq_completion(
+		struct sdhci_msm_host *msm_host)
+{
+	complete(&msm_host->pwr_irq_completion);
+}
+
+/*
+ * sdhci_msm_check_power_status API should be called when registers writes
+ * which can toggle sdhci IO bus ON/OFF or change IO lines HIGH/LOW happens.
+ * To what state the register writes will change the IO lines should be passed
+ * as the argument req_type. This API will check whether the IO line's state
+ * is already the expected state and will wait for power irq only if
+ * power irq is expected to be trigerred based on the current IO line state
+ * and expected IO line state.
+ */
+static void sdhci_msm_check_power_status(struct sdhci_host *host, u32 req_type)
+{
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct sdhci_msm_host *msm_host = sdhci_pltfm_priv(pltfm_host);
+	unsigned long flags;
+	bool done = false;
+
+	spin_lock_irqsave(&host->lock, flags);
+	pr_debug("%s: %s: request %d curr_pwr_state %x curr_io_level %x\n",
+			mmc_hostname(host->mmc), __func__, req_type,
+			msm_host->curr_pwr_state, msm_host->curr_io_level);
+
+	/*
+	 * The IRQ for request type IO High/LOW will be generated when -
+	 * there is a state change in 1.8V enable bit (bit 3) of
+	 * SDHCI_HOST_CONTROL2 register. The reset state of that bit is 0
+	 * which indicates 3.3V IO voltage. So, when MMC core layer tries
+	 * to set it to 3.3V before card detection happens, the
+	 * IRQ doesn't get triggered as there is no state change in this bit.
+	 * The driver already handles this case by changing the IO voltage
+	 * level to high as part of controller power up sequence. Hence, check
+	 * for host->pwr to handle a case where IO voltage high request is
+	 * issued even before controller power up.
+	 */
+	if ((req_type & REQ_IO_HIGH) && !host->pwr) {
+		pr_debug("%s: do not wait for power IRQ that never comes\n",
+				mmc_hostname(host->mmc));
+		spin_unlock_irqrestore(&host->lock, flags);
+		return;
+	}
+	if ((req_type & msm_host->curr_pwr_state) ||
+			(req_type & msm_host->curr_io_level))
+		done = true;
+	spin_unlock_irqrestore(&host->lock, flags);
+	/*
+	 * This is needed here to hanlde a case where IRQ gets
+	 * triggered even before this function is called so that
+	 * x->done counter of completion gets reset. Otherwise,
+	 * next call to wait_for_completion returns immediately
+	 * without actually waiting for the IRQ to be handled.
+	 */
+	if (done)
+		init_completion(&msm_host->pwr_irq_completion);
+	else if (!wait_for_completion_timeout(&msm_host->pwr_irq_completion,
+				msecs_to_jiffies(MSM_PWR_IRQ_TIMEOUT_MS)))
+		__WARN_printf("%s: request(%d) timed out waiting for pwr_irq\n",
+				mmc_hostname(host->mmc), req_type);
+	pr_debug("%s: %s: request %d done\n", mmc_hostname(host->mmc),
+			__func__, req_type);
+}
+#else
+static inline void sdhci_msm_init_pwr_irq_completion(
+		struct sdhci_msm_host *msm_host)
+{
+}
+
+static inline void sdhci_msm_complete_pwr_irq_completion(
+		struct sdhci_msm_host *msm_host)
+{
+}
+#endif
+
 static void sdhci_msm_dump_pwr_ctrl_regs(struct sdhci_host *host)
 {
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
@@ -1013,6 +1106,9 @@ static void sdhci_msm_handle_pwr_irq(struct sdhci_host *host, int irq)
 	struct sdhci_msm_host *msm_host = sdhci_pltfm_priv(pltfm_host);
 	u32 irq_status, irq_ack = 0;
 	int retry = 10;
+	int pwr_state = 0, io_level = 0;
+	unsigned long flags;
+
 
 	irq_status = readl_relaxed(msm_host->core_mem + CORE_PWRCTL_STATUS);
 	irq_status &= INT_MASK;
@@ -1040,10 +1136,26 @@ static void sdhci_msm_handle_pwr_irq(struct sdhci_host *host, int irq)
 		udelay(10);
 	}
 
-	if (irq_status & (CORE_PWRCTL_BUS_ON | CORE_PWRCTL_BUS_OFF))
+	/* Handle BUS ON/OFF*/
+	if (irq_status & CORE_PWRCTL_BUS_ON) {
+		pwr_state = REQ_BUS_ON;
+		io_level = REQ_IO_HIGH;
+		irq_ack |= CORE_PWRCTL_BUS_SUCCESS;
+	}
+	if (irq_status & CORE_PWRCTL_BUS_OFF) {
+		pwr_state = REQ_BUS_OFF;
+		io_level = REQ_IO_LOW;
 		irq_ack |= CORE_PWRCTL_BUS_SUCCESS;
-	if (irq_status & (CORE_PWRCTL_IO_LOW | CORE_PWRCTL_IO_HIGH))
+	}
+	/* Handle IO LOW/HIGH */
+	if (irq_status & CORE_PWRCTL_IO_LOW) {
+		io_level = REQ_IO_LOW;
 		irq_ack |= CORE_PWRCTL_IO_SUCCESS;
+	}
+	if (irq_status & CORE_PWRCTL_IO_HIGH) {
+		io_level = REQ_IO_HIGH;
+		irq_ack |= CORE_PWRCTL_IO_SUCCESS;
+	}
 
 	/*
 	 * The driver has to acknowledge the interrupt, switch voltages and
@@ -1052,6 +1164,14 @@ static void sdhci_msm_handle_pwr_irq(struct sdhci_host *host, int irq)
 	 */
 	writel_relaxed(irq_ack, msm_host->core_mem + CORE_PWRCTL_CTL);
 
+	spin_lock_irqsave(&host->lock, flags);
+	if (pwr_state)
+		msm_host->curr_pwr_state = pwr_state;
+	if (io_level)
+		msm_host->curr_io_level = io_level;
+	spin_unlock_irqrestore(&host->lock, flags);
+	sdhci_msm_complete_pwr_irq_completion(msm_host);
+
 	pr_debug("%s: %s: Handled IRQ(%d), irq_status=0x%x, ack=0x%x\n",
 		mmc_hostname(msm_host->mmc), __func__, irq, irq_status,
 		irq_ack);
@@ -1319,6 +1439,7 @@ static int sdhci_msm_probe(struct platform_device *pdev)
 		goto clk_disable;
 	}
 
+	sdhci_msm_init_pwr_irq_completion(msm_host);
 	/* Enable pwr irq interrupts */
 	writel_relaxed(INT_MASK, msm_host->core_mem + CORE_PWRCTL_MASK);
 
-- 
 Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc. 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.
