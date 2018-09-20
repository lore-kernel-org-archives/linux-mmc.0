From: Manish Narani <manish.narani@xilinx.com>
Subject: [RFC PATCH v2 2/4] firmware: xilinx: Add macros and API for SD tap delays
Date: Thu, 20 Sep 2018 15:00:43 +0530
Message-ID: <1537435845-6682-3-git-send-email-manish.narani@xilinx.com>
References: <1537435845-6682-1-git-send-email-manish.narani@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1537435845-6682-1-git-send-email-manish.narani@xilinx.com>
Sender: linux-kernel-owner@vger.kernel.org
To: ulf.hansson@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, michal.simek@xilinx.com, adrian.hunter@intel.com, manish.narani@xilinx.com, amit.kucheria@linaro.org, sudeep.holla@arm.com, leoyang.li@nxp.com, jollys@xilinx.com, rajanv@xilinx.com
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

Add ZynqMP firmware SD tap delay macros and API for setting tap values.

Signed-off-by: Manish Narani <manish.narani@xilinx.com>
---
 include/linux/firmware/xlnx-zynqmp.h | 29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
index 743687b..40feebc 100644
--- a/include/linux/firmware/xlnx-zynqmp.h
+++ b/include/linux/firmware/xlnx-zynqmp.h
@@ -22,6 +22,27 @@
 #define ZYNQMP_TZ_VERSION_MAJOR	1
 #define ZYNQMP_TZ_VERSION_MINOR	0
 
+#define ZYNQMP_ITAPDLYSEL_SD_HSD	0x15
+#define ZYNQMP_ITAPDLYSEL_SDR25		0x15
+#define ZYNQMP_ITAPDLYSEL_SDR50		0x0
+#define ZYNQMP_ITAPDLYSEL_SDR104_B2	0x0
+#define ZYNQMP_ITAPDLYSEL_SDR104_B0	0x0
+#define ZYNQMP_ITAPDLYSEL_MMC_HSD	0x15
+#define ZYNQMP_ITAPDLYSEL_SD_DDR50	0x3D
+#define ZYNQMP_ITAPDLYSEL_MMC_DDR52	0x12
+#define ZYNQMP_ITAPDLYSEL_MMC_HS200_B2	0x0
+#define ZYNQMP_ITAPDLYSEL_MMC_HS200_B0	0x0
+#define ZYNQMP_OTAPDLYSEL_SD_HSD	0x05
+#define ZYNQMP_OTAPDLYSEL_SDR25		0x05
+#define ZYNQMP_OTAPDLYSEL_SDR50		0x03
+#define ZYNQMP_OTAPDLYSEL_SDR104_B0	0x03
+#define ZYNQMP_OTAPDLYSEL_SDR104_B2	0x02
+#define ZYNQMP_OTAPDLYSEL_MMC_HSD	0x06
+#define ZYNQMP_OTAPDLYSEL_SD_DDR50	0x04
+#define ZYNQMP_OTAPDLYSEL_MMC_DDR52	0x06
+#define ZYNQMP_OTAPDLYSEL_MMC_HS200_B0	0x03
+#define ZYNQMP_OTAPDLYSEL_MMC_HS200_B2	0x02
+
 #define ZYNQMP_TZ_VERSION	((ZYNQMP_TZ_VERSION_MAJOR << 16) | \
 					ZYNQMP_TZ_VERSION_MINOR)
 
@@ -65,12 +86,18 @@ enum pm_node_id {
 
 enum pm_ioctl_id {
 	IOCTL_SD_DLL_RESET = 6,
-	IOCTL_SET_PLL_FRAC_MODE = 8,
+	IOCTL_SET_SD_TAPDELAY,
+	IOCTL_SET_PLL_FRAC_MODE,
 	IOCTL_GET_PLL_FRAC_MODE,
 	IOCTL_SET_PLL_FRAC_DATA,
 	IOCTL_GET_PLL_FRAC_DATA,
 };
 
+enum tap_delay_type {
+	PM_TAPDELAY_INPUT,
+	PM_TAPDELAY_OUTPUT,
+};
+
 enum dll_reset_type {
 	PM_DLL_RESET_ASSERT,
 	PM_DLL_RESET_RELEASE,
-- 
2.1.1
