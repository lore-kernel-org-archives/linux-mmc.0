From: <dinguyen@altera.com>
Subject: [PATCHv5 1/4] arm: dts: Add support for SD/MMC on SOCFPGA
Date: Mon, 9 Dec 2013 07:57:39 -0600
Message-ID: <1386597462-29471-2-git-send-email-dinguyen@altera.com>
References: <1386597462-29471-1-git-send-email-dinguyen@altera.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from va3ehsobe010.messaging.microsoft.com ([216.32.180.30]:9080 "EHLO
	va3outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933522Ab3LIN7c (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 9 Dec 2013 08:59:32 -0500
In-Reply-To: <1386597462-29471-1-git-send-email-dinguyen@altera.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: dinh.linux@gmail.com, arnd@arndb.de, mturquette@linaro.org, cjb@laptop.org, jh80.chung@samsung.com, tgih.jun@samsung.com
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Dinh Nguyen <dinguyen@altera.com>

From: Dinh Nguyen <dinguyen@altera.com>

Use the standard "snps,dw-mshc" binding that will support SD/MMC on
Altera's SOCFPGA platform.

Signed-off-by: Dinh Nguyen <dinguyen@altera.com>
---
v5: Use the standard "snps,dw-mshc" binding
v4: Re-use "rockchip,rk2928-dw-mshc" binding
v3: none
v2: none
---
 arch/arm/boot/dts/socfpga.dtsi          |   11 +++++++++++
 arch/arm/boot/dts/socfpga_arria5.dtsi   |   12 ++++++++++++
 arch/arm/boot/dts/socfpga_cyclone5.dtsi |   12 ++++++++++++
 arch/arm/boot/dts/socfpga_vt.dts        |   12 ++++++++++++
 4 files changed, 47 insertions(+)

diff --git a/arch/arm/boot/dts/socfpga.dtsi b/arch/arm/boot/dts/socfpga.dtsi
index f936476..9e78c1d 100644
--- a/arch/arm/boot/dts/socfpga.dtsi
+++ b/arch/arm/boot/dts/socfpga.dtsi
@@ -469,6 +469,17 @@
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
diff --git a/arch/arm/boot/dts/socfpga_arria5.dtsi b/arch/arm/boot/dts/socfpga_arria5.dtsi
index a85b404..112b7e2 100644
--- a/arch/arm/boot/dts/socfpga_arria5.dtsi
+++ b/arch/arm/boot/dts/socfpga_arria5.dtsi
@@ -27,6 +27,18 @@
 			};
 		};
 
+		dwmmc0@ff704000 {
+			num-slots = <1>;
+			supports-highspeed;
+			broken-cd;
+			samsung,dw-mshc-sdr-timing = <0 3>;
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
index a8716f6..52b1501 100644
--- a/arch/arm/boot/dts/socfpga_cyclone5.dtsi
+++ b/arch/arm/boot/dts/socfpga_cyclone5.dtsi
@@ -28,6 +28,18 @@
 			};
 		};
 
+		dwmmc0@ff704000 {
+			num-slots = <1>;
+			supports-highspeed;
+			broken-cd;
+			samsung,dw-mshc-sdr-timing = <0 3>;
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
index d1ec0ca..7dc709b 100644
--- a/arch/arm/boot/dts/socfpga_vt.dts
+++ b/arch/arm/boot/dts/socfpga_vt.dts
@@ -41,6 +41,18 @@
 			};
 		};
 
+		dwmmc0@ff704000 {
+			num-slots = <1>;
+			supports-highspeed;
+			broken-cd;
+			samsung,dw-mshc-sdr-timing = <0 3>;
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


