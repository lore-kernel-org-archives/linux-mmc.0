From: <dinguyen@altera.com>
Subject: [PATCHv3 2/4] arm: dts: Add a system manager compatible property
Date: Wed, 4 Dec 2013 16:52:54 -0600
Message-ID: <1386197576-3825-3-git-send-email-dinguyen@altera.com>
References: <1386197576-3825-1-git-send-email-dinguyen@altera.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from tx2ehsobe005.messaging.microsoft.com ([65.55.88.15]:19680 "EHLO
	tx2outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756142Ab3LDWyy (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 4 Dec 2013 17:54:54 -0500
In-Reply-To: <1386197576-3825-1-git-send-email-dinguyen@altera.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: dinh.linux@gmail.com, arnd@arndb.de, mturquette@linaro.org, rob.herring@calxeda.com, pawel.moll@arm.com, mark.rutland@arm.com, ian.campbell@citrix.com, cjb@laptop.org, jh80.chung@samsung.com, tgih.jun@samsung.com
Cc: devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Dinh Nguyen <dinguyen@altera.com>

From: Dinh Nguyen <dinguyen@altera.com>

The "altr,sysmgr-sdmmc-sdr" compatible property is used for the SOCFPGA
clk-sysmgr driver. This property represents the register inside the
system manager that controls the clock phase of the SD/MMC driver.

Signed-off-by: Dinh Nguyen <dinguyen@altera.com>
---
v3: Cannot use the syscon driver along with the clock because as of v3.13-rc1,
the syscon driver is loaded after the clocks.
v2: Add syscon
---
 .../bindings/arm/altera/socfpga-system.txt         |   10 ++++++++++
 arch/arm/boot/dts/socfpga.dtsi                     |   14 +++++++++++---
 2 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/altera/socfpga-system.txt b/Documentation/devicetree/bindings/arm/altera/socfpga-system.txt
index f4d04a0..7a6c7ed 100644
--- a/Documentation/devicetree/bindings/arm/altera/socfpga-system.txt
+++ b/Documentation/devicetree/bindings/arm/altera/socfpga-system.txt
@@ -5,9 +5,19 @@ Required properties:
 - reg : Should contain 1 register ranges(address and length)
 - cpu1-start-addr : CPU1 start address in hex.
 
+Optional properties:
+- compatible = "altr,sysmgr-sdmmc-sdr". This compatible property is used
+to represent the clock phase settings for the SD/MMC IP.
+
 Example:
 	 sysmgr@ffd08000 {
 		compatible = "altr,sys-mgr";
 		reg = <0xffd08000 0x1000>;
 		cpu1-start-addr = <0xffd080c4>;
+
+		sysmgr_sdr_mmc: sysmgr_sdr_mmc {
+			#clock-cells = <0>;
+			compatible = "altr,sysmgr-sdmmc-sdr";
+			reg = <0x108 1>;
+		};
 	};
diff --git a/arch/arm/boot/dts/socfpga.dtsi b/arch/arm/boot/dts/socfpga.dtsi
index f936476..a6a13b3 100644
--- a/arch/arm/boot/dts/socfpga.dtsi
+++ b/arch/arm/boot/dts/socfpga.dtsi
@@ -522,9 +522,17 @@
 			reg = <0xffd05000 0x1000>;
 		};
 
-		sysmgr@ffd08000 {
-				compatible = "altr,sys-mgr";
-				reg = <0xffd08000 0x4000>;
+		sysmgr: sysmgr@ffd08000 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "altr,sys-mgr";
+			reg = <0xffd08000 0x4000>;
+
+			sysmgr_sdr_mmc: sysmgr_sdr_mmc {
+				#clock-cells = <0>;
+				compatible = "altr,sysmgr-sdmmc-sdr";
+				reg = <0x108 1>;
 			};
+		};
 	};
 };
-- 
1.7.9.5


