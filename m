From: Zach Brown <zach.brown-acOepvfBmUk@public.gmane.org>
Subject: [PATCH v4 2/2] sdhci-of-arasan: Set controller to test mode when xlnx-fails-without-test-cd is present
Date: Tue, 6 Sep 2016 15:34:44 -0500
Message-ID: <1473194084-14485-2-git-send-email-zach.brown@ni.com>
References: <1473194084-14485-1-git-send-email-zach.brown@ni.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1473194084-14485-1-git-send-email-zach.brown-acOepvfBmUk@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
Cc: robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org, soren.brinkmann-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, zach.brown-acOepvfBmUk@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

The sdhci controller on xilinx zynq devices will not function unless
the CD bit is provided. http://www.xilinx.com/support/answers/61064.html
In cases where it is impossible to provide the CD bit in hardware,
setting the controller to test mode and then setting inserted to true
will get the controller to function without the CD bit.

When the device has the property xlnx-fails-without-test-cd the driver
changes the controller to test mode and sets test inserted to true to
make the controller function.

Signed-off-by: Zach Brown <zach.brown-acOepvfBmUk@public.gmane.org>
---
 drivers/mmc/host/sdhci-of-arasan.c | 34 +++++++++++++++++++++++++++++++++-
 drivers/mmc/host/sdhci.h           |  2 ++
 2 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
index b6f4c1d..63b0c2a 100644
--- a/drivers/mmc/host/sdhci-of-arasan.c
+++ b/drivers/mmc/host/sdhci-of-arasan.c
@@ -23,6 +23,7 @@
 #include <linux/of_device.h>
 #include <linux/phy/phy.h>
 #include "sdhci-pltfm.h"
+#include <linux/of.h>
 
 #define SDHCI_ARASAN_CLK_CTRL_OFFSET	0x2c
 
@@ -38,6 +39,10 @@
 struct sdhci_arasan_data {
 	struct clk	*clk_ahb;
 	struct phy	*phy;
+	unsigned int arasan_quirks; /* Arasan deviations from spec */
+
+/* Controller does not have CD wired and will not function normally without */
+#define SDHCI_ARASAN_QUIRK_FAILS_WITHOUT_TEST_CD (1<<0)
 };
 
 static unsigned int sdhci_arasan_get_timeout_clock(struct sdhci_host *host)
@@ -79,12 +84,32 @@ static void sdhci_arasan_set_clock(struct sdhci_host *host, unsigned int clock)
 	}
 }
 
+void sdhci_arasan_reset(struct sdhci_host *host, u8 mask)
+{
+	u8 ctrl;
+	struct sdhci_pltfm_host *pltfm_host;
+	struct sdhci_arasan_data *sdhci_arasan;
+
+	sdhci_reset(host, mask);
+
+	pltfm_host = sdhci_priv(host);
+	sdhci_arasan = sdhci_pltfm_priv(pltfm_host);
+
+	if (sdhci_arasan->arasan_quirks &
+	     SDHCI_ARASAN_QUIRK_FAILS_WITHOUT_TEST_CD) {
+		ctrl = sdhci_readb(host, SDHCI_HOST_CONTROL);
+		ctrl |= SDHCI_CTRL_CDTEST_INS |
+			SDHCI_CTRL_CDTEST_EN;
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
 
@@ -179,6 +204,7 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
 	struct sdhci_host *host;
 	struct sdhci_pltfm_host *pltfm_host;
 	struct sdhci_arasan_data *sdhci_arasan;
+	struct device_node *np = pdev->dev.of_node;
 
 	host = sdhci_pltfm_init(pdev, &sdhci_arasan_pdata,
 				sizeof(*sdhci_arasan));
@@ -215,6 +241,12 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
 	}
 
 	sdhci_get_of_property(pdev);
+
+	if (of_get_property(np, "xlnx-fails-without-test-cd", NULL)) {
+		sdhci_arasan->arasan_quirks |=
+				SDHCI_ARASAN_QUIRK_FAILS_WITHOUT_TEST_CD;
+	}
+
 	pltfm_host->clk = clk_xin;
 
 	ret = mmc_of_parse(host->mmc);
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 609f87c..ac0ba18 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -84,6 +84,8 @@
 #define   SDHCI_CTRL_ADMA32	0x10
 #define   SDHCI_CTRL_ADMA64	0x18
 #define   SDHCI_CTRL_8BITBUS	0x20
+#define  SDHCI_CTRL_CDTEST_INS   0x40
+#define  SDHCI_CTRL_CDTEST_EN    0x80
 
 #define SDHCI_POWER_CONTROL	0x29
 #define  SDHCI_POWER_ON		0x01
-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
