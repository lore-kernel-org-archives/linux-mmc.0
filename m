From: Ritesh Harjani <riteshh@codeaurora.org>
Subject: [PATCH 06/10] mmc: sdhci: Add SDHCI_QUIRK2_ALWAYS_USE_BASE_CLOCK quirk2 support
Date: Wed, 10 Aug 2016 20:31:55 +0530
Message-ID: <1470841319-6091-7-git-send-email-riteshh@codeaurora.org>
References: <1470841319-6091-1-git-send-email-riteshh@codeaurora.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:53454 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935727AbcHJSlG (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 10 Aug 2016 14:41:06 -0400
In-Reply-To: <1470841319-6091-1-git-send-email-riteshh@codeaurora.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, adrian.hunter@intel.com
Cc: linux-arm-msm@vger.kernel.org, georgi.djakov@linaro.org, alex.lemberg@sandisk.com, mateusz.nowak@intel.com, Yuliy.Izrailov@sandisk.com, asutoshd@codeaurora.org, sthumma@codeaurora.org, kdorfman@codeaurora.org, david.griego@linaro.org, stummala@codeaurora.org, venkatg@codeaurora.org, Ritesh Harjani <riteshh@codeaurora.org>

From: Sahitya Tummala <stummala@codeaurora.org>

MSM controller uses the base clock and does not use any divider.
The driver will use SDHCI_QUIRK2_ALWAYS_USE_BASE_CLOCK
and controls the base clock (MCLK) directly.

Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>
Signed-off-by: Ritesh Harjani <riteshh@codeaurora.org>
---
 drivers/mmc/host/sdhci.c | 4 ++++
 drivers/mmc/host/sdhci.h | 6 ++++++
 2 files changed, 10 insertions(+)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index cd65d47..a5c9dcb 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1318,6 +1318,10 @@ u16 sdhci_calc_clk(struct sdhci_host *host, unsigned int clock,
 clock_set:
 	if (real_div)
 		*actual_clock = (host->max_clk * clk_mul) / real_div;
+
+	if (host->quirks2 & SDHCI_QUIRK2_ALWAYS_USE_BASE_CLOCK)
+		div = 0;
+
 	clk |= (div & SDHCI_DIV_MASK) << SDHCI_DIVIDER_SHIFT;
 	clk |= ((div & SDHCI_DIV_HI_MASK) >> SDHCI_DIV_MASK_LEN)
 		<< SDHCI_DIVIDER_HI_SHIFT;
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 0411c9f..566c0fe 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -422,6 +422,12 @@ struct sdhci_host {
 #define SDHCI_QUIRK2_ACMD23_BROKEN			(1<<14)
 /* Broken Clock divider zero in controller */
 #define SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN		(1<<15)
+/*
+ * If the base clock can be scalable, then there should be no further
+ * clock dividing as the input clock itself will be scaled down to
+ * required frequency.
+ */
+#define SDHCI_QUIRK2_ALWAYS_USE_BASE_CLOCK		(1<<16)
 
 	int irq;		/* Device IRQ */
 	void __iomem *ioaddr;	/* Mapped address */
-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, 
a Linux Foundation Collaborative Project.

