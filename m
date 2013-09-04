From: Dong Aisheng <b29396@freescale.com>
Subject: [PATCH 3/8] sdhci: sdhci-esdhc-imx: support real clock on and off for imx6q
Date: Wed, 4 Sep 2013 20:54:12 +0800
Message-ID: <1378299257-2980-4-git-send-email-b29396@freescale.com>
References: <1378299257-2980-1-git-send-email-b29396@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from co1ehsobe006.messaging.microsoft.com ([216.32.180.189]:53971
	"EHLO co1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1760087Ab3IDNBU (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 4 Sep 2013 09:01:20 -0400
In-Reply-To: <1378299257-2980-1-git-send-email-b29396@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: cjb@laptop.org, anton@enomsg.org, shawn.guo@linaro.org, linux-arm-kernel@lists.infradead.org, s.hauer@pengutronix.de, b29396@freescale.com

The signal voltage switch follow requires to shutdown and output
clock in a specific sequence according to standard host controller
v3.0 spec. In that timing, the card must really receive clock or not.

However, for i.MX6Q, the uSDHC will not output clock even the clock
is enabled until there is command or data in transfer on the bus,
which will then cause singal voltage switch always to fail.

For i.MX6Q, we clear ESDHC_VENDOR_SPEC_FRC_SDCLK_ON bit to let
controller to gate off clock automatically and set that bit
to force clock output if clock is on.

This is required by SD3.0 support.

Signed-off-by: Dong Aisheng <b29396@freescale.com>
---
 drivers/mmc/host/sdhci-esdhc-imx.c |    3 ---
 drivers/mmc/host/sdhci-esdhc.h     |   29 ++++++++++++++++++++++++++---
 2 files changed, 26 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index 1dd5ba8..3118a82 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -31,9 +31,6 @@
 #include "sdhci-esdhc.h"
 
 #define	ESDHC_CTRL_D3CD			0x08
-/* VENDOR SPEC register */
-#define ESDHC_VENDOR_SPEC		0xc0
-#define  ESDHC_VENDOR_SPEC_SDIO_QUIRK	(1 << 1)
 #define ESDHC_WTMK_LVL			0x44
 #define ESDHC_MIX_CTRL			0x48
 #define  ESDHC_MIX_CTRL_AC23EN		(1 << 7)
diff --git a/drivers/mmc/host/sdhci-esdhc.h b/drivers/mmc/host/sdhci-esdhc.h
index a2a0642..86fcd5b 100644
--- a/drivers/mmc/host/sdhci-esdhc.h
+++ b/drivers/mmc/host/sdhci-esdhc.h
@@ -14,6 +14,8 @@
 #ifndef _DRIVERS_MMC_SDHCI_ESDHC_H
 #define _DRIVERS_MMC_SDHCI_ESDHC_H
 
+#include <linux/of.h>
+
 /*
  * Ops and quirks for the Freescale eSDHC controller.
  */
@@ -33,6 +35,12 @@
 #define ESDHC_CLOCK_HCKEN	0x00000002
 #define ESDHC_CLOCK_IPGEN	0x00000001
 
+/* VENDOR SPEC register */
+#define ESDHC_VENDOR_SPEC		0xc0
+#define  ESDHC_VENDOR_SPEC_SDIO_QUIRK	(1 << 1)
+#define  ESDHC_VENDOR_SPEC_VSELECT	(1 << 1)
+#define  ESDHC_VENDOR_SPEC_FRC_SDCLK_ON (1 << 8)
+
 /* pltfm-specific */
 #define ESDHC_HOST_CONTROL_LE	0x20
 
@@ -52,12 +60,20 @@
 static inline void esdhc_set_clock(struct sdhci_host *host, unsigned int clock,
 				   unsigned int host_clock)
 {
+	struct device *dev;
 	int pre_div = 2;
 	int div = 1;
-	u32 temp;
-
-	if (clock == 0)
+	u32 temp, val;
+
+	dev = mmc_dev(host->mmc);
+	if (clock == 0) {
+		if (of_device_is_compatible(dev->of_node, "fsl,imx6q-usdhc")) {
+			val = readl(host->ioaddr + ESDHC_VENDOR_SPEC);
+			writel(val & ~ESDHC_VENDOR_SPEC_FRC_SDCLK_ON,
+				host->ioaddr + ESDHC_VENDOR_SPEC);
+		}
 		goto out;
+	}
 
 	temp = sdhci_readl(host, ESDHC_SYSTEM_CONTROL);
 	temp &= ~(ESDHC_CLOCK_IPGEN | ESDHC_CLOCK_HCKEN | ESDHC_CLOCK_PEREN
@@ -81,6 +97,13 @@ static inline void esdhc_set_clock(struct sdhci_host *host, unsigned int clock,
 		| (div << ESDHC_DIVIDER_SHIFT)
 		| (pre_div << ESDHC_PREDIV_SHIFT));
 	sdhci_writel(host, temp, ESDHC_SYSTEM_CONTROL);
+
+	if (of_device_is_compatible(dev->of_node, "fsl,imx6q-usdhc")) {
+		val = readl(host->ioaddr + ESDHC_VENDOR_SPEC);
+		writel(val | ESDHC_VENDOR_SPEC_FRC_SDCLK_ON,
+			host->ioaddr + ESDHC_VENDOR_SPEC);
+	}
+
 	mdelay(1);
 out:
 	host->clock = clock;
-- 
1.7.1


