From: <dinguyen-EIB2kfCEclfQT0dZR+AlfA@public.gmane.org>
Subject: [PATCHv2 1/2] ARM: socfpga: dts: Add support for SD/MMC
Date: Wed, 12 Jun 2013 10:18:50 -0500
Message-ID: <1371050331-31331-1-git-send-email-dinguyen@altera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: dinh.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, Pavel Machek <pavel-ynQEQJNshbs@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

From: Dinh Nguyen <dinguyen-EIB2kfCEclfQT0dZR+AlfA@public.gmane.org>

Add bindings for SD/MMC for SOCFPGA.
Add "syscon" to the "altr,sys-mgr" binding.

Signed-off-by: Dinh Nguyen <dinguyen-EIB2kfCEclfQT0dZR+AlfA@public.gmane.org>
Reviewed-by: Pavel Machek <pavel-ynQEQJNshbs@public.gmane.org>
CC: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
CC: Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>
Cc: Pavel Machek <pavel-ynQEQJNshbs@public.gmane.org>
Cc: Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>
Cc: Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>
Cc: devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Cc: linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
CC: <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>

v2:
- Fixed misspellings extentions->extensions
---
 .../devicetree/bindings/mmc/socfpga-dw-mshc.txt    |   60 ++++++++++++++++++++
 arch/arm/boot/dts/socfpga.dtsi                     |   13 ++++-
 arch/arm/boot/dts/socfpga_cyclone5.dts             |   13 +++++
 arch/arm/boot/dts/socfpga_vt.dts                   |   12 ++++
 4 files changed, 97 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/mmc/socfpga-dw-mshc.txt

diff --git a/Documentation/devicetree/bindings/mmc/socfpga-dw-mshc.txt b/Documentation/devicetree/bindings/mmc/socfpga-dw-mshc.txt
new file mode 100644
index 0000000..f218bb8
--- /dev/null
+++ b/Documentation/devicetree/bindings/mmc/socfpga-dw-mshc.txt
@@ -0,0 +1,60 @@
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
+  value is fixed at 3, which mean parent_clock/4.
+
+* altr,dw-mshc-sdr-timing: Specifies the value of CIU clock phase shift value
+  in transmit mode and CIU clock phase shift value in receive mode for single
+  data rate mode operation. Refer notes below for the order of the cells and the
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
+Required properties for a slot:
+
+* bus-width: Data width for card slot. 4-bit or 8-bit data.
+
+Example:
+
+  The MSHC controller node can be split into two portions, SoC specific and
+  board specific portions as listed below.
+
+	dwmmc0@ff704000 {
+		compatible = "altr,socfpga-dw-mshc";
+		reg = <0xff704000 0x1000>;
+		interrupts = <0 139 4>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+	};
+
+	dwmmc0@ff704000 {
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
+
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
