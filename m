From: Jeremy McNicoll <jeremymc@redhat.com>
Subject: [PATCH V3 2/6] sdhci: Add quirk for delayed IRQ ACK
Date: Tue, 24 Jan 2017 01:36:24 -0800
Message-ID: <1485250588-24698-3-git-send-email-jeremymc@redhat.com>
References: <1485250588-24698-1-git-send-email-jeremymc@redhat.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:36626 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750742AbdAXJgj (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 24 Jan 2017 04:36:39 -0500
In-Reply-To: <1485250588-24698-1-git-send-email-jeremymc@redhat.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org
Cc: andy.gross@linaro.org, sboyd@codeaurora.org, robh@kernel.org, arnd@arndb.de, bjorn.andersson@linaro.org, riteshh@codeaurora.org, git@kchr.de, ulf.hansson@linaro.org, jszhang@marvell.com, jeremymc@redhat.com

On msm8992 it has been observed that IRQs were not getting
ACK'd correctly when clocked at speeds greater than 400KHz.

Signed-off-by: Jeremy McNicoll <jeremymc@redhat.com>
---
 drivers/mmc/host/sdhci-msm.c |  7 +++++++
 drivers/mmc/host/sdhci.c     | 12 ++++++++++--
 drivers/mmc/host/sdhci.h     |  2 ++
 3 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
index f3f3fb3..11dc389 100644
--- a/drivers/mmc/host/sdhci-msm.c
+++ b/drivers/mmc/host/sdhci-msm.c
@@ -1304,6 +1304,13 @@ static int sdhci_msm_probe(struct platform_device *pdev)
 			       CORE_VENDOR_SPEC_CAPABILITIES0);
 	}
 
+	/* Enable delayed IRQ handling workaround on 8992 */
+	if (core_major == 1 && core_minor == 0x3e) {
+		/* Add 40us delay in interrupt handler when operating
+		 * at initialization frequency of 400KHz. */
+		host->quirks2 |= SDHCI_QUIRK2_SLOW_INT_CLR;
+	}
+
 	/* Setup IRQ for handling power/voltage tasks with PMIC */
 	msm_host->pwr_irq = platform_get_irq_byname(pdev, "pwr_irq");
 	if (msm_host->pwr_irq < 0) {
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 06dfac2..68a21a3 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2742,11 +2742,19 @@ static irqreturn_t sdhci_irq(int irq, void *dev_id)
 			result = IRQ_WAKE_THREAD;
 		}
 
-		if (intmask & SDHCI_INT_CMD_MASK)
+		if (intmask & SDHCI_INT_CMD_MASK) {
+			if ((host->quirks2 & SDHCI_QUIRK2_SLOW_INT_CLR) && (host->clock <= 400000)) {
+				udelay(40);
+			}
 			sdhci_cmd_irq(host, intmask & SDHCI_INT_CMD_MASK);
+		}
 
-		if (intmask & SDHCI_INT_DATA_MASK)
+		if (intmask & SDHCI_INT_DATA_MASK) {
+			if ((host->quirks2 & SDHCI_QUIRK2_SLOW_INT_CLR) && (host->clock <= 400000)) {
+				udelay(40);
+			}
 			sdhci_data_irq(host, intmask & SDHCI_INT_DATA_MASK);
+		}
 
 		if (intmask & SDHCI_INT_BUS_POWER)
 			pr_err("%s: Card is consuming too much power!\n",
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 400f3a1..7fa1004 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -24,6 +24,8 @@
  * Controller registers
  */
 
+#define SDHCI_QUIRK2_SLOW_INT_CLR	(1<<5)
+
 #define SDHCI_DMA_ADDRESS	0x00
 #define SDHCI_ARGUMENT2		SDHCI_DMA_ADDRESS
 
-- 
2.6.1

