From: Sreedhar Sambangi <ssambang@codeaurora.org>
Subject: [PATCH] qcom: sdhci-msm: enable the DLL clock
Date: Tue,  5 Apr 2016 00:46:43 -0700
Message-ID: <1459842403-4052-1-git-send-email-ssambang@codeaurora.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: andy.gross@linaro.org, linux-mmc@vger.kernel.org, linux-arm-msm@vger.kernel.org
Cc: qca-upstream.external@qca.qualcomm.com, ivan.ivanov@linaro.org, sboyd@codeaurora.org, georgi.djakov@linaro.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

The DLL clock has to be enabled until the correct
clock frequency is delivered to DLL
'1'(default) - DLL clock is disabled
'0' - dll clock has legacly clock enable.

Signed-off-by: Varadarajan Narayanan <varada@codeaurora.org>
Signed-off-by: Sreedhar Sambangi <ssambang@codeaurora.org>
---
 drivers/mmc/host/sdhci-msm.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
index 4695bee..95b8b70 100644
--- a/drivers/mmc/host/sdhci-msm.c
+++ b/drivers/mmc/host/sdhci-msm.c
@@ -43,6 +43,9 @@
 #define CORE_DLL_CONFIG		0x100
 #define CORE_DLL_STATUS		0x108
 
+#define CORE_DLL_CONFIG2	0x1b4
+#define CORE_DLL_CLK_DISABLE	BIT(21)
+
 #define CORE_VENDOR_SPEC	0x10c
 #define CORE_CLK_PWRSAVE	BIT(1)
 
@@ -326,6 +329,10 @@ static int msm_init_cm_dll(struct sdhci_host *host)
 	writel_relaxed((readl_relaxed(host->ioaddr + CORE_DLL_CONFIG)
 			| CORE_CK_OUT_EN), host->ioaddr + CORE_DLL_CONFIG);
 
+	/* Write 0 to DLL_CLOCK_DISABLE bit of DLL_CONFIG_2 register */
+	writel_relaxed((readl_relaxed(host->ioaddr + CORE_DLL_CONFIG2)
+		& ~CORE_DLL_CLK_DISABLE), host->ioaddr + CORE_DLL_CONFIG2);
+
 	/* Wait until DLL_LOCK bit of DLL_STATUS register becomes '1' */
 	while (!(readl_relaxed(host->ioaddr + CORE_DLL_STATUS) &
 		 CORE_DLL_LOCK)) {
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
