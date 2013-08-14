From: <dinguyen@altera.com>
Subject: [PATCHv4 2/3] ARM: socfpga: dts: Add support for SD/MMC
Date: Wed, 14 Aug 2013 11:48:03 -0500
Message-ID: <1376498884-9199-2-git-send-email-dinguyen@altera.com>
References: <1376498884-9199-1-git-send-email-dinguyen@altera.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from va3ehsobe002.messaging.microsoft.com ([216.32.180.12]:57051
	"EHLO va3outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932831Ab3HNQsR (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 14 Aug 2013 12:48:17 -0400
In-Reply-To: <1376498884-9199-1-git-send-email-dinguyen@altera.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: dinh.linux@gmail.com
Cc: Dinh Nguyen <dinguyen@altera.com>, Jaehoon Chung <jh80.chung@samsung.com>, Seungwon Jeon <tgih.jun@samsung.com>, Rob Herring <rob.herring@calxeda.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Ian Campbell <ian.campbell@citrix.com>, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org

From: Dinh Nguyen <dinguyen@altera.com>

Add bindings for SD/MMC for SOCFPGA.

Signed-off-by: Dinh Nguyen <dinguyen@altera.com>
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

v4:
- Add a complete binding example in documentations
- Add a phandle entry for "altr,sysmgr" which links the system
  manager to the SD/MMC IP block that controls the SDR timings.
- Split up patches
        1/3 - Add syscon binding to sys-mgr node
        2/3 - DTS bindings and documentation for SD/MMC on SOCFPGA
        3/3 - Driver changes to use the bindings

v3:
- Explicitly reference synopsis-dw-mshc.txt for base bindings
- Remove "dw-mshc-ciu-div" as driver can get clock information dts "ciu" entry
- Fixed indentation issue

v2:
- Remove bus-width and extra line in documentation
- Merge bindings example into a single node in documentation
---
 .../devicetree/bindings/mmc/socfpga-dw-mshc.txt    |   56 ++++++++++++++++++++
 arch/arm/boot/dts/socfpga.dtsi                     |   11 ++++
 arch/arm/boot/dts/socfpga_cyclone5.dts             |   13 +++++
 arch/arm/boot/dts/socfpga_vt.dts                   |   11 ++++
 4 files changed, 91 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mmc/socfpga-dw-mshc.txt

diff --git a/Documentation/devicetree/bindings/mmc/socfpga-dw-mshc.txt b/Documentation/devicetree/bindings/mmc/socfpga-dw-mshc.txt
new file mode 100644
index 0000000..eaf98cd
--- /dev/null
+++ b/Documentation/devicetree/bindings/mmc/socfpga-dw-mshc.txt
@@ -0,0 +1,56 @@
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
+* altr,sysmgr: Should be the phandle to the system_mgr node. As this is where
+		this where the register that controls the CIU clock phases
+		reside.
+
+Example:
+	dwmmc0@ff704000 {
+		compatible = "altr,socfpga-dw-mshc", "snps,dw-mshc";
+		reg = <0xff704000 0x1000>;
+		interrupts = <0 139 4>;
+		fifo-depth = <0x400>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		clocks = <&l4_mp_clk>, <&sdmmc_clk>;
+		clock-names = "biu", "ciu";
+		num-slots = <1>;
+		supports-highspeed;
+		broken-cd;
+		altr,sysmgr = <&system_mgr>;
+		altr,dw-mshc-sdr-timing = <0 3>;
+
+		slot@0 {
+			reg = <0>;
+			bus-width = <4>;
+		};
+	};
diff --git a/arch/arm/boot/dts/socfpga.dtsi b/arch/arm/boot/dts/socfpga.dtsi
index c31c8e9..9706767 100644
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
diff --git a/arch/arm/boot/dts/socfpga_cyclone5.dts b/arch/arm/boot/dts/socfpga_cyclone5.dts
index 973999d..698dde9 100644
--- a/arch/arm/boot/dts/socfpga_cyclone5.dts
+++ b/arch/arm/boot/dts/socfpga_cyclone5.dts
@@ -54,6 +54,19 @@
 			status = "okay";
 		};
 
+		dwmmc0@ff704000 {
+			num-slots = <1>;
+			supports-highspeed;
+			broken-cd;
+			altr,sysmgr = <&system_mgr>;
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
-- 
1.7.9.5


