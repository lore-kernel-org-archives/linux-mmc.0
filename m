From: Vijay Viswanath <vviswana@codeaurora.org>
Subject: [PATCH 4/5] mmc: sdhci-msm: Add ops to do sdhc register write
Date: Fri, 18 Aug 2017 10:49:41 +0530
Message-ID: <1503033582-48703-5-git-send-email-vviswana@codeaurora.org>
References: <1503033582-48703-1-git-send-email-vviswana@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1503033582-48703-1-git-send-email-vviswana@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: adrian.hunter@intel.com, ulf.hansson@linaro.org, will.deacon@arm.com
Cc: linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, asutoshd@codeaurora.org, stummala@codeaurora.org, riteshh@codeaurora.org, subhashj@codeaurora.org, Vijay Viswanath <vviswana@codeaurora.org>
List-Id: linux-mmc@vger.kernel.org

Register writes which change voltage of IO lines or turn the IO bus
on/off require controller to be ready before progressing further. When
the controller is ready, it will generate a power irq which needs to be
handled. The thread which initiated the register write should wait for
power irq to complete. This will be done through the new sdhc msm write
APIs which will check whether the particular write can trigger a power
irq and wait for it with a timeout if it is expected.
The SDHC core power control IRQ gets triggered when -
* There is a state change in power control bit (bit 0)
  of SDHCI_POWER_CONTROL register.
* There is a state change in 1.8V enable bit (bit 3) of
  SDHCI_HOST_CONTROL2 register.
* Bit 1 of SDHCI_SOFTWARE_RESET is set.

Signed-off-by: Vijay Viswanath <vviswana@codeaurora.org>
---
 drivers/mmc/host/sdhci-msm.c | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
index 6d3b1fd..6571880 100644
--- a/drivers/mmc/host/sdhci-msm.c
+++ b/drivers/mmc/host/sdhci-msm.c
@@ -1250,6 +1250,41 @@ static void sdhci_msm_set_clock(struct sdhci_host *host, unsigned int clock)
 	__sdhci_msm_set_clock(host, clock);
 }
 
+#ifdef CONFIG_MMC_SDHCI_IO_ACCESSORS
+static void __sdhci_msm_check_write(struct sdhci_host *host, u16 val, int reg)
+{
+	u32 req_type = 0;
+
+	switch (reg) {
+	case SDHCI_HOST_CONTROL2:
+		req_type = (val & SDHCI_CTRL_VDD_180) ? REQ_IO_LOW :
+			REQ_IO_HIGH;
+		break;
+	case SDHCI_SOFTWARE_RESET:
+		if (host->pwr && (val & SDHCI_RESET_ALL))
+			req_type = REQ_BUS_OFF;
+		break;
+	case SDHCI_POWER_CONTROL:
+		req_type = !val ? REQ_BUS_OFF : REQ_BUS_ON;
+		break;
+	}
+
+	if (req_type)
+		sdhci_msm_check_power_status(host, req_type);
+}
+
+static void sdhci_msm_writew(struct sdhci_host *host, u16 val, int reg)
+{
+		writew_relaxed(val, host->ioaddr + reg);
+		__sdhci_msm_check_write(host, val, reg);
+}
+
+static void sdhci_msm_writeb(struct sdhci_host *host, u8 val, int reg)
+{
+		writeb_relaxed(val, host->ioaddr + reg);
+		__sdhci_msm_check_write(host, val, reg);
+}
+#endif
 static const struct of_device_id sdhci_msm_dt_match[] = {
 	{ .compatible = "qcom,sdhci-msm-v4" },
 	{},
@@ -1264,6 +1299,10 @@ static void sdhci_msm_set_clock(struct sdhci_host *host, unsigned int clock)
 	.get_max_clock = sdhci_msm_get_max_clock,
 	.set_bus_width = sdhci_set_bus_width,
 	.set_uhs_signaling = sdhci_msm_set_uhs_signaling,
+#ifdef CONFIG_MMC_SDHCI_IO_ACCESSORS
+	.write_w = sdhci_msm_writew,
+	.write_b = sdhci_msm_writeb,
+#endif
 };
 
 static const struct sdhci_pltfm_data sdhci_msm_pdata = {
-- 
 Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc. 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.
