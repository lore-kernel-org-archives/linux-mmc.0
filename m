From: Ritesh Harjani <riteshh@codeaurora.org>
Subject: [PATCH v9 03/16] mmc: sdhci-msm: Change poor style writel/readl of registers
Date: Mon, 21 Nov 2016 12:07:13 +0530
Message-ID: <1479710246-26676-4-git-send-email-riteshh@codeaurora.org>
References: <1479710246-26676-1-git-send-email-riteshh@codeaurora.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:45364 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753112AbcKUGiS (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 21 Nov 2016 01:38:18 -0500
In-Reply-To: <1479710246-26676-1-git-send-email-riteshh@codeaurora.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, adrian.hunter@intel.com, sboyd@codeaurora.org, andy.gross@linaro.org
Cc: shawn.lin@rock-chips.com, devicetree@vger.kernel.org, linux-clk@vger.kernel.org, david.brown@linaro.org, linux-arm-msm@vger.kernel.org, georgi.djakov@linaro.org, alex.lemberg@sandisk.com, mateusz.nowak@intel.com, Yuliy.Izrailov@sandisk.com, asutoshd@codeaurora.org, david.griego@linaro.org, stummala@codeaurora.org, venkatg@codeaurora.org, rnayak@codeaurora.org, pramod.gurav@linaro.org, jeremymc@redhat.com, Ritesh Harjani <riteshh@codeaurora.org>

This patch changes the poor style of writel/readl registers
into more readable format. This avoid mixed style format
of readl/writel in sdhci-msm driver.
This patch also removes the one line comments which were present for
above writel/readl, since they were of no help.

Signed-off-by: Ritesh Harjani <riteshh@codeaurora.org>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci-msm.c | 62 +++++++++++++++++++++++---------------------
 1 file changed, 32 insertions(+), 30 deletions(-)

diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
index b78d72f..2dcbeb0 100644
--- a/drivers/mmc/host/sdhci-msm.c
+++ b/drivers/mmc/host/sdhci-msm.c
@@ -138,9 +138,9 @@ static int msm_config_cm_dll_phase(struct sdhci_host *host, u8 phase)
 	config |= grey_coded_phase_table[phase] << CDR_SELEXT_SHIFT;
 	writel_relaxed(config, host->ioaddr + CORE_DLL_CONFIG);
 
-	/* Set CK_OUT_EN bit of DLL_CONFIG register to 1. */
-	writel_relaxed((readl_relaxed(host->ioaddr + CORE_DLL_CONFIG)
-			| CORE_CK_OUT_EN), host->ioaddr + CORE_DLL_CONFIG);
+	config = readl_relaxed(host->ioaddr + CORE_DLL_CONFIG);
+	config |= CORE_CK_OUT_EN;
+	writel_relaxed(config, host->ioaddr + CORE_DLL_CONFIG);
 
 	/* Wait until CK_OUT_EN bit of DLL_CONFIG register becomes '1' */
 	rc = msm_dll_poll_ck_out_en(host, 1);
@@ -307,6 +307,7 @@ static int msm_init_cm_dll(struct sdhci_host *host)
 	struct mmc_host *mmc = host->mmc;
 	int wait_cnt = 50;
 	unsigned long flags;
+	u32 config;
 
 	spin_lock_irqsave(&host->lock, flags);
 
@@ -315,33 +316,34 @@ static int msm_init_cm_dll(struct sdhci_host *host)
 	 * tuning is in progress. Keeping PWRSAVE ON may
 	 * turn off the clock.
 	 */
-	writel_relaxed((readl_relaxed(host->ioaddr + CORE_VENDOR_SPEC)
-			& ~CORE_CLK_PWRSAVE), host->ioaddr + CORE_VENDOR_SPEC);
+	config = readl_relaxed(host->ioaddr + CORE_VENDOR_SPEC);
+	config &= ~CORE_CLK_PWRSAVE;
+	writel_relaxed(config, host->ioaddr + CORE_VENDOR_SPEC);
 
-	/* Write 1 to DLL_RST bit of DLL_CONFIG register */
-	writel_relaxed((readl_relaxed(host->ioaddr + CORE_DLL_CONFIG)
-			| CORE_DLL_RST), host->ioaddr + CORE_DLL_CONFIG);
+	config = readl_relaxed(host->ioaddr + CORE_DLL_CONFIG);
+	config |= CORE_DLL_RST;
+	writel_relaxed(config, host->ioaddr + CORE_DLL_CONFIG);
 
-	/* Write 1 to DLL_PDN bit of DLL_CONFIG register */
-	writel_relaxed((readl_relaxed(host->ioaddr + CORE_DLL_CONFIG)
-			| CORE_DLL_PDN), host->ioaddr + CORE_DLL_CONFIG);
+	config = readl_relaxed(host->ioaddr + CORE_DLL_CONFIG);
+	config |= CORE_DLL_PDN;
+	writel_relaxed(config, host->ioaddr + CORE_DLL_CONFIG);
 	msm_cm_dll_set_freq(host);
 
-	/* Write 0 to DLL_RST bit of DLL_CONFIG register */
-	writel_relaxed((readl_relaxed(host->ioaddr + CORE_DLL_CONFIG)
-			& ~CORE_DLL_RST), host->ioaddr + CORE_DLL_CONFIG);
+	config = readl_relaxed(host->ioaddr + CORE_DLL_CONFIG);
+	config &= ~CORE_DLL_RST;
+	writel_relaxed(config, host->ioaddr + CORE_DLL_CONFIG);
 
-	/* Write 0 to DLL_PDN bit of DLL_CONFIG register */
-	writel_relaxed((readl_relaxed(host->ioaddr + CORE_DLL_CONFIG)
-			& ~CORE_DLL_PDN), host->ioaddr + CORE_DLL_CONFIG);
+	config = readl_relaxed(host->ioaddr + CORE_DLL_CONFIG);
+	config &= ~CORE_DLL_PDN;
+	writel_relaxed(config, host->ioaddr + CORE_DLL_CONFIG);
 
-	/* Set DLL_EN bit to 1. */
-	writel_relaxed((readl_relaxed(host->ioaddr + CORE_DLL_CONFIG)
-			| CORE_DLL_EN), host->ioaddr + CORE_DLL_CONFIG);
+	config = readl_relaxed(host->ioaddr + CORE_DLL_CONFIG);
+	config |= CORE_DLL_EN;
+	writel_relaxed(config, host->ioaddr + CORE_DLL_CONFIG);
 
-	/* Set CK_OUT_EN bit to 1. */
-	writel_relaxed((readl_relaxed(host->ioaddr + CORE_DLL_CONFIG)
-			| CORE_CK_OUT_EN), host->ioaddr + CORE_DLL_CONFIG);
+	config = readl_relaxed(host->ioaddr + CORE_DLL_CONFIG);
+	config |= CORE_CK_OUT_EN;
+	writel_relaxed(config, host->ioaddr + CORE_DLL_CONFIG);
 
 	/* Wait until DLL_LOCK bit of DLL_STATUS register becomes '1' */
 	while (!(readl_relaxed(host->ioaddr + CORE_DLL_STATUS) &
@@ -538,7 +540,7 @@ static int sdhci_msm_probe(struct platform_device *pdev)
 	struct resource *core_memres;
 	int ret;
 	u16 host_version, core_minor;
-	u32 core_version, caps;
+	u32 core_version, config;
 	u8 core_major;
 
 	host = sdhci_pltfm_init(pdev, &sdhci_msm_pdata, sizeof(*msm_host));
@@ -606,9 +608,9 @@ static int sdhci_msm_probe(struct platform_device *pdev)
 		goto clk_disable;
 	}
 
-	/* Reset the core and Enable SDHC mode */
-	writel_relaxed(readl_relaxed(msm_host->core_mem + CORE_POWER) |
-		       CORE_SW_RST, msm_host->core_mem + CORE_POWER);
+	config = readl_relaxed(msm_host->core_mem + CORE_POWER);
+	config |= CORE_SW_RST;
+	writel_relaxed(config, msm_host->core_mem + CORE_POWER);
 
 	/* SW reset can take upto 10HCLK + 15MCLK cycles. (min 40us) */
 	usleep_range(1000, 5000);
@@ -638,9 +640,9 @@ static int sdhci_msm_probe(struct platform_device *pdev)
 	 * controller versions and must be explicitly enabled.
 	 */
 	if (core_major >= 1 && core_minor != 0x11 && core_minor != 0x12) {
-		caps = readl_relaxed(host->ioaddr + SDHCI_CAPABILITIES);
-		caps |= SDHCI_CAN_VDD_300 | SDHCI_CAN_DO_8BIT;
-		writel_relaxed(caps, host->ioaddr +
+		config = readl_relaxed(host->ioaddr + SDHCI_CAPABILITIES);
+		config |= SDHCI_CAN_VDD_300 | SDHCI_CAN_DO_8BIT;
+		writel_relaxed(config, host->ioaddr +
 			       CORE_VENDOR_SPEC_CAPABILITIES0);
 	}
 
-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, 
a Linux Foundation Collaborative Project.

