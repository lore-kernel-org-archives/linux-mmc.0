From: <dinguyen@altera.com>
Subject: [PATCHv2] ARM: socfpga: dts: Add support for SD/MMC
Date: Mon, 5 Aug 2013 15:43:12 -0500
Message-ID: <1375735392-6836-1-git-send-email-dinguyen@altera.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-db9lp0253.outbound.messaging.microsoft.com ([213.199.154.253]:23343
	"EHLO db9outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755268Ab3HEUm4 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 5 Aug 2013 16:42:56 -0400
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

v2:
- Remove bus-width and extra line in documentation
- Merge bindings example into a single node in documentation

---
Re-send to updated device tree bindings maintainers.
---
 .../devicetree/bindings/mmc/socfpga-dw-mshc.txt    |   48 ++++++++++++++++++++
 arch/arm/boot/dts/socfpga.dtsi                     |   13 +++++-
 arch/arm/boot/dts/socfpga_cyclone5.dts             |   13 ++++++
 arch/arm/boot/dts/socfpga_vt.dts                   |   12 +++++
 4 files changed, 85 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/mmc/socfpga-dw-mshc.txt

diff --git a/Documentation/devicetree/bindings/mmc/socfpga-dw-mshc.txt b/Documentation/devicetree/bindings/mmc/socfpga-dw-mshc.txt
new file mode 100644
index 0000000..dc14922
--- /dev/null
+++ b/Documentation/devicetree/bindings/mmc/socfpga-dw-mshc.txt
@@ -0,0 +1,48 @@
+* Altera SOCFPGA specific extensions to the Synopsis Designware Mobile
+  Storage Host Controller
+
+Required Properties:
+
+* compatible: should be
+	- "altr,socfpga-dw-mshc": for controllers with Altera SOCFPGA
+	  specific extensions.
+
+* altr,dw-mshc-ciu-div: Specifies the divider value for the card interface
+  unit (ciu) clock. The value should be (n-1). For Altera's SOCFPGA, the divider
+  value is fixed at 3, which means parent_clock/4.
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
+		reg = <0xff704000 0x1000>;
+		interrupts = <0 139 4>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		num-slots = <1>;
+		supports-highspeed;
+		broken-cd;
+		fifo-depth = <0x400>;
+		altr,dw-mshc-ciu-div = <3>;
+      		altr,dw-mshc-sdr-timing = <0 3>;
+
+		slot@0 {
+			reg = <0>;
+			bus-width = <4>;
+		};
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
index 973999d..1853cb1 100644
--- a/arch/arm/boot/dts/socfpga_cyclone5.dts
+++ b/arch/arm/boot/dts/socfpga_cyclone5.dts
@@ -54,6 +54,19 @@
 			status = "okay";
 		};
 
+		dwmmc0@ff704000 {
+			num-slots = <1>;
+			supports-highspeed;
+			broken-cd;
+			altr,dw-mshc-ciu-div = <3>;
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
index d1ec0ca..d93deb0 100644
--- a/arch/arm/boot/dts/socfpga_vt.dts
+++ b/arch/arm/boot/dts/socfpga_vt.dts
@@ -46,6 +46,18 @@
 			status = "okay";
 		};
 
+		dwmmc0@ff704000 {
+			num-slots = <1>;
+			supports-highspeed;
+			broken-cd;
+			altr,dw-mshc-ciu-div = <3>;
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
-- 
1.7.9.5


