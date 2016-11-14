From: Ritesh Harjani <riteshh@codeaurora.org>
Subject: [PATCH v7 03/14] mmc: sdhci-msm: Change poor style writel/readl of registers
Date: Mon, 14 Nov 2016 11:30:37 +0530
Message-ID: <1479103248-9491-4-git-send-email-riteshh@codeaurora.org>
References: <1479103248-9491-1-git-send-email-riteshh@codeaurora.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:41018 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S940767AbcKNGBi (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 14 Nov 2016 01:01:38 -0500
In-Reply-To: <1479103248-9491-1-git-send-email-riteshh@codeaurora.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, adrian.hunter@intel.com, shawn.lin@rock-chips.com, sboyd@codeaurora.org, andy.gross@linaro.org
Cc: devicetree@vger.kernel.org, linux-clk@vger.kernel.org, david.brown@linaro.org, linux-arm-msm@vger.kernel.org, georgi.djakov@linaro.org, alex.lemberg@sandisk.com, mateusz.nowak@intel.com, Yuliy.Izrailov@sandisk.com, asutoshd@codeaurora.org, kdorfman@codeaurora.org, david.griego@linaro.org, stummala@codeaurora.org, venkatg@codeaurora.org, rnayak@codeaurora.org, pramod.gurav@linaro.org, Ritesh Harjani <riteshh@codeaurora.org>

This patch changes the poor style of writel/readl registers
into more readable format. Also to avoid mixed style format
of readl/writel in sdhci-msm driver.

Signed-off-by: Ritesh Harjani <riteshh@codeaurora.org>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci-msm.c | 54 ++++++++++++++++++++++++++------------------
 1 file changed, 32 insertions(+), 22 deletions(-)

diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
index 90ed2e1..6ea89c2 100644
--- a/drivers/mmc/host/sdhci-msm.c
+++ b/drivers/mmc/host/sdhci-msm.c
@@ -137,8 +137,9 @@ static int msm_config_cm_dll_phase(struct sdhci_host *host, u8 phase)
 	writel_relaxed(config, host->ioaddr + CORE_DLL_CONFIG);
 
 	/* Set CK_OUT_EN bit of DLL_CONFIG register to 1. */
-	writel_relaxed((readl_relaxed(host->ioaddr + CORE_DLL_CONFIG)
-			| CORE_CK_OUT_EN), host->ioaddr + CORE_DLL_CONFIG);
+	config = readl_relaxed(host->ioaddr + CORE_DLL_CONFIG);
+	config |= CORE_CK_OUT_EN;
+	writel_relaxed(config, host->ioaddr + CORE_DLL_CONFIG);
 
 	/* Wait until CK_OUT_EN bit of DLL_CONFIG register becomes '1' */
 	rc = msm_dll_poll_ck_out_en(host, 1);
@@ -305,6 +306,7 @@ static int msm_init_cm_dll(struct sdhci_host *host)
 	struct mmc_host *mmc = host->mmc;
 	int wait_cnt = 50;
 	unsigned long flags;
+	u32 config;
 
 	spin_lock_irqsave(&host->lock, flags);
 
@@ -313,33 +315,40 @@ static int msm_init_cm_dll(struct sdhci_host *host)
 	 * tuning is in progress. Keeping PWRSAVE ON may
 	 * turn off the clock.
 	 */
-	writel_relaxed((readl_relaxed(host->ioaddr + CORE_VENDOR_SPEC)
-			& ~CORE_CLK_PWRSAVE), host->ioaddr + CORE_VENDOR_SPEC);
+	config = readl_relaxed(host->ioaddr + CORE_VENDOR_SPEC);
+	config &= ~CORE_CLK_PWRSAVE;
+	writel_relaxed(config, host->ioaddr + CORE_VENDOR_SPEC);
 
 	/* Write 1 to DLL_RST bit of DLL_CONFIG register */
-	writel_relaxed((readl_relaxed(host->ioaddr + CORE_DLL_CONFIG)
-			| CORE_DLL_RST), host->ioaddr + CORE_DLL_CONFIG);
+	config = readl_relaxed(host->ioaddr + CORE_DLL_CONFIG);
+	config |= CORE_DLL_RST;
+	writel_relaxed(config, host->ioaddr + CORE_DLL_CONFIG);
 
 	/* Write 1 to DLL_PDN bit of DLL_CONFIG register */
-	writel_relaxed((readl_relaxed(host->ioaddr + CORE_DLL_CONFIG)
-			| CORE_DLL_PDN), host->ioaddr + CORE_DLL_CONFIG);
+	config = readl_relaxed(host->ioaddr + CORE_DLL_CONFIG);
+	config |= CORE_DLL_PDN;
+	writel_relaxed(config, host->ioaddr + CORE_DLL_CONFIG);
 	msm_cm_dll_set_freq(host);
 
 	/* Write 0 to DLL_RST bit of DLL_CONFIG register */
-	writel_relaxed((readl_relaxed(host->ioaddr + CORE_DLL_CONFIG)
-			& ~CORE_DLL_RST), host->ioaddr + CORE_DLL_CONFIG);
+	config = readl_relaxed(host->ioaddr + CORE_DLL_CONFIG);
+	config &= ~CORE_DLL_RST;
+	writel_relaxed(config, host->ioaddr + CORE_DLL_CONFIG);
 
 	/* Write 0 to DLL_PDN bit of DLL_CONFIG register */
-	writel_relaxed((readl_relaxed(host->ioaddr + CORE_DLL_CONFIG)
-			& ~CORE_DLL_PDN), host->ioaddr + CORE_DLL_CONFIG);
+	config = readl_relaxed(host->ioaddr + CORE_DLL_CONFIG);
+	config &= ~CORE_DLL_PDN;
+	writel_relaxed(config, host->ioaddr + CORE_DLL_CONFIG);
 
 	/* Set DLL_EN bit to 1. */
-	writel_relaxed((readl_relaxed(host->ioaddr + CORE_DLL_CONFIG)
-			| CORE_DLL_EN), host->ioaddr + CORE_DLL_CONFIG);
+	config = readl_relaxed(host->ioaddr + CORE_DLL_CONFIG);
+	config |= CORE_DLL_EN;
+	writel_relaxed(config, host->ioaddr + CORE_DLL_CONFIG);
 
 	/* Set CK_OUT_EN bit to 1. */
-	writel_relaxed((readl_relaxed(host->ioaddr + CORE_DLL_CONFIG)
-			| CORE_CK_OUT_EN), host->ioaddr + CORE_DLL_CONFIG);
+	config = readl_relaxed(host->ioaddr + CORE_DLL_CONFIG);
+	config |= CORE_CK_OUT_EN;
+	writel_relaxed(config, host->ioaddr + CORE_DLL_CONFIG);
 
 	/* Wait until DLL_LOCK bit of DLL_STATUS register becomes '1' */
 	while (!(readl_relaxed(host->ioaddr + CORE_DLL_STATUS) &
@@ -536,7 +545,7 @@ static int sdhci_msm_probe(struct platform_device *pdev)
 	struct resource *core_memres;
 	int ret;
 	u16 host_version, core_minor;
-	u32 core_version, caps;
+	u32 core_version, config;
 	u8 core_major;
 
 	host = sdhci_pltfm_init(pdev, &sdhci_msm_pdata, sizeof(*msm_host));
@@ -605,8 +614,9 @@ static int sdhci_msm_probe(struct platform_device *pdev)
 	}
 
 	/* Reset the core and Enable SDHC mode */
-	writel_relaxed(readl_relaxed(msm_host->core_mem + CORE_POWER) |
-		       CORE_SW_RST, msm_host->core_mem + CORE_POWER);
+	config = readl_relaxed(msm_host->core_mem + CORE_POWER);
+	config |= CORE_SW_RST;
+	writel_relaxed(config, msm_host->core_mem + CORE_POWER);
 
 	/* SW reset can take upto 10HCLK + 15MCLK cycles. (min 40us) */
 	usleep_range(1000, 5000);
@@ -636,9 +646,9 @@ static int sdhci_msm_probe(struct platform_device *pdev)
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

