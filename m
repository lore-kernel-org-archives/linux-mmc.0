From: Manish Narani <manish.narani@xilinx.com>
Subject: [RFC PATCH v2 3/4] sdhci: arasan: Add support to read and set tap delays from DT for ZynqMP
Date: Thu, 20 Sep 2018 15:00:44 +0530
Message-ID: <1537435845-6682-4-git-send-email-manish.narani@xilinx.com>
References: <1537435845-6682-1-git-send-email-manish.narani@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1537435845-6682-1-git-send-email-manish.narani@xilinx.com>
Sender: linux-kernel-owner@vger.kernel.org
To: ulf.hansson@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, michal.simek@xilinx.com, adrian.hunter@intel.com, manish.narani@xilinx.com, amit.kucheria@linaro.org, sudeep.holla@arm.com, leoyang.li@nxp.com, jollys@xilinx.com, rajanv@xilinx.com
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

Apart from taps set by auto tuning, ZynqMP platform has feature to set
the tap values manually. Add support to read tap delay values from
DT and set the same in HW via ZynqMP SoC framework. Reading Tap
Delays from DT is optional, if the property is not available in DT the
driver will use the pre-defined Tap Delay Values.

Signed-off-by: Manish Narani <manish.narani@xilinx.com>
---
 drivers/firmware/xilinx/Makefile            |   1 +
 drivers/firmware/xilinx/zynqmp-tap-delays.c |  39 +++++
 drivers/mmc/host/sdhci-of-arasan.c          | 215 ++++++++++++++++++++++++++++
 include/linux/firmware/xlnx-zynqmp.h        |   4 +
 4 files changed, 259 insertions(+)
 create mode 100644 drivers/firmware/xilinx/zynqmp-tap-delays.c

diff --git a/drivers/firmware/xilinx/Makefile b/drivers/firmware/xilinx/Makefile
index 875a537..c32b2a3 100644
--- a/drivers/firmware/xilinx/Makefile
+++ b/drivers/firmware/xilinx/Makefile
@@ -2,4 +2,5 @@
 # Makefile for Xilinx firmwares
 
 obj-$(CONFIG_ZYNQMP_FIRMWARE) += zynqmp.o
+obj-$(CONFIG_ZYNQMP_FIRMWARE) += zynqmp-tap-delays.o
 obj-$(CONFIG_ZYNQMP_FIRMWARE_DEBUG) += zynqmp-debug.o
diff --git a/drivers/firmware/xilinx/zynqmp-tap-delays.c b/drivers/firmware/xilinx/zynqmp-tap-delays.c
new file mode 100644
index 0000000..2e5cab3
--- /dev/null
+++ b/drivers/firmware/xilinx/zynqmp-tap-delays.c
@@ -0,0 +1,39 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Xilinx Zynq MPSoC Tap Delay Programming
+ *
+ *  Copyright (C) 2014-2018 Xilinx, Inc.
+ *
+ *  Manish Narani <mnarani@xilinx.com>
+ */
+
+#include <linux/delay.h>
+#include <linux/types.h>
+#include <linux/firmware/xlnx-zynqmp.h>
+
+/**
+ * zynqmp_set_tap_delay - Program the tap delays.
+ * @deviceid:		Unique Id of device
+ * @itap_delay:		Input Tap Delay
+ * @oitap_delay:	Output Tap Delay
+ */
+void zynqmp_set_tap_delay(u8 deviceid, u8 itap_delay, u8 otap_delay)
+{
+	const struct zynqmp_eemi_ops *eemi_ops = zynqmp_pm_get_eemi_ops();
+	u32 node_id = (deviceid == 0) ? NODE_SD_0 : NODE_SD_1;
+
+	if (!eemi_ops || !eemi_ops->ioctl)
+		return;
+
+	/* Set the Input Tap Delay */
+	if (itap_delay)
+		eemi_ops->ioctl(node_id, IOCTL_SET_SD_TAPDELAY,
+				PM_TAPDELAY_INPUT, itap_delay, NULL);
+
+	/* Set the Output Tap Delay */
+	if (otap_delay)
+		eemi_ops->ioctl(node_id, IOCTL_SET_SD_TAPDELAY,
+				PM_TAPDELAY_OUTPUT, otap_delay, NULL);
+}
+EXPORT_SYMBOL_GPL(zynqmp_set_tap_delay);
+
diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
index 1a8bbd2..57f89af 100644
--- a/drivers/mmc/host/sdhci-of-arasan.c
+++ b/drivers/mmc/host/sdhci-of-arasan.c
@@ -77,6 +77,18 @@ struct sdhci_arasan_soc_ctl_map {
 };
 
 /**
+ * struct sdhci_arasan_zynqmp_data
+ * @mio_bank		Memory IO Bank number
+ * @itapdly		Input Tap Delays array for different host timings
+ * @otapdly		Output Tap Delays array for different host timings
+ */
+struct sdhci_arasan_zynqmp_data {
+	u32 mio_bank;
+	u32 itapdly[MMC_TIMING_MMC_HS400 + 1];
+	u32 otapdly[MMC_TIMING_MMC_HS400 + 1];
+};
+
+/**
  * struct sdhci_arasan_data
  * @host:		Pointer to the main SDHCI host structure.
  * @clk_ahb:		Pointer to the AHB clock
@@ -99,6 +111,7 @@ struct sdhci_arasan_data {
 
 	struct regmap	*soc_ctl_base;
 	const struct sdhci_arasan_soc_ctl_map *soc_ctl_map;
+	struct sdhci_arasan_zynqmp_data zynqmp_data;
 	unsigned int	device_id;
 	unsigned int	quirks; /* Arasan deviations from spec */
 
@@ -235,7 +248,11 @@ static void sdhci_arasan_set_clock(struct sdhci_host *host, unsigned int clock)
 {
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
 	struct sdhci_arasan_data *sdhci_arasan = sdhci_pltfm_priv(pltfm_host);
+	struct device *dev = mmc_dev(host->mmc);
+	unsigned int timing = host->timing;
 	bool ctrl_phy = false;
+	u8 itap_delay;
+	u8 otap_delay;
 
 	if (!IS_ERR(sdhci_arasan->phy)) {
 		if (!sdhci_arasan->is_phy_on && clock <= PHY_CLK_TOO_SLOW_HZ) {
@@ -278,6 +295,17 @@ static void sdhci_arasan_set_clock(struct sdhci_host *host, unsigned int clock)
 
 	sdhci_set_clock(host, clock);
 
+	if (of_device_is_compatible(dev->of_node, "xlnx,zynqmp-8.9a")) {
+		if ((host->version >= SDHCI_SPEC_300) &&
+		    (timing != MMC_TIMING_LEGACY) &&
+		    (timing != MMC_TIMING_UHS_SDR12)) {
+			itap_delay = sdhci_arasan->zynqmp_data.itapdly[timing];
+			otap_delay = sdhci_arasan->zynqmp_data.otapdly[timing];
+			zynqmp_set_tap_delay(sdhci_arasan->device_id,
+					     itap_delay, otap_delay);
+		}
+	}
+
 	if (sdhci_arasan->quirks & SDHCI_ARASAN_QUIRK_CLOCK_UNSTABLE)
 		/*
 		 * Some controllers immediately report SDHCI_CLOCK_INT_STABLE
@@ -723,6 +751,182 @@ static void sdhci_arasan_unregister_sdclk(struct device *dev)
 	of_clk_del_provider(dev->of_node);
 }
 
+/**
+ * arasan_zynqmp_dt_parse_tap_delays - Read Tap Delay values from DT
+ *
+ * Called at initialization to parse the values of Tap Delays.
+ *
+ * @dev:		Pointer to our struct device.
+ */
+static void arasan_zynqmp_dt_parse_tap_delays(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct sdhci_host *host = platform_get_drvdata(pdev);
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct sdhci_arasan_data *sdhci_arasan = sdhci_pltfm_priv(pltfm_host);
+	u32 mio_bank = sdhci_arasan->zynqmp_data.mio_bank;
+	u32 *itapdly = sdhci_arasan->zynqmp_data.itapdly;
+	u32 *otapdly = sdhci_arasan->zynqmp_data.otapdly;
+	struct device_node *np = dev->of_node;
+	int ret;
+
+	/*
+	 * Read Tap Delay values from DT, if the DT does not contain the
+	 * Tap Values then use the pre-defined values
+	 */
+	ret = of_property_read_u32(np, "xlnx,itap-delay-sd-hsd",
+				   &itapdly[MMC_TIMING_SD_HS]);
+	if (ret) {
+		dev_dbg(dev,
+			"Using predefined itapdly for MMC_TIMING_SD_HS\n");
+		itapdly[MMC_TIMING_SD_HS] = ZYNQMP_ITAPDLYSEL_SD_HSD;
+	}
+
+	ret = of_property_read_u32(np, "xlnx,otap-delay-sd-hsd",
+				   &otapdly[MMC_TIMING_SD_HS]);
+	if (ret) {
+		dev_dbg(dev,
+			"Using predefined otapdly for MMC_TIMING_SD_HS\n");
+		otapdly[MMC_TIMING_SD_HS] = ZYNQMP_OTAPDLYSEL_SD_HSD;
+	}
+
+	ret = of_property_read_u32(np, "xlnx,itap-delay-sdr25",
+				   &itapdly[MMC_TIMING_UHS_SDR25]);
+	if (ret) {
+		dev_dbg(dev,
+			"Using predefined itapdly for MMC_TIMING_UHS_SDR25\n");
+		itapdly[MMC_TIMING_UHS_SDR25] = ZYNQMP_ITAPDLYSEL_SDR25;
+	}
+
+	ret = of_property_read_u32(np, "xlnx,otap-delay-sdr25",
+				   &otapdly[MMC_TIMING_UHS_SDR25]);
+	if (ret) {
+		dev_dbg(dev,
+			"Using predefined otapdly for MMC_TIMING_UHS_SDR25\n");
+		otapdly[MMC_TIMING_UHS_SDR25] = ZYNQMP_OTAPDLYSEL_SDR25;
+	}
+
+	ret = of_property_read_u32(np, "xlnx,itap-delay-sdr50",
+				   &itapdly[MMC_TIMING_UHS_SDR50]);
+	if (ret) {
+		dev_dbg(dev,
+			"Using predefined itapdly for MMC_TIMING_UHS_SDR50\n");
+		itapdly[MMC_TIMING_UHS_SDR50] = ZYNQMP_ITAPDLYSEL_SDR50;
+	}
+
+	ret = of_property_read_u32(np, "xlnx,otap-delay-sdr50",
+				   &otapdly[MMC_TIMING_UHS_SDR50]);
+	if (ret) {
+		dev_dbg(dev,
+			"Using predefined otapdly for MMC_TIMING_UHS_SDR50\n");
+		otapdly[MMC_TIMING_UHS_SDR50] = ZYNQMP_OTAPDLYSEL_SDR50;
+	}
+
+	ret = of_property_read_u32(np, "xlnx,itap-delay-sd-ddr50",
+				   &itapdly[MMC_TIMING_UHS_DDR50]);
+	if (ret) {
+		dev_dbg(dev,
+			"Using predefined itapdly for MMC_TIMING_UHS_DDR50\n");
+		itapdly[MMC_TIMING_UHS_DDR50] = ZYNQMP_ITAPDLYSEL_SD_DDR50;
+	}
+
+	ret = of_property_read_u32(np, "xlnx,otap-delay-sd-ddr50",
+				   &otapdly[MMC_TIMING_UHS_DDR50]);
+	if (ret) {
+		dev_dbg(dev,
+			"Using predefined otapdly for MMC_TIMING_UHS_DDR50\n");
+		otapdly[MMC_TIMING_UHS_DDR50] = ZYNQMP_OTAPDLYSEL_SD_DDR50;
+	}
+
+	ret = of_property_read_u32(np, "xlnx,itap-delay-mmc-hsd",
+				   &itapdly[MMC_TIMING_MMC_HS]);
+	if (ret) {
+		dev_dbg(dev,
+			"Using predefined itapdly for MMC_TIMING_MMC_HS\n");
+		itapdly[MMC_TIMING_MMC_HS] = ZYNQMP_ITAPDLYSEL_MMC_HSD;
+	}
+
+	ret = of_property_read_u32(np, "xlnx,otap-delay-mmc-hsd",
+				   &otapdly[MMC_TIMING_MMC_HS]);
+	if (ret) {
+		dev_dbg(dev,
+			"Using predefined otapdly for MMC_TIMING_MMC_HS\n");
+		otapdly[MMC_TIMING_MMC_HS] = ZYNQMP_OTAPDLYSEL_MMC_HSD;
+	}
+
+	ret = of_property_read_u32(np, "xlnx,itap-delay-mmc-ddr52",
+				   &itapdly[MMC_TIMING_MMC_DDR52]);
+	if (ret) {
+		dev_dbg(dev,
+			"Using predefined itapdly for MMC_TIMING_MMC_DDR52\n");
+		itapdly[MMC_TIMING_MMC_DDR52] = ZYNQMP_ITAPDLYSEL_MMC_DDR52;
+	}
+
+	ret = of_property_read_u32(np, "xlnx,otap-delay-mmc-ddr52",
+				   &otapdly[MMC_TIMING_MMC_DDR52]);
+	if (ret) {
+		dev_dbg(dev,
+			"Using predefined otapdly for MMC_TIMING_MMC_DDR52\n");
+		otapdly[MMC_TIMING_MMC_DDR52] = ZYNQMP_OTAPDLYSEL_MMC_DDR52;
+	}
+
+	ret = of_property_read_u32(np, "xlnx,itap-delay-sdr104",
+				   &itapdly[MMC_TIMING_UHS_SDR104]);
+	if (ret) {
+		dev_dbg(dev,
+			"Using predefined itapdly for MMC_TIMING_UHS_SDR104\n");
+		if (mio_bank == 2) {
+			itapdly[MMC_TIMING_UHS_SDR104] =
+				ZYNQMP_ITAPDLYSEL_SDR104_B2;
+		} else {
+			itapdly[MMC_TIMING_UHS_SDR104] =
+				ZYNQMP_ITAPDLYSEL_SDR104_B0;
+		}
+	}
+
+	ret = of_property_read_u32(np, "xlnx,otap-delay-sdr104",
+				   &otapdly[MMC_TIMING_UHS_SDR104]);
+	if (ret) {
+		dev_dbg(dev,
+			"Using predefined otapdly for MMC_TIMING_UHS_SDR104\n");
+		if (mio_bank == 2) {
+			otapdly[MMC_TIMING_UHS_SDR104] =
+				ZYNQMP_OTAPDLYSEL_SDR104_B2;
+		} else {
+			otapdly[MMC_TIMING_UHS_SDR104] =
+				ZYNQMP_OTAPDLYSEL_SDR104_B0;
+		}
+	}
+
+	ret = of_property_read_u32(np, "xlnx,itap-delay-mmc-hs200",
+				   &itapdly[MMC_TIMING_MMC_HS200]);
+	if (ret) {
+		dev_dbg(dev,
+			"Using predefined itapdly for MMC_TIMING_MMC_HS200\n");
+		if (mio_bank == 2) {
+			itapdly[MMC_TIMING_MMC_HS200] =
+				ZYNQMP_ITAPDLYSEL_MMC_HS200_B2;
+		} else {
+			itapdly[MMC_TIMING_MMC_HS200] =
+				ZYNQMP_ITAPDLYSEL_MMC_HS200_B0;
+		}
+	}
+
+	ret = of_property_read_u32(np, "xlnx,otap-delay-mmc-hs200",
+				   &otapdly[MMC_TIMING_MMC_HS200]);
+	if (ret) {
+		dev_dbg(dev,
+			"Using predefined otapdly for MMC_TIMING_MMC_HS200\n");
+		if (mio_bank == 2) {
+			otapdly[MMC_TIMING_MMC_HS200] =
+				ZYNQMP_OTAPDLYSEL_MMC_HS200_B2;
+		} else {
+			otapdly[MMC_TIMING_MMC_HS200] =
+				ZYNQMP_OTAPDLYSEL_MMC_HS200_B0;
+		}
+	}
+}
+
 static int sdhci_arasan_add_host(struct sdhci_arasan_data *sdhci_arasan)
 {
 	struct sdhci_host *host = sdhci_arasan->host;
@@ -863,6 +1067,15 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
 
 	if (of_device_is_compatible(pdev->dev.of_node, "xlnx,zynqmp-8.9a")) {
 		ret = of_property_read_u32(pdev->dev.of_node,
+					   "xlnx,mio-bank",
+					   &sdhci_arasan->zynqmp_data.mio_bank);
+		if (ret < 0) {
+			dev_err(&pdev->dev,
+				"\"xlnx,mio-bank \" property is missing.\n");
+			goto unreg_clk;
+		}
+
+		ret = of_property_read_u32(pdev->dev.of_node,
 					   "xlnx,device_id",
 					   &sdhci_arasan->device_id);
 		if (ret < 0) {
@@ -871,6 +1084,8 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
 			goto unreg_clk;
 		}
 
+		arasan_zynqmp_dt_parse_tap_delays(&pdev->dev);
+
 		host->mmc_host_ops.execute_tuning =
 			arasan_zynqmp_execute_tuning;
 	}
diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
index 40feebc..b00388f 100644
--- a/include/linux/firmware/xlnx-zynqmp.h
+++ b/include/linux/firmware/xlnx-zynqmp.h
@@ -144,11 +144,15 @@ struct zynqmp_eemi_ops {
 
 #if IS_REACHABLE(CONFIG_ARCH_ZYNQMP)
 const struct zynqmp_eemi_ops *zynqmp_pm_get_eemi_ops(void);
+/* API for programming the tap delays */
+void zynqmp_set_tap_delay(u8 deviceid, u8 itap_delay, u8 otap_delay);
 #else
 static inline struct zynqmp_eemi_ops *zynqmp_pm_get_eemi_ops(void)
 {
 	return NULL;
 }
+inline void zynqmp_set_tap_delay(u8 deviceid, u8 itap_delay,
+					u8 otap_delay) {}
 #endif
 
 #endif /* __FIRMWARE_ZYNQMP_H__ */
-- 
2.1.1
