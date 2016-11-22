From: Georgi Djakov <georgi.djakov@linaro.org>
Subject: [PATCH] mmc: sdhci-msm: Add sdhci_reset() implementation
Date: Tue, 22 Nov 2016 17:50:05 +0200
Message-ID: <20161122155005.16910-1-georgi.djakov@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: adrian.hunter@intel.com, ulf.hansson@linaro.org
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, riteshh@codeaurora.org, georgi.djakov@linaro.org
List-Id: linux-mmc@vger.kernel.org

On apq8016, apq8084 and apq8074 platforms, when we want to do a
software reset, we need to poke some additional vendor specific
registers. If we don't do so, the following error message appears:

mmc0: Reset 0x1 never completed.
sdhci: =========== REGISTER DUMP (mmc0)===========
sdhci: Sys addr: 0x00000000 | Version:  0x00002e02
sdhci: Blk size: 0x00004000 | Blk cnt:  0x00000000
sdhci: Argument: 0x00000000 | Trn mode: 0x00000000
sdhci: Present:  0x01f80000 | Host ctl: 0x00000000
sdhci: Power:    0x00000000 | Blk gap:  0x00000000
sdhci: Wake-up:  0x00000000 | Clock:    0x00000003
sdhci: Timeout:  0x00000000 | Int stat: 0x00000000
sdhci: Int enab: 0x00000000 | Sig enab: 0x00000000
sdhci: AC12 err: 0x00000000 | Slot int: 0x00000000
sdhci: Caps:     0x322dc8b2 | Caps_1:   0x00008007
sdhci: Cmd:      0x00000000 | Max curr: 0x00000000
sdhci: Host ctl2: 0x00000000
sdhci: ADMA Err: 0x00000000 | ADMA Ptr: 0x0000000000000000
sdhci: ===========================================

Fix it by implementing the custom sdhci_reset() function,
which does what is needed.

Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
---
 drivers/mmc/host/sdhci-msm.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
index 8ef44a2a2fd9..87a124a37408 100644
--- a/drivers/mmc/host/sdhci-msm.c
+++ b/drivers/mmc/host/sdhci-msm.c
@@ -505,6 +505,23 @@ static irqreturn_t sdhci_msm_pwr_irq(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
+void sdhci_msm_reset(struct sdhci_host *host, u8 mask)
+{
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct sdhci_msm_host *msm_host = sdhci_pltfm_priv(pltfm_host);
+
+	if (mask & SDHCI_RESET_ALL) {
+		u32 val = readl_relaxed(msm_host->core_mem + CORE_POWER);
+
+		val |= CORE_SW_RST;
+		writel_relaxed(val, msm_host->core_mem + CORE_POWER);
+
+		sdhci_msm_voltage_switch(host);
+	}
+
+	sdhci_reset(host, mask);
+}
+
 static const struct of_device_id sdhci_msm_dt_match[] = {
 	{ .compatible = "qcom,sdhci-msm-v4" },
 	{},
@@ -514,7 +531,7 @@ MODULE_DEVICE_TABLE(of, sdhci_msm_dt_match);
 
 static const struct sdhci_ops sdhci_msm_ops = {
 	.platform_execute_tuning = sdhci_msm_execute_tuning,
-	.reset = sdhci_reset,
+	.reset = sdhci_msm_reset,
 	.set_clock = sdhci_set_clock,
 	.set_bus_width = sdhci_set_bus_width,
 	.set_uhs_signaling = sdhci_msm_set_uhs_signaling,
