From: Manish Narani <manish.narani@xilinx.com>
Subject: [RFC PATCH 1/4] firmware: xilinx: Add SD Node and DLL Reset Data APIs
Date: Tue, 18 Sep 2018 19:15:36 +0530
Message-ID: <1537278339-9257-2-git-send-email-manish.narani@xilinx.com>
References: <1537278339-9257-1-git-send-email-manish.narani@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1537278339-9257-1-git-send-email-manish.narani@xilinx.com>
Sender: linux-kernel-owner@vger.kernel.org
To: ulf.hansson@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, michal.simek@xilinx.com, adrian.hunter@intel.com, manish.narani@xilinx.com, leoyang.li@nxp.com, sudeep.holla@arm.com, olof@lixom.net, amit.kucheria@linaro.org, rajanv@xilinx.com, jollys@xilinx.com
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

Add ZynqMP firmware SD Node data API to be used in call from SDHCI
driver. Also add DLL Reset data API to used for DLL reset calls from any
drivers.

Signed-off-by: Manish Narani <manish.narani@xilinx.com>
---
 include/linux/firmware/xlnx-zynqmp.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
index 58a7478..743687b 100644
--- a/include/linux/firmware/xlnx-zynqmp.h
+++ b/include/linux/firmware/xlnx-zynqmp.h
@@ -58,13 +58,25 @@ enum pm_ret_status {
 	XST_PM_ABORT_SUSPEND,
 };
 
+enum pm_node_id {
+	NODE_SD_0 = 39,
+	NODE_SD_1,
+};
+
 enum pm_ioctl_id {
+	IOCTL_SD_DLL_RESET = 6,
 	IOCTL_SET_PLL_FRAC_MODE = 8,
 	IOCTL_GET_PLL_FRAC_MODE,
 	IOCTL_SET_PLL_FRAC_DATA,
 	IOCTL_GET_PLL_FRAC_DATA,
 };
 
+enum dll_reset_type {
+	PM_DLL_RESET_ASSERT,
+	PM_DLL_RESET_RELEASE,
+	PM_DLL_RESET_PULSE,
+};
+
 enum pm_query_id {
 	PM_QID_INVALID,
 	PM_QID_CLOCK_GET_NAME,
-- 
2.1.1
