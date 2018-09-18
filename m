From: Manish Narani <manish.narani@xilinx.com>
Subject: [RFC PATCH 3/4] mmc: sdhci-of-arasan: Add auto tuning support for ZynqMP platform
Date: Tue, 18 Sep 2018 19:15:38 +0530
Message-ID: <1537278339-9257-4-git-send-email-manish.narani@xilinx.com>
References: <1537278339-9257-1-git-send-email-manish.narani@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1537278339-9257-1-git-send-email-manish.narani@xilinx.com>
Sender: linux-kernel-owner@vger.kernel.org
To: ulf.hansson@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, michal.simek@xilinx.com, adrian.hunter@intel.com, manish.narani@xilinx.com, leoyang.li@nxp.com, sudeep.holla@arm.com, olof@lixom.net, amit.kucheria@linaro.org, rajanv@xilinx.com, jollys@xilinx.com
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

Add support of SD auto tuning for ZynqMP platform. Before tuning
execution, reset the DLL and after the auto tuning process gets
completed, reset the DLL to load the newly obtained SDHC tuned tap
value.

Signed-off-by: Manish Narani <manish.narani@xilinx.com>
---
 drivers/mmc/host/sdhci-of-arasan.c | 83 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 83 insertions(+)

diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
index a40bcc2..1a8bbd2 100644
--- a/drivers/mmc/host/sdhci-of-arasan.c
+++ b/drivers/mmc/host/sdhci-of-arasan.c
@@ -26,6 +26,7 @@
 #include <linux/phy/phy.h>
 #include <linux/regmap.h>
 #include <linux/of.h>
+#include <linux/firmware/xlnx-zynqmp.h>
 
 #include "cqhci.h"
 #include "sdhci-pltfm.h"
@@ -98,6 +99,7 @@ struct sdhci_arasan_data {
 
 	struct regmap	*soc_ctl_base;
 	const struct sdhci_arasan_soc_ctl_map *soc_ctl_map;
+	unsigned int	device_id;
 	unsigned int	quirks; /* Arasan deviations from spec */
 
 /* Controller does not have CD wired and will not function normally without */
@@ -163,6 +165,72 @@ static int sdhci_arasan_syscon_write(struct sdhci_host *host,
 	return ret;
 }
 
+static void zynqmp_dll_reset(u8 deviceid)
+{
+	const struct zynqmp_eemi_ops *eemi_ops = zynqmp_pm_get_eemi_ops();
+
+	if (!eemi_ops || !eemi_ops->ioctl)
+		return;
+
+	/* Issue DLL Reset */
+	if (deviceid == 0)
+		eemi_ops->ioctl(NODE_SD_0, IOCTL_SD_DLL_RESET,
+				PM_DLL_RESET_PULSE, 0, NULL);
+	else
+		eemi_ops->ioctl(NODE_SD_1, IOCTL_SD_DLL_RESET,
+				PM_DLL_RESET_PULSE, 0, NULL);
+}
+
+static void arasan_zynqmp_dll_reset(struct sdhci_host *host, u8 deviceid)
+{
+	u16 clk;
+	unsigned long timeout;
+
+	clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
+	clk &= ~(SDHCI_CLOCK_CARD_EN | SDHCI_CLOCK_INT_EN);
+	sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
+
+	/* Issue DLL Reset */
+	zynqmp_dll_reset(deviceid);
+
+	clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
+	clk |= SDHCI_CLOCK_INT_EN;
+	sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
+
+	/* Wait max 20 ms */
+	timeout = 20;
+	while (!((clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL))
+				& SDHCI_CLOCK_INT_STABLE)) {
+		if (timeout == 0) {
+			dev_err(mmc_dev(host->mmc),
+				": Internal clock never stabilised.\n");
+			return;
+		}
+		timeout--;
+		mdelay(1);
+	}
+
+	clk |= SDHCI_CLOCK_CARD_EN;
+	sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
+}
+
+static int arasan_zynqmp_execute_tuning(struct mmc_host *mmc, u32 opcode) {
+	struct sdhci_host *host = mmc_priv(mmc);
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct sdhci_arasan_data *sdhci_arasan = sdhci_pltfm_priv(pltfm_host);
+	int err;
+
+	arasan_zynqmp_dll_reset(host, sdhci_arasan->device_id);
+
+	err = sdhci_execute_tuning(mmc, opcode);
+	if (err)
+		return err;
+
+	arasan_zynqmp_dll_reset(host, sdhci_arasan->device_id);
+
+	return 0;
+}
+
 static void sdhci_arasan_set_clock(struct sdhci_host *host, unsigned int clock)
 {
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
@@ -469,6 +537,7 @@ static const struct of_device_id sdhci_arasan_of_match[] = {
 	{ .compatible = "arasan,sdhci-8.9a" },
 	{ .compatible = "arasan,sdhci-5.1" },
 	{ .compatible = "arasan,sdhci-4.9a" },
+	{ .compatible = "xlnx,zynqmp-8.9a" },
 
 	{ /* sentinel */ }
 };
@@ -792,6 +861,20 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
 		goto unreg_clk;
 	}
 
+	if (of_device_is_compatible(pdev->dev.of_node, "xlnx,zynqmp-8.9a")) {
+		ret = of_property_read_u32(pdev->dev.of_node,
+					   "xlnx,device_id",
+					   &sdhci_arasan->device_id);
+		if (ret < 0) {
+			dev_err(&pdev->dev,
+				"\"xlnx,device_id \" property is missing.\n");
+			goto unreg_clk;
+		}
+
+		host->mmc_host_ops.execute_tuning =
+			arasan_zynqmp_execute_tuning;
+	}
+
 	sdhci_arasan->phy = ERR_PTR(-ENODEV);
 	if (of_device_is_compatible(pdev->dev.of_node,
 				    "arasan,sdhci-5.1")) {
-- 
2.1.1
