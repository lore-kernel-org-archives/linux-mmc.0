From: Ritesh Harjani <riteshh-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: [PATCH v5 01/12] mmc: sdhci-msm: Change poor style writel/readl of registers
Date: Wed,  5 Oct 2016 20:10:29 +0530
Message-ID: <1475678440-3525-2-git-send-email-riteshh@codeaurora.org>
References: <1475678440-3525-1-git-send-email-riteshh@codeaurora.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1475678440-3525-1-git-send-email-riteshh-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org
Cc: david.brown-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, andy.gross-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, georgi.djakov-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, alex.lemberg-XdAiOPVOjttBDgjK7y7TUQ@public.gmane.org, mateusz.nowak-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, Yuliy.Izrailov-XdAiOPVOjttBDgjK7y7TUQ@public.gmane.org, asutoshd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, david.griego-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, stummala-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, venkatg-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, bjorn.andersson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, pramod.gurav-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, Ritesh Harjani <riteshh-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

This patch changes the poor style of writel/readl registers
into more readable format. Also to avoid mixed style format
of readl/writel in sdhci-msm driver.

Signed-off-by: Ritesh Harjani <riteshh-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Acked-by: Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
---
 drivers/mmc/host/sdhci-msm.c | 54 ++++++++++++++++++++++++++------------------
 1 file changed, 32 insertions(+), 22 deletions(-)

diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
index 8ef44a2a..42f42aa 100644
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
+	u32 config = 0;
 
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

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
