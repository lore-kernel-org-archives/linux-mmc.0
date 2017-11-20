From: Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: [PATCH] mmc: sdhci-msm: Optionally wait for signal level changes
Date: Mon, 20 Nov 2017 10:34:51 -0800
Message-ID: <20171120183451.18966-1-bjorn.andersson@linaro.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, Sahitya Tummala <stummala@codeaurora.org>, Vijay Viswanath <vviswana@codeaurora.org>
List-Id: linux-mmc@vger.kernel.org

Not all instances of the SDCC core supports changing signal voltage and
as such will not generate a power interrupt when the software attempts
to change the voltage. This results in probing the eMMC on some devices
to take over 2 minutes.

Check that the SWITCHABLE_SIGNAL_VOLTAGE bit in MCI_GENERICS is set
before waiting for the power interrupt.

Cc: Sahitya Tummala <stummala@codeaurora.org>
Cc: Vijay Viswanath <vviswana@codeaurora.org>
Fixes: c0309b3803fe ("mmc: sdhci-msm: Add sdhci msm register write APIs which wait for pwr irq")
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

The offending patch is part of your v4.15 pull request, so please pick
this up for the -rcs.

 drivers/mmc/host/sdhci-msm.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
index 3fb7d2eec93f..8f2dda73e6b4 100644
--- a/drivers/mmc/host/sdhci-msm.c
+++ b/drivers/mmc/host/sdhci-msm.c
@@ -29,6 +29,9 @@
 #define CORE_VERSION_MAJOR_MASK		(0xf << CORE_VERSION_MAJOR_SHIFT)
 #define CORE_VERSION_MINOR_MASK		0xff
 
+#define CORE_MCI_GENERICS		0x70
+#define SWICHABLE_SIGNALING_VOLTAGE	BIT(29)
+
 #define CORE_HC_MODE		0x78
 #define HC_MODE_EN		0x1
 #define CORE_POWER		0x0
@@ -1028,11 +1031,22 @@ static void sdhci_msm_check_power_status(struct sdhci_host *host, u32 req_type)
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
 	struct sdhci_msm_host *msm_host = sdhci_pltfm_priv(pltfm_host);
 	bool done = false;
+	u32 val;
 
 	pr_debug("%s: %s: request %d curr_pwr_state %x curr_io_level %x\n",
 			mmc_hostname(host->mmc), __func__, req_type,
 			msm_host->curr_pwr_state, msm_host->curr_io_level);
 
+	/*
+	 * The power interrupt will not be generated for signal voltage
+	 * switches if SWICHABLE_SIGNALING_VOLTAGE in MCI_GENERICS is not set
+	 */
+	val = readl(msm_host->core_mem + CORE_MCI_GENERICS);
+	if ((req_type & REQ_IO_HIGH || req_type & REQ_IO_LOW) &&
+	    !(val & SWICHABLE_SIGNALING_VOLTAGE)) {
+		return;
+	}
+
 	/*
 	 * The IRQ for request type IO High/LOW will be generated when -
 	 * there is a state change in 1.8V enable bit (bit 3) of
-- 
2.15.0
