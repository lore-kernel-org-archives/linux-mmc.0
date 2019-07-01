From: Manish Narani <manish.narani@xilinx.com>
Subject: [PATCH v2 09/11] firmware: xilinx: Add SDIO Tap Delay APIs
Date: Mon,  1 Jul 2019 10:59:49 +0530
Message-ID: <1561958991-21935-10-git-send-email-manish.narani@xilinx.com>
References: <1561958991-21935-1-git-send-email-manish.narani@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1561958991-21935-1-git-send-email-manish.narani@xilinx.com>
Sender: linux-kernel-owner@vger.kernel.org
To: ulf.hansson@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, heiko@sntech.de, michal.simek@xilinx.com, adrian.hunter@intel.com, christoph.muellner@theobroma-systems.com, philipp.tomsich@theobroma-systems.com, viresh.kumar@linaro.org, scott.branden@broadcom.com, ayaka@soulik.info, kernel@esmil.dk, tony.xie@rock-chips.com, rajan.vaja@xilinx.com, jolly.shah@xilinx.com, nava.manne@xilinx.com, mdf@kernel.org, manish.narani@xilinx.com, olof@lixom.net
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

Add APIs for setting SDIO Tap Delays on ZynqMP platform.

Signed-off-by: Manish Narani <manish.narani@xilinx.com>
---
 drivers/firmware/xilinx/zynqmp.c     | 48 ++++++++++++++++++++++++++++++++++++
 include/linux/firmware/xlnx-zynqmp.h | 15 ++++++++++-
 2 files changed, 62 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
index fd3d837..b81f1be 100644
--- a/drivers/firmware/xilinx/zynqmp.c
+++ b/drivers/firmware/xilinx/zynqmp.c
@@ -664,6 +664,52 @@ static int zynqmp_pm_set_requirement(const u32 node, const u32 capabilities,
 				   qos, ack, NULL);
 }
 
+/**
+ * zynqmp_pm_sdio_out_setphase() - PM call to set clock output delays for SD
+ * @device_id:		Device ID of the SD controller
+ * @tap_delay:		Tap Delay value for output clock
+ *
+ * This API function is to be used for setting the clock output delays for SD
+ * clock.
+ *
+ * Return: Returns status, either success or error+reason
+ */
+static int zynqmp_pm_sdio_out_setphase(u32 device_id, u8 tap_delay)
+{
+	u32 node_id = (!device_id) ? NODE_SD_0 : NODE_SD_1;
+	int ret;
+
+	ret = zynqmp_pm_ioctl(node_id, IOCTL_SET_SD_TAPDELAY,
+			      PM_TAPDELAY_OUTPUT, tap_delay, NULL);
+	if (ret)
+		pr_err("Error setting Output Tap Delay\n");
+
+	return ret;
+}
+
+/**
+ * zynqmp_pm_sdio_in_setphase() - PM call to set clock input delays for SD
+ * @device_id:		Device ID of the SD controller
+ * @tap_delay:		Tap Delay value for input clock
+ *
+ * This API function is to be used for setting the clock input delays for SD
+ * clock.
+ *
+ * Return: Returns status, either success or error+reason
+ */
+static int zynqmp_pm_sdio_in_setphase(u32 device_id, u8 tap_delay)
+{
+	u32 node_id = (!device_id) ? NODE_SD_0 : NODE_SD_1;
+	int ret;
+
+	ret = zynqmp_pm_ioctl(node_id, IOCTL_SET_SD_TAPDELAY,
+			      PM_TAPDELAY_INPUT, tap_delay, NULL);
+	if (ret)
+		pr_err("Error setting Input Tap Delay\n");
+
+	return ret;
+}
+
 static const struct zynqmp_eemi_ops eemi_ops = {
 	.get_api_version = zynqmp_pm_get_api_version,
 	.get_chipid = zynqmp_pm_get_chipid,
@@ -687,6 +733,8 @@ static const struct zynqmp_eemi_ops eemi_ops = {
 	.set_requirement = zynqmp_pm_set_requirement,
 	.fpga_load = zynqmp_pm_fpga_load,
 	.fpga_get_status = zynqmp_pm_fpga_get_status,
+	.sdio_out_setphase = zynqmp_pm_sdio_out_setphase,
+	.sdio_in_setphase = zynqmp_pm_sdio_in_setphase,
 };
 
 /**
diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
index 1262ea6..d9b53e5 100644
--- a/include/linux/firmware/xlnx-zynqmp.h
+++ b/include/linux/firmware/xlnx-zynqmp.h
@@ -92,7 +92,8 @@ enum pm_ret_status {
 };
 
 enum pm_ioctl_id {
-	IOCTL_SET_PLL_FRAC_MODE = 8,
+	IOCTL_SET_SD_TAPDELAY = 7,
+	IOCTL_SET_PLL_FRAC_MODE,
 	IOCTL_GET_PLL_FRAC_MODE,
 	IOCTL_SET_PLL_FRAC_DATA,
 	IOCTL_GET_PLL_FRAC_DATA,
@@ -251,6 +252,16 @@ enum zynqmp_pm_request_ack {
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
@@ -295,6 +306,8 @@ struct zynqmp_eemi_ops {
 			       const u32 capabilities,
 			       const u32 qos,
 			       const enum zynqmp_pm_request_ack ack);
+	int (*sdio_out_setphase)(u32 device_id, u8 tap_delay);
+	int (*sdio_in_setphase)(u32 device_id, u8 tap_delay);
 };
 
 int zynqmp_pm_invoke_fn(u32 pm_api_id, u32 arg0, u32 arg1,
-- 
2.1.1
