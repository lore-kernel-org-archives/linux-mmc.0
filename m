From: <dinguyen@altera.com>
Subject: [PATCHv3 3/3] dts: socfpga: Add support for SD/MMC on the SOCFPGA platform
Date: Mon, 17 Feb 2014 20:31:02 -0600
Message-ID: <1392690662-19106-3-git-send-email-dinguyen@altera.com>
References: <1392690662-19106-1-git-send-email-dinguyen@altera.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na01-bl2-obe.ptr.protection.outlook.com ([65.55.169.28]:53996
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752230AbaBRCde (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 17 Feb 2014 21:33:34 -0500
In-Reply-To: <1392690662-19106-1-git-send-email-dinguyen@altera.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: dinh.linux@gmail.com, devicetree@vger.kernel.org, Dinh Nguyen <dinguyen@altera.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Seungwon Jeon <tgih.jun@samsung.com>, Jaehoon Chung <jh80.chung@samsung.com>, Chris Ball <chris@printf.net>

From: Dinh Nguyen <dinguyen@altera.com>

Introduce "altr,socfpga-dw-mshc" to enable Altera's SOCFPGA platform specific
implementation of the dwc_mmc driver.

Also add the "syscon" binding to the "altr,sys-mgr" node. The clock
driver can use the syscon driver to toggle the register for the SD/MMC
clock phase shift settings.

Finally, fix an indentation error for the sysmgr node.

Signed-off-by: Dinh Nguyen <dinguyen@altera.com>
Acked-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Tested-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Pawel Moll <pawel.moll@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
Cc: Kumar Gala <galak@codeaurora.org>
Cc: Seungwon Jeon <tgih.jun@samsung.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>
Cc: Chris Ball <chris@printf.net>
---
v3: Fix another indentation error
v2: Fix indentation for the sysmgr node
---
 .../devicetree/bindings/mmc/socfpga-dw-mshc.txt    |   23 ++++++++++++++++++++
 arch/arm/boot/dts/socfpga.dtsi                     |   17 ++++++++++++---
 arch/arm/boot/dts/socfpga_arria5.dtsi              |   11 ++++++++++
 arch/arm/boot/dts/socfpga_cyclone5.dtsi            |   11 ++++++++++
 arch/arm/boot/dts/socfpga_vt.dts                   |   11 ++++++++++
 5 files changed, 70 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mmc/socfpga-dw-mshc.txt

diff --git a/Documentation/devicetree/bindings/mmc/socfpga-dw-mshc.txt b/Documentation/devicetree/bindings/mmc/socfpga-dw-mshc.txt
new file mode 100644
index 0000000..4897bea
--- /dev/null
+++ b/Documentation/devicetree/bindings/mmc/socfpga-dw-mshc.txt
@@ -0,0 +1,23 @@
+* Altera SOCFPGA specific extensions to the Synopsys Designware Mobile
+  Storage Host Controller
+
+The Synopsys designware mobile storage host controller is used to interface
+a SoC with storage medium such as eMMC or SD/MMC cards. This file documents
+differences between the core Synopsys dw mshc controller properties described
+by synopsys-dw-mshc.txt and the properties used by the Altera SOCFPGA specific
+extensions to the Synopsys Designware Mobile Storage Host Controller.
+
+Required Properties:
+
+* compatible: should be
+	- "altr,socfpga-dw-mshc": for Altera's SOCFPGA platform
+
+Example:
+
+	mmc: dwmmc0@ff704000 {
+		compatible = "altr,socfpga-dw-mshc";
+		reg = <0xff704000 0x1000>;
+		interrupts = <0 129 4>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+	};
diff --git a/arch/arm/boot/dts/socfpga.dtsi b/arch/arm/boot/dts/socfpga.dtsi
index 3d62f47..0166f47 100644
--- a/arch/arm/boot/dts/socfpga.dtsi
+++ b/arch/arm/boot/dts/socfpga.dtsi
@@ -474,6 +474,17 @@
 			arm,data-latency = <2 1 1>;
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
@@ -528,8 +539,8 @@
 		};
 
 		sysmgr@ffd08000 {
-				compatible = "altr,sys-mgr";
-				reg = <0xffd08000 0x4000>;
-			};
+			compatible = "altr,sys-mgr", "syscon";
+			reg = <0xffd08000 0x4000>;
+		};
 	};
 };
diff --git a/arch/arm/boot/dts/socfpga_arria5.dtsi b/arch/arm/boot/dts/socfpga_arria5.dtsi
index a85b404..6c87b70 100644
--- a/arch/arm/boot/dts/socfpga_arria5.dtsi
+++ b/arch/arm/boot/dts/socfpga_arria5.dtsi
@@ -27,6 +27,17 @@
 			};
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
 		serial0@ffc02000 {
 			clock-frequency = <100000000>;
 		};
diff --git a/arch/arm/boot/dts/socfpga_cyclone5.dtsi b/arch/arm/boot/dts/socfpga_cyclone5.dtsi
index a8716f6..ca41b0e 100644
--- a/arch/arm/boot/dts/socfpga_cyclone5.dtsi
+++ b/arch/arm/boot/dts/socfpga_cyclone5.dtsi
@@ -28,6 +28,17 @@
 			};
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
 		ethernet@ff702000 {
 			phy-mode = "rgmii";
 			phy-addr = <0xffffffff>; /* probe for phy addr */
diff --git a/arch/arm/boot/dts/socfpga_vt.dts b/arch/arm/boot/dts/socfpga_vt.dts
index d1ec0ca..222313f 100644
--- a/arch/arm/boot/dts/socfpga_vt.dts
+++ b/arch/arm/boot/dts/socfpga_vt.dts
@@ -41,6 +41,17 @@
 			};
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
 		ethernet@ff700000 {
 			phy-mode = "gmii";
 			status = "okay";
-- 
1.7.9.5

