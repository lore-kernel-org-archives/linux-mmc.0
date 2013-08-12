From: <dinguyen@altera.com>
Subject: [PATCHv3] ARM: socfpga: dts: Add support for SD/MMC
Date: Mon, 12 Aug 2013 10:49:49 -0500
Message-ID: <1376322589-17606-1-git-send-email-dinguyen@altera.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from am1ehsobe001.messaging.microsoft.com ([213.199.154.204]:30178
	"EHLO am1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757240Ab3HLPtm (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 12 Aug 2013 11:49:42 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: dinh.linux@gmail.com
Cc: Dinh Nguyen <dinguyen@altera.com>, Jaehoon Chung <jh80.chung@samsung.com>, Seungwon Jeon <tgih.jun@samsung.com>, Rob Herring <rob.herring@calxeda.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Ian Campbell <ian.campbell@citrix.com>, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org

From: Dinh Nguyen <dinguyen@altera.com>

Add bindings for SD/MMC for SOCFPGA.
Add "syscon" to the "altr,sys-mgr" binding.

Signed-off-by: Dinh Nguyen <dinguyen@altera.com>
Reviewed-by: Pavel Machek <pavel@denx.de>
Acked-by: Jaehoon Chung <jh80.chung@samsung.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>
Cc: Seungwon Jeon <tgih.jun@samsung.com>
Cc: Rob Herring <rob.herring@calxeda.com>
Cc: Pawel Moll <pawel.moll@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>
Cc: Ian Campbell <ian.campbell@citrix.com>
Cc: devicetree@vger.kernel.org
Cc: linux-mmc@vger.kernel.org
CC: linux-arm-kernel@lists.infradead.org

v3:
- Explicitly reference synopsis-dw-mshc.txt for base bindings
- Remove "dw-mshc-ciu-div" as driver can get clock information dts from
"ciu" entry.
- Fixed indentation issue

v2:
- Remove bus-width and extra line in documentation
- Merge bindings example into a single node in documentation

---
Re-send to updated device tree bindings maintainers.
---
 .../devicetree/bindings/mmc/socfpga-dw-mshc.txt    |   36 ++++++++++++++++++++
 arch/arm/boot/dts/socfpga.dtsi                     |   13 ++++++-
 arch/arm/boot/dts/socfpga_cyclone5.dts             |   12 +++++++
 arch/arm/boot/dts/socfpga_vt.dts                   |   11 ++++++
 drivers/mmc/host/dw_mmc-socfpga.c                  |    9 -----
 5 files changed, 71 insertions(+), 10 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mmc/socfpga-dw-mshc.txt

diff --git a/Documentation/devicetree/bindings/mmc/socfpga-dw-mshc.txt b/Documentation/devicetree/bindings/mmc/socfpga-dw-mshc.txt
new file mode 100644
index 0000000..d588bf9
--- /dev/null
+++ b/Documentation/devicetree/bindings/mmc/socfpga-dw-mshc.txt
@@ -0,0 +1,36 @@
+* Altera SOCFPGA specific extensions to the Synopsis Designware Mobile
+  Storage Host Controller
+
+The Synopsis designware mobile storage host controller is used to interface
+a SoC with storage medium such as eMMC or SD/MMC cards. This file documents
+differences between the core Synopsis dw mshc controller properties described
+by synopsis-dw-mshc.txt and the properties used by the SOCFPGA specific
+extensions to the Synopsis Designware Mobile Storage Host Controller.
+
+Required Properties:
+
+* compatible: should be
+	- "altr,socfpga-dw-mshc": for controllers with Altera SOCFPGA
+	  specific extensions.
+
+* altr,dw-mshc-sdr-timing: Specifies the value of CIU clock phase shift value
+  in transmit mode and CIU clock phase shift value in receive mode for single
+  data rate mode operation. Refer to notes below for the order of the cells and the
+  valid values.
+
+  Notes for the sdr-timing values:
+
+    The order of the cells should be
+      - First Cell: CIU clock phase shift value for RX mode, smplsel bits in
+	the system manager SDMMC control group.
+      - Second Cell: CIU clock phase shift value for TX mode, drvsel bits in
+	the system manager SDMMC control group.
+
+    Valid values for SDR CIU clock timing for SOCFPGA:
+      - valid value for tx phase shift and rx phase shift is 0 to 7.
+
+Example:
+	dwmmc0@ff704000 {
+		compatible = "altr,socfpga-dw-mshc", "snps,dw-mshc";
+		altr,dw-mshc-sdr-timing = <0 3>;
+	};
diff --git a/arch/arm/boot/dts/socfpga.dtsi b/arch/arm/boot/dts/socfpga.dtsi
index bee62a2..dbf7f22 100644
--- a/arch/arm/boot/dts/socfpga.dtsi
+++ b/arch/arm/boot/dts/socfpga.dtsi
@@ -468,6 +468,17 @@
 			cache-level = <2>;
 		};
 
+		mmc: dwmmc0@ff704000 {
+			compatible = "altr,socfpga-dw-mshc";
+			reg = <0xff704000 0x1000>;
+			interrupts = <0 139 4>;
+			fifo-depth = <0x400>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			clocks = <&l4_mp_clk>, <&sdmmc_clk>;
+			clock-names = "biu", "ciu";
+		};
+
 		/* Local timer */
 		timer@fffec600 {
 			compatible = "arm,cortex-a9-twd-timer";
@@ -521,7 +532,7 @@
 			};
 
 		sysmgr@ffd08000 {
-				compatible = "altr,sys-mgr";
+				compatible = "altr,sys-mgr", "syscon";
 				reg = <0xffd08000 0x4000>;
 			};
 	};
diff --git a/arch/arm/boot/dts/socfpga_cyclone5.dts b/arch/arm/boot/dts/socfpga_cyclone5.dts
index 973999d..526df6f 100644
--- a/arch/arm/boot/dts/socfpga_cyclone5.dts
+++ b/arch/arm/boot/dts/socfpga_cyclone5.dts
@@ -54,6 +54,18 @@
 			status = "okay";
 		};
 
+		dwmmc0@ff704000 {
+			num-slots = <1>;
+			supports-highspeed;
+			broken-cd;
+			altr,dw-mshc-sdr-timing = <0 3>;
+
+			slot@0 {
+				reg = <0>;
+				bus-width = <4>;
+			};
+		};
+
 		timer0@ffc08000 {
 			clock-frequency = <100000000>;
 		};
diff --git a/arch/arm/boot/dts/socfpga_vt.dts b/arch/arm/boot/dts/socfpga_vt.dts
index d1ec0ca..6f23121 100644
--- a/arch/arm/boot/dts/socfpga_vt.dts
+++ b/arch/arm/boot/dts/socfpga_vt.dts
@@ -46,6 +46,17 @@
 			status = "okay";
 		};
 
+		dwmmc0@ff704000 {
+			num-slots = <1>;
+			supports-highspeed;
+			broken-cd;
+
+			slot@0 {
+				reg = <0>;
+				bus-width = <4>;
+			};
+		};
+
 		timer0@ffc08000 {
 			clock-frequency = <7000000>;
 		};
diff --git a/drivers/mmc/host/dw_mmc-socfpga.c b/drivers/mmc/host/dw_mmc-socfpga.c
index 14b5961..0cff75d 100644
--- a/drivers/mmc/host/dw_mmc-socfpga.c
+++ b/drivers/mmc/host/dw_mmc-socfpga.c
@@ -31,7 +31,6 @@
 
 /* SOCFPGA implementation specific driver private data */
 struct dw_mci_socfpga_priv_data {
-	u8	ciu_div; /* card interface unit divisor */
 	u32	hs_timing; /* bitmask for CIU clock phase shift */
 	struct regmap   *sysreg; /* regmap for system manager register */
 };
@@ -64,8 +63,6 @@ static int dw_mci_socfpga_setup_clock(struct dw_mci *host)
 	regmap_write(priv->sysreg, SYSMGR_SDMMCGRP_CTRL_OFFSET,
 		priv->hs_timing);
 	clk_prepare_enable(host->ciu_clk);
-
-	host->bus_hz /= (priv->ciu_div + 1);
 	return 0;
 }
 
@@ -82,14 +79,8 @@ static int dw_mci_socfpga_parse_dt(struct dw_mci *host)
 	struct dw_mci_socfpga_priv_data *priv = host->priv;
 	struct device_node *np = host->dev->of_node;
 	u32 timing[2];
-	u32 div = 0;
 	int ret;
 
-	ret = of_property_read_u32(np, "altr,dw-mshc-ciu-div", &div);
-	if (ret)
-		dev_info(host->dev, "No dw-mshc-ciu-div specified, assuming 1");
-	priv->ciu_div = div;
-
 	ret = of_property_read_u32_array(np,
 			"altr,dw-mshc-sdr-timing", timing, 2);
 	if (ret)
-- 
1.7.9.5


