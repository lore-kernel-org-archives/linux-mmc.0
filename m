From: Ritesh Harjani <riteshh@codeaurora.org>
Subject: [RFC PATCH 2/3] mmc: sdhci-msm: Implement platform_dumpregs callback in sdhci-msm
Date: Fri, 30 Dec 2016 17:02:10 +0530
Message-ID: <1483097531-9991-3-git-send-email-riteshh@codeaurora.org>
References: <1483097531-9991-1-git-send-email-riteshh@codeaurora.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:47332 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753851AbcL3Lct (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 30 Dec 2016 06:32:49 -0500
In-Reply-To: <1483097531-9991-1-git-send-email-riteshh@codeaurora.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, shawn.lin@rock-chips.com, stummala@codeaurora.org, georgi.djakov@linaro.org, linux-arm-msm@vger.kernel.org, pramod.gurav@linaro.org, jeremymc@redhat.com, venkatg@codeaurora.org, asutoshd@codeaurora.org, subhashj@codeaurora.org, Ritesh Harjani <riteshh@codeaurora.org>

From: Sahitya Tummala <stummala@codeaurora.org>

Implement ->platform_dumpregs host operation to print the
platform specific registers in addition to standard SDHC
register during error conditions.

Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>
Signed-off-by: Ritesh Harjani <riteshh@codeaurora.org>
---
 drivers/mmc/host/sdhci-msm.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
index 32879b8..1241dbd 100644
--- a/drivers/mmc/host/sdhci-msm.c
+++ b/drivers/mmc/host/sdhci-msm.c
@@ -29,6 +29,11 @@
 #define CORE_VERSION_MAJOR_MASK		(0xf << CORE_VERSION_MAJOR_SHIFT)
 #define CORE_VERSION_MINOR_MASK		0xff
 
+#define CORE_MCI_DATA_CNT	0x30
+#define CORE_MCI_STATUS		0x34
+#define CORE_MCI_FIFO_CNT	0x44
+#define CORE_MCI_STATUS2	0x6c
+
 #define CORE_HC_MODE		0x78
 #define HC_MODE_EN		0x1
 #define CORE_POWER		0x0
@@ -77,6 +82,10 @@
 #define CORE_HC_SELECT_IN_HS400	(6 << 19)
 #define CORE_HC_SELECT_IN_MASK	(7 << 19)
 
+#define CORE_VENDOR_SPEC_FUNC2		0x110
+#define CORE_VENDOR_SPEC_ADMA_ERR_ADDR0	0x114
+#define CORE_VENDOR_SPEC_ADMA_ERR_ADDR1	0x118
+
 #define CORE_CSR_CDC_CTLR_CFG0		0x130
 #define CORE_SW_TRIG_FULL_CALIB		BIT(16)
 #define CORE_HW_AUTOCAL_ENA		BIT(17)
@@ -658,6 +667,30 @@ static int sdhci_msm_hs400_dll_calibration(struct sdhci_host *host)
 	return ret;
 }
 
+static void sdhci_msm_dumpregs(struct sdhci_host *host)
+{
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct sdhci_msm_host *msm_host = sdhci_pltfm_priv(pltfm_host);
+
+	pr_err("----------- PLATFORM REGISTER DUMP -----------\n");
+
+	pr_err("Data cnt: 0x%08x | Fifo cnt: 0x%08x | Int sts: 0x%08x | Int sts2: 0x%08x\n",
+	       readl_relaxed(msm_host->core_mem + CORE_MCI_DATA_CNT),
+	       readl_relaxed(msm_host->core_mem + CORE_MCI_FIFO_CNT),
+	       readl_relaxed(msm_host->core_mem + CORE_MCI_STATUS),
+	       readl_relaxed(msm_host->core_mem + CORE_MCI_STATUS2));
+	pr_err("DLL cfg:  0x%08x | DLL sts:  0x%08x | SDCC ver: 0x%08x\n",
+	       readl_relaxed(host->ioaddr + CORE_DLL_CONFIG),
+	       readl_relaxed(host->ioaddr + CORE_DLL_STATUS),
+	       readl_relaxed(msm_host->core_mem + CORE_MCI_VERSION));
+	pr_err("Vndr func: 0x%08x | Vndr adma err : addr0: 0x%08x addr1: 0x%08x\n",
+	       readl_relaxed(host->ioaddr + CORE_VENDOR_SPEC),
+	       readl_relaxed(host->ioaddr + CORE_VENDOR_SPEC_ADMA_ERR_ADDR0),
+	       readl_relaxed(host->ioaddr + CORE_VENDOR_SPEC_ADMA_ERR_ADDR1));
+	pr_err("Vndr func2: 0x%08x\n",
+	       readl_relaxed(host->ioaddr + CORE_VENDOR_SPEC_FUNC2));
+}
+
 static int sdhci_msm_execute_tuning(struct sdhci_host *host, u32 opcode)
 {
 	int tuning_seq_cnt = 3;
@@ -1035,6 +1068,7 @@ static void sdhci_msm_set_clock(struct sdhci_host *host, unsigned int clock)
 	.set_bus_width = sdhci_set_bus_width,
 	.set_uhs_signaling = sdhci_msm_set_uhs_signaling,
 	.voltage_switch = sdhci_msm_voltage_switch,
+	.platform_dumpregs = sdhci_msm_dumpregs,
 };
 
 static const struct sdhci_pltfm_data sdhci_msm_pdata = {
-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, 
a Linux Foundation Collaborative Project.

