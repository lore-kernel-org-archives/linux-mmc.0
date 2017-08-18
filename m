From: Vijay Viswanath <vviswana@codeaurora.org>
Subject: [PATCH 1/5] mmc: sdhci-msm: fix issue with power irq
Date: Fri, 18 Aug 2017 10:49:38 +0530
Message-ID: <1503033582-48703-2-git-send-email-vviswana@codeaurora.org>
References: <1503033582-48703-1-git-send-email-vviswana@codeaurora.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:59792 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750971AbdHRFUs (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 18 Aug 2017 01:20:48 -0400
In-Reply-To: <1503033582-48703-1-git-send-email-vviswana@codeaurora.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: adrian.hunter@intel.com, ulf.hansson@linaro.org, will.deacon@arm.com
Cc: linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, asutoshd@codeaurora.org, stummala@codeaurora.org, riteshh@codeaurora.org, subhashj@codeaurora.org, Vijay Viswanath <vviswana@codeaurora.org>

From: Subhash Jadavani <subhashj@codeaurora.org>

SDCC controller reset (SW_RST) during probe may trigger power irq if
previous status of PWRCTL was either BUS_ON or IO_HIGH_V. So before we
enable the power irq interrupt in GIC (by registering the interrupt
handler), we need to ensure that any pending power irq interrupt status
is acknowledged otherwise power irq interrupt handler would be fired
prematurely.

Signed-off-by: Subhash Jadavani <subhashj@codeaurora.org>
Signed-off-by: Vijay Viswanath <vviswana@codeaurora.org>
---
 drivers/mmc/host/sdhci-msm.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
index 9d601dc..0957199 100644
--- a/drivers/mmc/host/sdhci-msm.c
+++ b/drivers/mmc/host/sdhci-msm.c
@@ -1128,6 +1128,7 @@ static int sdhci_msm_probe(struct platform_device *pdev)
 	u16 host_version, core_minor;
 	u32 core_version, config;
 	u8 core_major;
+	u32 irq_status, irq_ctl;
 
 	host = sdhci_pltfm_init(pdev, &sdhci_msm_pdata, sizeof(*msm_host));
 	if (IS_ERR(host))
@@ -1250,6 +1251,28 @@ static int sdhci_msm_probe(struct platform_device *pdev)
 			       CORE_VENDOR_SPEC_CAPABILITIES0);
 	}
 
+	/*
+	 * Power on reset state may trigger power irq if previous status of
+	 * PWRCTL was either BUS_ON or IO_HIGH_V. So before enabling pwr irq
+	 * interrupt in GIC, any pending power irq interrupt should be
+	 * acknowledged. Otherwise power irq interrupt handler would be
+	 * fired prematurely.
+	 */
+
+	irq_status = readl_relaxed(msm_host->core_mem + CORE_PWRCTL_STATUS);
+	writel_relaxed(irq_status, msm_host->core_mem + CORE_PWRCTL_CLEAR);
+	irq_ctl = readl_relaxed(msm_host->core_mem + CORE_PWRCTL_CTL);
+	if (irq_status & (CORE_PWRCTL_BUS_ON | CORE_PWRCTL_BUS_OFF))
+		irq_ctl |= CORE_PWRCTL_BUS_SUCCESS;
+	if (irq_status & (CORE_PWRCTL_IO_HIGH | CORE_PWRCTL_IO_LOW))
+		irq_ctl |= CORE_PWRCTL_IO_SUCCESS;
+	writel_relaxed(irq_ctl,	msm_host->core_mem + CORE_PWRCTL_CTL);
+	/*
+	 * Ensure that above writes are propogated before interrupt enablement
+	 * in GIC.
+	 */
+	mb();
+
 	/* Setup IRQ for handling power/voltage tasks with PMIC */
 	msm_host->pwr_irq = platform_get_irq_byname(pdev, "pwr_irq");
 	if (msm_host->pwr_irq < 0) {
@@ -1259,6 +1282,9 @@ static int sdhci_msm_probe(struct platform_device *pdev)
 		goto clk_disable;
 	}
 
+	/* Enable pwr irq interrupts */
+	writel_relaxed(INT_MASK, msm_host->core_mem + CORE_PWRCTL_MASK);
+
 	ret = devm_request_threaded_irq(&pdev->dev, msm_host->pwr_irq, NULL,
 					sdhci_msm_pwr_irq, IRQF_ONESHOT,
 					dev_name(&pdev->dev), host);
-- 
 Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc. 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.

