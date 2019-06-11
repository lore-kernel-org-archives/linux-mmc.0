From: Manish Narani <manish.narani@xilinx.com>
Subject: [PATCH 1/3] firmware: xilinx: Add SDIO Tap Delay API
Date: Tue, 11 Jun 2019 15:26:49 +0530
Message-ID: <1560247011-26369-2-git-send-email-manish.narani@xilinx.com>
References: <1560247011-26369-1-git-send-email-manish.narani@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1560247011-26369-1-git-send-email-manish.narani@xilinx.com>
Sender: linux-kernel-owner@vger.kernel.org
To: ulf.hansson@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, michal.simek@xilinx.com, adrian.hunter@intel.com, rajan.vaja@xilinx.com, jolly.shah@xilinx.com, nava.manne@xilinx.com, manish.narani@xilinx.com, olof@lixom.net
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

Add API for setting SDIO Tap Delays on ZynqMP platforms.

Signed-off-by: Manish Narani <manish.narani@xilinx.com>
---
 drivers/firmware/xilinx/zynqmp.c     | 32 ++++++++++++++++++++++++++++++++
 include/linux/firmware/xlnx-zynqmp.h | 17 ++++++++++++++++-
 2 files changed, 48 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
index fd3d837..c6f9e72 100644
--- a/drivers/firmware/xilinx/zynqmp.c
+++ b/drivers/firmware/xilinx/zynqmp.c
@@ -664,6 +664,37 @@ static int zynqmp_pm_set_requirement(const u32 node, const u32 capabilities,
 				   qos, ack, NULL);
 }
 
+/**
+ * zynqmp_pm_sdio_setphase() - PM call to set clock delays for SD clock
+ * @device_id:		Device ID of the SD controller
+ * @degrees:		Tap Delay value in degrees for Input/Output clocks
+ *
+ * This API function is to be used for setting the clock delays for SD
+ * clock.
+ *
+ * Return: Returns status, either success or error+reason
+ */
+static int zynqmp_pm_sdio_setphase(u32 device_id, int degrees)
+{
+	u32 node_id = (!device_id) ? NODE_SD_0 : NODE_SD_1;
+	enum tap_delay_type tap_type;
+	int ret;
+
+	if (degrees < INPUT_TAP_BOUNDARY) {
+		tap_type = PM_TAPDELAY_INPUT;
+	} else {
+		tap_type = PM_TAPDELAY_OUTPUT;
+		degrees -= INPUT_TAP_BOUNDARY;
+	}
+
+	ret = zynqmp_pm_ioctl(node_id, IOCTL_SET_SD_TAPDELAY, tap_type,
+			      degrees, NULL);
+	if (ret)
+		pr_err("Error setting Tap Delay\n");
+
+	return ret;
+}
+
 static const struct zynqmp_eemi_ops eemi_ops = {
 	.get_api_version = zynqmp_pm_get_api_version,
 	.get_chipid = zynqmp_pm_get_chipid,
@@ -687,6 +718,7 @@ static const struct zynqmp_eemi_ops eemi_ops = {
 	.set_requirement = zynqmp_pm_set_requirement,
 	.fpga_load = zynqmp_pm_fpga_load,
 	.fpga_get_status = zynqmp_pm_fpga_get_status,
+	.sdio_setphase = zynqmp_pm_sdio_setphase,
 };
 
 /**
diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
index 1262ea6..0fc4bf7 100644
--- a/include/linux/firmware/xlnx-zynqmp.h
+++ b/include/linux/firmware/xlnx-zynqmp.h
@@ -56,6 +56,9 @@
 #define XILINX_ZYNQMP_PM_FPGA_FULL	0x0U
 #define XILINX_ZYNQMP_PM_FPGA_PARTIAL	BIT(0)
 
+/* Input Tap Delay Boundary Value */
+#define INPUT_TAP_BOUNDARY		0x100
+
 enum pm_api_id {
 	PM_GET_API_VERSION = 1,
 	PM_REQUEST_NODE = 13,
@@ -92,7 +95,8 @@ enum pm_ret_status {
 };
 
 enum pm_ioctl_id {
-	IOCTL_SET_PLL_FRAC_MODE = 8,
+	IOCTL_SET_SD_TAPDELAY = 7,
+	IOCTL_SET_PLL_FRAC_MODE,
 	IOCTL_GET_PLL_FRAC_MODE,
 	IOCTL_SET_PLL_FRAC_DATA,
 	IOCTL_GET_PLL_FRAC_DATA,
@@ -251,6 +255,16 @@ enum zynqmp_pm_request_ack {
 	ZYNQMP_PM_REQUEST_ACK_NON_BLOCKING,
 };
 
+enum pm_node_id {
+	NODE_SD_0 = 39,
+	NODE_SD_1,
+};
+
+enum tap_delay_type {
+	PM_TAPDELAY_INPUT = 0,
+	PM_TAPDELAY_OUTPUT,
+};
+
 /**
  * struct zynqmp_pm_query_data - PM query data
  * @qid:	query ID
@@ -295,6 +309,7 @@ struct zynqmp_eemi_ops {
 			       const u32 capabilities,
 			       const u32 qos,
 			       const enum zynqmp_pm_request_ack ack);
+	int (*sdio_setphase)(u32 device_id, int degrees);
 };
 
 int zynqmp_pm_invoke_fn(u32 pm_api_id, u32 arg0, u32 arg1,
-- 
2.1.1
