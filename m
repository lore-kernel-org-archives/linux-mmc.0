From: Zach Brown <zach.brown-acOepvfBmUk@public.gmane.org>
Subject: [PATCH 2/2] sdhci-of-arasan: Add quirk and device tree parameter to fake CD bit
Date: Wed, 24 Aug 2016 18:23:04 -0500
Message-ID: <1472080984-17373-2-git-send-email-zach.brown@ni.com>
References: <1472080984-17373-1-git-send-email-zach.brown@ni.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1472080984-17373-1-git-send-email-zach.brown-acOepvfBmUk@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
Cc: robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org, soren.brinkmann-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

The sdhci controller on xilinx zynq devices will not function unless
the cd bit is provided. http://www.xilinx.com/support/answers/61064.html
In cases where it is impossible to provide the cd bit in hardware,
setting the controller to test mode and then setting inserted to true
will get the controller to function with out the cd bit.

The device property "fake-cd" will let the arasan driver know it needs
to fake the cd bit for the controller inorder for the controller to
function with a SD card that does not provide the CD bit.

Signed-off-by: Zach Brown <zach.brown-acOepvfBmUk@public.gmane.org>
---
 drivers/mmc/host/sdhci-of-arasan.c | 23 ++++++++++++++++++++++-
 drivers/mmc/host/sdhci.h           |  4 ++++
 2 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
index e0f193f..a74bcf5 100644
--- a/drivers/mmc/host/sdhci-of-arasan.c
+++ b/drivers/mmc/host/sdhci-of-arasan.c
@@ -26,6 +26,7 @@
 #include <linux/phy/phy.h>
 #include <linux/regmap.h>
 #include "sdhci-pltfm.h"
+#include <linux/of.h>
 
 #define SDHCI_ARASAN_CLK_CTRL_OFFSET	0x2c
 #define SDHCI_ARASAN_VENDOR_REGISTER	0x78
@@ -203,12 +204,26 @@ static void sdhci_arasan_hs400_enhanced_strobe(struct mmc_host *mmc,
 	writel(vendor, host->ioaddr + SDHCI_ARASAN_VENDOR_REGISTER);
 }
 
+void sdhci_arasan_reset(struct sdhci_host *host, u8 mask)
+{
+	u8 ctrl;
+
+	sdhci_reset(host, mask);
+
+	if (host->quirks2 & SDHCI_QUIRK2_NEED_FAKE_CD) {
+		ctrl = sdhci_readl(host, SDHCI_HOST_CONTROL);
+		ctrl |= SDHCI_CTRL_CD_TEST_INSERTED |
+		SDHCI_CTRL_CD_TEST_ENABLE;
+		sdhci_writeb(host, ctrl, SDHCI_HOST_CONTROL);
+	}
+}
+
 static struct sdhci_ops sdhci_arasan_ops = {
 	.set_clock = sdhci_arasan_set_clock,
 	.get_max_clock = sdhci_pltfm_clk_get_max_clock,
 	.get_timeout_clock = sdhci_arasan_get_timeout_clock,
 	.set_bus_width = sdhci_set_bus_width,
-	.reset = sdhci_reset,
+	.reset = sdhci_arasan_reset,
 	.set_uhs_signaling = sdhci_set_uhs_signaling,
 };
 
@@ -516,6 +531,12 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
 	}
 
 	sdhci_get_of_property(pdev);
+
+	if (of_get_property(pdev->dev.of_node, "fake-cd", NULL))
+		host->quirks2 |= SDHCI_QUIRK2_NEED_FAKE_CD;
+
+	pltfm_host = sdhci_priv(host);
+	pltfm_host->priv = sdhci_arasan;
 	pltfm_host->clk = clk_xin;
 
 	sdhci_arasan_update_baseclkfreq(host);
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 0411c9f..ff3c8ba 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -84,6 +84,8 @@
 #define   SDHCI_CTRL_ADMA32	0x10
 #define   SDHCI_CTRL_ADMA64	0x18
 #define   SDHCI_CTRL_8BITBUS	0x20
+#define  SDHCI_CTRL_CD_TEST_INSERTED   0x40
+#define  SDHCI_CTRL_CD_TEST_ENABLE     0x80
 
 #define SDHCI_POWER_CONTROL	0x29
 #define  SDHCI_POWER_ON		0x01
@@ -422,6 +424,8 @@ struct sdhci_host {
 #define SDHCI_QUIRK2_ACMD23_BROKEN			(1<<14)
 /* Broken Clock divider zero in controller */
 #define SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN		(1<<15)
+/* Controller needs the cd bit faked */
+#define SDHCI_QUIRK2_NEED_FAKE_CD (1<<16)
 
 	int irq;		/* Device IRQ */
 	void __iomem *ioaddr;	/* Mapped address */
-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
