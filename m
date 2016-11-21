From: Ritesh Harjani <riteshh@codeaurora.org>
Subject: [PATCH v9 14/16] mmc: sdhci-msm: Save the calculated tuning phase
Date: Mon, 21 Nov 2016 12:07:24 +0530
Message-ID: <1479710246-26676-15-git-send-email-riteshh@codeaurora.org>
References: <1479710246-26676-1-git-send-email-riteshh@codeaurora.org>
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <1479710246-26676-1-git-send-email-riteshh@codeaurora.org>
Sender: linux-clk-owner@vger.kernel.org
To: ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, adrian.hunter@intel.com, sboyd@codeaurora.org, andy.gross@linaro.org
Cc: shawn.lin@rock-chips.com, devicetree@vger.kernel.org, linux-clk@vger.kernel.org, david.brown@linaro.org, linux-arm-msm@vger.kernel.org, georgi.djakov@linaro.org, alex.lemberg@sandisk.com, mateusz.nowak@intel.com, Yuliy.Izrailov@sandisk.com, asutoshd@codeaurora.org, david.griego@linaro.org, stummala@codeaurora.org, venkatg@codeaurora.org, rnayak@codeaurora.org, pramod.gurav@linaro.org, jeremymc@redhat.com, Ritesh Harjani <riteshh@codeaurora.org>
List-Id: linux-mmc@vger.kernel.org

Save the tuning phase once the tuning is performed.
This phase value will be used while calibrating DLL
for HS400 mode.

Signed-off-by: Ritesh Harjani <riteshh@codeaurora.org>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci-msm.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
index b1888c3..f4f277b 100644
--- a/drivers/mmc/host/sdhci-msm.c
+++ b/drivers/mmc/host/sdhci-msm.c
@@ -75,6 +75,7 @@
 
 #define CORE_VENDOR_SPEC_CAPABILITIES0	0x11c
 
+#define INVALID_TUNING_PHASE	-1
 #define SDHCI_MSM_MIN_CLOCK	400000
 #define CORE_FREQ_100MHZ	(100 * 1000 * 1000)
 
@@ -97,6 +98,7 @@ struct sdhci_msm_host {
 	bool use_14lpp_dll_reset;
 	bool tuning_done;
 	bool calibration_done;
+	u8 saved_tuning_phase;
 };
 
 /* Platform specific tuning */
@@ -136,6 +138,9 @@ static int msm_config_cm_dll_phase(struct sdhci_host *host, u8 phase)
 	u32 config;
 	struct mmc_host *mmc = host->mmc;
 
+	if (phase > 0xf)
+		return -EINVAL;
+
 	spin_lock_irqsave(&host->lock, flags);
 
 	config = readl_relaxed(host->ioaddr + CORE_DLL_CONFIG);
@@ -429,6 +434,8 @@ static int sdhci_msm_execute_tuning(struct sdhci_host *host, u32 opcode)
 	int rc;
 	struct mmc_host *mmc = host->mmc;
 	struct mmc_ios ios = host->mmc->ios;
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct sdhci_msm_host *msm_host = sdhci_pltfm_priv(pltfm_host);
 
 	/*
 	 * Tuning is required for SDR104, HS200 and HS400 cards and
@@ -453,6 +460,7 @@ static int sdhci_msm_execute_tuning(struct sdhci_host *host, u32 opcode)
 		if (rc)
 			return rc;
 
+		msm_host->saved_tuning_phase = phase;
 		rc = mmc_send_tuning(mmc, opcode, NULL);
 		if (!rc) {
 			/* Tuning is successful at this tuning point */
@@ -799,6 +807,8 @@ static int sdhci_msm_probe(struct platform_device *pdev)
 
 	sdhci_get_of_property(pdev);
 
+	msm_host->saved_tuning_phase = INVALID_TUNING_PHASE;
+
 	/* Setup SDCC bus voter clock. */
 	msm_host->bus_clk = devm_clk_get(&pdev->dev, "bus");
 	if (!IS_ERR(msm_host->bus_clk)) {
-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, 
a Linux Foundation Collaborative Project.

