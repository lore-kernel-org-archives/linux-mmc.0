From: <dinguyen@altera.com>
Subject: [PATCHv9 2/4] dts: socfpga: Add support for SD/MMC on the SOCFPGA platform
Date: Thu, 9 Jan 2014 15:31:17 -0600
Message-ID: <1389303079-19808-3-git-send-email-dinguyen@altera.com>
References: <1389303079-19808-1-git-send-email-dinguyen@altera.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from co1ehsobe003.messaging.microsoft.com ([216.32.180.186]:26142
	"EHLO co1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753095AbaAIVdU (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 9 Jan 2014 16:33:20 -0500
In-Reply-To: <1389303079-19808-1-git-send-email-dinguyen@altera.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: dinh.linux@gmail.com, arnd@arndb.de, cjb@laptop.org, jh80.chung@samsung.com, tgih.jun@samsung.com, heiko@sntech.de, dianders@chromium.org, alim.akhtar@samsung.com, bzhao@marvell.com, mturquette@linaro.org
Cc: zhangfei.gao@linaro.org, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Dinh Nguyen <dinguyen@altera.com>

From: Dinh Nguyen <dinguyen@altera.com>

Use the "snps,dw-mshc" binding to enable the dw_mmc driver.
Add the "syscon" binding to the "altr,sys-mgr" node. The clock
driver can use the syscon driver to toggle the register for the SD/MMC
clock phase shift settings.

Signed-off-by: Dinh Nguyen <dinguyen@altera.com>
---
v9: none
v8: none
v7: Use the standard "snps,dw-mshc" binding. Remove "altr,socfpga-sdmmc-sdr-clk".
v6: Add documentation for "altr,socfpga-sdmmc-sdr-clk". Add "syscon" to the
sysmgr binding.
v5: Use the "snps,dw-mshc" binding
v4: Re-use "rockchip,rk2928-dw-mshc" binding
v3: none
v2: none
---
 arch/arm/boot/dts/socfpga.dtsi          |   13 ++++++++++++-
 arch/arm/boot/dts/socfpga_arria5.dtsi   |   11 +++++++++++
 arch/arm/boot/dts/socfpga_cyclone5.dtsi |   11 +++++++++++
 arch/arm/boot/dts/socfpga_vt.dts        |   11 +++++++++++
 4 files changed, 45 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/socfpga.dtsi b/arch/arm/boot/dts/socfpga.dtsi
index e776512..433bfbc 100644
--- a/arch/arm/boot/dts/socfpga.dtsi
+++ b/arch/arm/boot/dts/socfpga.dtsi
@@ -470,6 +470,17 @@
 			cache-level = <2>;
 		};
 
+		mmc: dwmmc0@ff704000 {
+			compatible = "snps,dw-mshc";
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
@@ -524,7 +535,7 @@
 		};
 
 		sysmgr@ffd08000 {
-				compatible = "altr,sys-mgr";
+				compatible = "altr,sys-mgr", "syscon";
 				reg = <0xffd08000 0x4000>;
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


