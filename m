From: Ritesh Harjani <riteshh-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: [PATCH v6 12/14] mmc: sdhci-msm: Save the calculated tuning phase
Date: Mon,  7 Nov 2016 16:54:35 +0530
Message-ID: <1478517877-23733-13-git-send-email-riteshh@codeaurora.org>
References: <1478517877-23733-1-git-send-email-riteshh@codeaurora.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1478517877-23733-1-git-send-email-riteshh-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org, sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, david.brown-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, andy.gross-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, georgi.djakov-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, alex.lemberg-XdAiOPVOjttBDgjK7y7TUQ@public.gmane.org, mateusz.nowak-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, Yuliy.Izrailov-XdAiOPVOjttBDgjK7y7TUQ@public.gmane.org, asutoshd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, kdorfman-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, david.griego-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, stummala-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, venkatg-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, rnayak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, pramod.gurav-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, Ritesh Harjani <riteshh-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

Save the tuning phase once the tuning is performed.
This phase value will be used while calibrating DLL
for HS400 mode.

Signed-off-by: Ritesh Harjani <riteshh-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
---
 drivers/mmc/host/sdhci-msm.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
index 2561c41..6431bb8 100644
--- a/drivers/mmc/host/sdhci-msm.c
+++ b/drivers/mmc/host/sdhci-msm.c
@@ -74,6 +74,7 @@
 
 #define CORE_VENDOR_SPEC_CAPABILITIES0	0x11c
 
+#define INVALID_TUNING_PHASE	-1
 #define TCXO_FREQ		19200000
 #define SDHCI_MSM_MIN_CLOCK	400000
 #define CORE_FREQ_100MHZ	(100 * 1000 * 1000)
@@ -95,6 +96,7 @@ struct sdhci_msm_host {
 	bool use_14lpp_dll_reset;
 	bool tuning_done;
 	bool calibration_done;
+	u8 saved_tuning_phase;
 };
 
 /* Platform specific tuning */
@@ -134,6 +136,9 @@ static int msm_config_cm_dll_phase(struct sdhci_host *host, u8 phase)
 	u32 config;
 	struct mmc_host *mmc = host->mmc;
 
+	if (phase > 0xf)
+		return -EINVAL;
+
 	spin_lock_irqsave(&host->lock, flags);
 
 	config = readl_relaxed(host->ioaddr + CORE_DLL_CONFIG);
@@ -431,6 +436,8 @@ static int sdhci_msm_execute_tuning(struct sdhci_host *host, u32 opcode)
 	int rc;
 	struct mmc_host *mmc = host->mmc;
 	struct mmc_ios ios = host->mmc->ios;
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct sdhci_msm_host *msm_host = sdhci_pltfm_priv(pltfm_host);
 
 	/*
 	 * Tuning is required for SDR104, HS200 and HS400 cards and
@@ -455,6 +462,7 @@ static int sdhci_msm_execute_tuning(struct sdhci_host *host, u32 opcode)
 		if (rc)
 			return rc;
 
+		msm_host->saved_tuning_phase = phase;
 		rc = mmc_send_tuning(mmc, opcode, NULL);
 		if (!rc) {
 			/* Tuning is successful at this tuning point */
@@ -826,6 +834,8 @@ static int sdhci_msm_probe(struct platform_device *pdev)
 
 	sdhci_get_of_property(pdev);
 
+	msm_host->saved_tuning_phase = INVALID_TUNING_PHASE;
+
 	/* Setup SDCC bus voter clock. */
 	msm_host->bus_clk = devm_clk_get(&pdev->dev, "bus");
 	if (!IS_ERR(msm_host->bus_clk)) {
-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, 
a Linux Foundation Collaborative Project.

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
