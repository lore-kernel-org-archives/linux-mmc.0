From: Zach Brown <zach.brown@ni.com>
Subject: [RESEND PATCH v7 2/2] sdhci-of-arasan: Set controller to test mode when xlnx,fails-without-test-cd is present
Date: Fri, 16 Sep 2016 10:01:42 -0500
Message-ID: <1474038102-20937-2-git-send-email-zach.brown@ni.com>
References: <1474038102-20937-1-git-send-email-zach.brown@ni.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1474038102-20937-1-git-send-email-zach.brown@ni.com>
Sender: linux-kernel-owner@vger.kernel.org
To: adrian.hunter@intel.com
Cc: robh+dt@kernel.org, ulf.hansson@linaro.org, mark.rutland@arm.com, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, michal.simek@xilinx.com, soren.brinkmann@xilinx.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

The sdhci controller on xilinx zynq devices will not function unless
the CD bit is provided. http://www.xilinx.com/support/answers/61064.html
In cases where it is impossible to provide the CD bit in hardware,
setting the controller to test mode and then setting inserted to true
will get the controller to function without the CD bit.

When the device has the property xlnx,fails-without-test-cd the driver
changes the controller to test mode and sets test inserted to true to
make the controller function.

Signed-off-by: Zach Brown <zach.brown@ni.com>
---
 drivers/mmc/host/sdhci-of-arasan.c | 27 ++++++++++++++++++++++++++-
 drivers/mmc/host/sdhci.h           |  2 ++
 2 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
index 33601a8..da8e40a 100644
--- a/drivers/mmc/host/sdhci-of-arasan.c
+++ b/drivers/mmc/host/sdhci-of-arasan.c
@@ -26,6 +26,7 @@
 #include <linux/phy/phy.h>
 #include <linux/regmap.h>
 #include "sdhci-pltfm.h"
+#include <linux/of.h>
 
 #define SDHCI_ARASAN_CLK_CTRL_OFFSET	0x2c
 #define SDHCI_ARASAN_VENDOR_REGISTER	0x78
@@ -98,6 +99,10 @@ struct sdhci_arasan_data {
 
 	struct regmap	*soc_ctl_base;
 	const struct sdhci_arasan_soc_ctl_map *soc_ctl_map;
+	unsigned int	quirks; /* Arasan deviations from spec */
+
+/* Controller does not have CD wired and will not function normally without */
+#define SDHCI_ARASAN_QUIRK_FORCE_CDTEST	BIT(0)
 };
 
 static const struct sdhci_arasan_soc_ctl_map rk3399_soc_ctl_map = {
@@ -245,12 +250,27 @@ static void sdhci_arasan_hs400_enhanced_strobe(struct mmc_host *mmc,
 	writel(vendor, host->ioaddr + SDHCI_ARASAN_VENDOR_REGISTER);
 }
 
+void sdhci_arasan_reset(struct sdhci_host *host, u8 mask)
+{
+	u8 ctrl;
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct sdhci_arasan_data *sdhci_arasan = sdhci_pltfm_priv(pltfm_host);
+
+	sdhci_reset(host, mask);
+
+	if (sdhci_arasan->quirks & SDHCI_ARASAN_QUIRK_FORCE_CDTEST) {
+		ctrl = sdhci_readb(host, SDHCI_HOST_CONTROL);
+		ctrl |= SDHCI_CTRL_CDTEST_INS | SDHCI_CTRL_CDTEST_EN;
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
 
@@ -545,6 +565,7 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
 	struct sdhci_host *host;
 	struct sdhci_pltfm_host *pltfm_host;
 	struct sdhci_arasan_data *sdhci_arasan;
+	struct device_node *np = pdev->dev.of_node;
 
 	host = sdhci_pltfm_init(pdev, &sdhci_arasan_pdata,
 				sizeof(*sdhci_arasan));
@@ -599,6 +620,10 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
 	}
 
 	sdhci_get_of_property(pdev);
+
+	if (of_property_read_bool(np, "xlnx,fails-without-test-cd"))
+		sdhci_arasan->quirks |= SDHCI_ARASAN_QUIRK_FORCE_CDTEST;
+
 	pltfm_host->clk = clk_xin;
 
 	if (of_device_is_compatible(pdev->dev.of_node,
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index a2bc9e1..c722cd2 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -84,6 +84,8 @@
 #define   SDHCI_CTRL_ADMA32	0x10
 #define   SDHCI_CTRL_ADMA64	0x18
 #define   SDHCI_CTRL_8BITBUS	0x20
+#define  SDHCI_CTRL_CDTEST_INS	0x40
+#define  SDHCI_CTRL_CDTEST_EN	0x80
 
 #define SDHCI_POWER_CONTROL	0x29
 #define  SDHCI_POWER_ON		0x01
-- 
2.7.4
