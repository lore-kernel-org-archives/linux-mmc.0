From: Jeremy McNicoll <jeremymc-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH V2 2/4] sdhci: Add quirk for delayed IRQ ACK
Date: Mon, 16 Jan 2017 16:58:47 -0800
Message-ID: <1484614729-26751-3-git-send-email-jeremymc@redhat.com>
References: <1484614729-26751-1-git-send-email-jeremymc@redhat.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1484614729-26751-1-git-send-email-jeremymc-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: andy.gross-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, bjorn.andersson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, riteshh-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, git-LJ92rlH3Dns@public.gmane.org, ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, jszhang-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org, jeremymc-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

On msm8992 it has been observed that IRQs were not getting
ACK'd correctly when clocked at speeds greater than 400KHz.

Signed-off-by: Jeremy McNicoll <jeremymc-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 drivers/mmc/host/sdhci-msm.c |  7 +++++++
 drivers/mmc/host/sdhci.c     | 12 ++++++++++--
 drivers/mmc/host/sdhci.h     |  2 ++
 3 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
index ee01d95..25dc9cb 100644
--- a/drivers/mmc/host/sdhci-msm.c
+++ b/drivers/mmc/host/sdhci-msm.c
@@ -1224,6 +1224,13 @@ static int sdhci_msm_probe(struct platform_device *pdev)
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
index 71654b9..b685b2a 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2678,11 +2678,19 @@ static irqreturn_t sdhci_irq(int irq, void *dev_id)
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
index 766df17..89a10e7 100644
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

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
