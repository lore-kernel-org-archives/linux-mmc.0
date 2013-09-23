From: <dinguyen@altera.com>
Subject: [PATCHv2 3/3] arm: dts: socfpga: Add support for SD/MMC
Date: Mon, 23 Sep 2013 17:36:00 -0500
Message-ID: <1379975760-18084-3-git-send-email-dinguyen@altera.com>
References: <1379975760-18084-1-git-send-email-dinguyen@altera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1379975760-18084-1-git-send-email-dinguyen@altera.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: dinh.linux@gmail.com
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Pawel Moll <pawel.moll@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Seungwon Jeon <tgih.jun@samsung.com>, Pavel Machek <pavel@denx.de>, linux-mmc@vger.kernel.org, Rob Herring <rob.herring@calxeda.com>, Jaehoon Chung <jh80.chung@samsung.com>, linux-arm-kernel@lists.infradead.org, Olof Johansson <olof@lixom.net>, Chris Ball <cjb@laptop.org>, Dinh Nguyen <dinguyen@altera.com>, Ian Campbell <ian.campbell@citrix.com>
List-Id: linux-mmc@vger.kernel.org

From: Dinh Nguyen <dinguyen@altera.com>

Add bindings for SD/MMC for SOCFPGA.

Signed-off-by: Dinh Nguyen <dinguyen@altera.com>
Reviewed-by: Pavel Machek <pavel@denx.de>
Cc: Pavel Machek <pavel@denx.de>
CC: Arnd Bergmann <arnd@arndb.de>
CC: Olof Johansson <olof@lixom.net>
Cc: Rob Herring <rob.herring@calxeda.com>
Cc: Pawel Moll <pawel.moll@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>
Cc: Ian Campbell <ian.campbell@citrix.com>
Cc: Chris Ball <cjb@laptop.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>
Cc: Seungwon Jeon <tgih.jun@samsung.com>
Cc: devicetree@vger.kernel.org
Cc: linux-mmc@vger.kernel.org
CC: linux-arm-kernel@lists.infradead.org

v2:
- Fix documentation s/binding/property and s/Synopsis/Synopsys
---
 .../devicetree/bindings/mmc/socfpga-dw-mshc.txt    |   38 ++++++++++++++++++++
 arch/arm/boot/dts/socfpga.dtsi                     |   11 ++++++
 arch/arm/boot/dts/socfpga_cyclone5.dts             |   12 +++++++
 arch/arm/boot/dts/socfpga_vt.dts                   |   12 +++++++
 4 files changed, 73 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mmc/socfpga-dw-mshc.txt

diff --git a/Documentation/devicetree/bindings/mmc/socfpga-dw-mshc.txt b/Documentation/devicetree/bindings/mmc/socfpga-dw-mshc.txt
new file mode 100644
index 0000000..531336a
--- /dev/null
+++ b/Documentation/devicetree/bindings/mmc/socfpga-dw-mshc.txt
@@ -0,0 +1,38 @@
+* Altera SOCFPGA specific extensions to the Synopsys Designware Mobile
+  Storage Host Controller
+
+The Synopsys designware mobile storage host controller is used to interface
+a SoC with storage medium such as eMMC or SD/MMC cards. This file documents
+differences between the core Synopsys dw mshc controller properties described
+by synopsys-dw-mshc.txt and the properties used by the SOCFPGA specific
+extensions to the Synopsys Designware Mobile Storage Host Controller.
+
+Required Properties:
+
+* compatible: should be
+        - "altr,socfpga-dw-mshc": for controllers with Altera SOCFPGA
+          specific extensions.
+
+* samsung,dw-mshc-sdr-timing: See exynos-dw-mshc.txt for more information about
+	this property.
+
+Example:
+        dwmmc0@ff704000 {
+                compatible = "altr,socfpga-dw-mshc", "snps,dw-mshc";
+                reg = <0xff704000 0x1000>;
+                interrupts = <0 139 4>;
+                fifo-depth = <0x400>;
+                #address-cells = <1>;
+                #size-cells = <0>;
+                clocks = <&l4_mp_clk>, <&sdmmc_clk>;
+                clock-names = "biu", "ciu";
+                num-slots = <1>;
+                supports-highspeed;
+                broken-cd;
+                samsung,dw-mshc-sdr-timing = <3 0>;
+
+                slot@0 {
+                        reg = <0>;
+                        bus-width = <4>;
+                };
+        };
diff --git a/arch/arm/boot/dts/socfpga.dtsi b/arch/arm/boot/dts/socfpga.dtsi
index e273fa9..1ee6079 100644
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
index 973999d..bfed066 100644
--- a/arch/arm/boot/dts/socfpga_cyclone5.dts
+++ b/arch/arm/boot/dts/socfpga_cyclone5.dts
@@ -48,6 +48,18 @@
 			};
 		};
 
+		dwmmc0@ff704000 {
+			num-slots = <1>;
+			supports-highspeed;
+			broken-cd;
+			samsung,dw-mshc-sdr-timing = <3 0>;
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
index d1ec0ca..25b2653 100644
--- a/arch/arm/boot/dts/socfpga_vt.dts
+++ b/arch/arm/boot/dts/socfpga_vt.dts
@@ -41,6 +41,18 @@
 			};
 		};
 
+		dwmmc0@ff704000 {
+			num-slots = <1>;
+			supports-highspeed;
+			broken-cd;
+			samsung,dw-mshc-sdr-timing = <3 0>;
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
