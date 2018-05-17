From: Vijay Viswanath <vviswana@codeaurora.org>
Subject: [PATCH V1 2/3] mmc: sdhci-msm: Add msm version specific ops and data structures
Date: Thu, 17 May 2018 15:58:57 +0530
Message-ID: <1526552938-21292-3-git-send-email-vviswana@codeaurora.org>
References: <1526552938-21292-1-git-send-email-vviswana@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1526552938-21292-1-git-send-email-vviswana@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: adrian.hunter@intel.com, ulf.hansson@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, shawn.lin@rock-chips.com, linux-arm-msm@vger.kernel.org, georgi.djakov@linaro.org, devicetree@vger.kernel.org, asutoshd@codeaurora.org, stummala@codeaurora.org, venkatg@codeaurora.org, jeremymc@redhat.com, vviswana@codeaurora.org, bjorn.andersson@linaro.org, riteshh@codeaurora.org, vbadigan@codeaurora.org, dianders@google.com, sayalil@codeaurora.org
List-Id: linux-mmc@vger.kernel.org

In addition to offsets of certain registers changing, the registers in
core_mem have been shifted to HC mem as well. To access these registers,
define msm version specific functions. These functions can be loaded
into the function pointers at the time of probe based on the msm version
detected.

Also defind new data structure to hold version specific Ops and register
addresses.

Signed-off-by: Sayali Lokhande <sayalil@codeaurora.org>
Signed-off-by: Vijay Viswanath <vviswana@codeaurora.org>
---
 drivers/mmc/host/sdhci-msm.c | 112 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 112 insertions(+)

diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
index 2524455..bb2bb59 100644
--- a/drivers/mmc/host/sdhci-msm.c
+++ b/drivers/mmc/host/sdhci-msm.c
@@ -226,6 +226,25 @@ struct sdhci_msm_offset {
 	.core_ddr_config_2 = 0x1BC,
 };
 
+struct sdhci_msm_variant_ops {
+	u8 (*msm_readb_relaxed)(struct sdhci_host *host, u32 offset);
+	u32 (*msm_readl_relaxed)(struct sdhci_host *host, u32 offset);
+	void (*msm_writeb_relaxed)(u8 val, struct sdhci_host *host, u32 offset);
+	void (*msm_writel_relaxed)(u32 val, struct sdhci_host *host,
+			u32 offset);
+};
+
+/*
+ * From V5, register spaces have changed. Wrap this info in a structure
+ * and choose the data_structure based on version info mentioned in DT.
+ */
+struct sdhci_msm_variant_info {
+	bool mci_removed;
+	const struct sdhci_msm_variant_ops *var_ops;
+	const struct sdhci_msm_offset *offset;
+};
+
+
 struct sdhci_msm_host {
 	struct platform_device *pdev;
 	void __iomem *core_mem;	/* MSM SDCC mapped address */
@@ -245,8 +264,75 @@ struct sdhci_msm_host {
 	wait_queue_head_t pwr_irq_wait;
 	bool pwr_irq_flag;
 	u32 caps_0;
+	bool mci_removed;
+	const struct sdhci_msm_variant_ops *var_ops;
+	const struct sdhci_msm_offset *offset;
 };
 
+/*
+ * APIs to read/write to vendor specific registers which were there in the
+ * core_mem region before MCI was removed.
+ */
+static u8 sdhci_msm_mci_variant_readb_relaxed(struct sdhci_host *host,
+		u32 offset)
+{
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct sdhci_msm_host *msm_host = sdhci_pltfm_priv(pltfm_host);
+
+	return readb_relaxed(msm_host->core_mem + offset);
+}
+
+static u8 sdhci_msm_v5_variant_readb_relaxed(struct sdhci_host *host,
+		u32 offset)
+{
+	return readb_relaxed(host->ioaddr + offset);
+}
+
+static u32 sdhci_msm_mci_variant_readl_relaxed(struct sdhci_host *host,
+		u32 offset)
+{
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct sdhci_msm_host *msm_host = sdhci_pltfm_priv(pltfm_host);
+
+	return readl_relaxed(msm_host->core_mem + offset);
+}
+
+static u32 sdhci_msm_v5_variant_readl_relaxed(struct sdhci_host *host,
+		u32 offset)
+{
+	return readl_relaxed(host->ioaddr + offset);
+}
+
+static void sdhci_msm_mci_variant_writeb_relaxed(u8 val,
+		struct sdhci_host *host, u32 offset)
+{
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct sdhci_msm_host *msm_host = sdhci_pltfm_priv(pltfm_host);
+
+	writeb_relaxed(val, msm_host->core_mem + offset);
+}
+
+static void sdhci_msm_v5_variant_writeb_relaxed(u8 val, struct sdhci_host *host,
+		u32 offset)
+{
+	writeb_relaxed(val, host->ioaddr + offset);
+}
+
+static void sdhci_msm_mci_variant_writel_relaxed(u32 val,
+		struct sdhci_host *host, u32 offset)
+{
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct sdhci_msm_host *msm_host = sdhci_pltfm_priv(pltfm_host);
+
+	writel_relaxed(val, msm_host->core_mem + offset);
+}
+
+static void sdhci_msm_v5_variant_writel_relaxed(u32 val, struct sdhci_host *host,
+		u32 offset)
+{
+	writel_relaxed(val, host->ioaddr + offset);
+}
+
 static unsigned int msm_get_clock_rate_for_bus_mode(struct sdhci_host *host,
 						    unsigned int clock)
 {
@@ -1481,6 +1567,32 @@ static void sdhci_msm_set_regulator_caps(struct sdhci_msm_host *msm_host)
 	pr_debug("%s: supported caps: 0x%08x\n", mmc_hostname(mmc), caps);
 }
 
+static const struct sdhci_msm_variant_ops mci_var_ops = {
+	.msm_readb_relaxed = sdhci_msm_mci_variant_readb_relaxed,
+	.msm_readl_relaxed = sdhci_msm_mci_variant_readl_relaxed,
+	.msm_writeb_relaxed = sdhci_msm_mci_variant_writeb_relaxed,
+	.msm_writel_relaxed = sdhci_msm_mci_variant_writel_relaxed,
+};
+
+static const struct sdhci_msm_variant_ops v5_var_ops = {
+	.msm_readb_relaxed = sdhci_msm_v5_variant_readb_relaxed,
+	.msm_readl_relaxed = sdhci_msm_v5_variant_readl_relaxed,
+	.msm_writeb_relaxed = sdhci_msm_v5_variant_writeb_relaxed,
+	.msm_writel_relaxed = sdhci_msm_v5_variant_writel_relaxed,
+};
+
+static const struct sdhci_msm_variant_info sdhci_msm_mci_var = {
+	.mci_removed = 0,
+	.var_ops = &mci_var_ops,
+	.offset = &sdhci_msm_mci_offset,
+};
+
+static const struct sdhci_msm_variant_info sdhci_msm_v5_var = {
+	.mci_removed = 1,
+	.var_ops = &v5_var_ops,
+	.offset = &sdhci_msm_v5_offset,
+};
+
 static const struct of_device_id sdhci_msm_dt_match[] = {
 	{ .compatible = "qcom,sdhci-msm-v4" },
 	{},
-- 
 Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc. 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.
