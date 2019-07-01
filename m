From: Manish Narani <manish.narani@xilinx.com>
Subject: [PATCH v2 01/11] dt-bindings: mmc: arasan: Update documentation for SD Card Clock
Date: Mon,  1 Jul 2019 10:59:41 +0530
Message-ID: <1561958991-21935-2-git-send-email-manish.narani@xilinx.com>
References: <1561958991-21935-1-git-send-email-manish.narani@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1561958991-21935-1-git-send-email-manish.narani@xilinx.com>
Sender: linux-kernel-owner@vger.kernel.org
To: ulf.hansson@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, heiko@sntech.de, michal.simek@xilinx.com, adrian.hunter@intel.com, christoph.muellner@theobroma-systems.com, philipp.tomsich@theobroma-systems.com, viresh.kumar@linaro.org, scott.branden@broadcom.com, ayaka@soulik.info, kernel@esmil.dk, tony.xie@rock-chips.com, rajan.vaja@xilinx.com, jolly.shah@xilinx.com, nava.manne@xilinx.com, mdf@kernel.org, manish.narani@xilinx.com, olof@lixom.net
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

The clock handling is to be updated in the Arasan SDHCI. As the
'devm_clk_register' is deprecated in the clock framework, this needs to
specify one more clock named 'clk_sdcard' to get the clock in the driver
via 'devm_clk_get()'. This clock represents the clock from controller to
the card.

Signed-off-by: Manish Narani <manish.narani@xilinx.com>
---
 Documentation/devicetree/bindings/mmc/arasan,sdhci.txt | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
index 1edbb04..15c6397 100644
--- a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
+++ b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
@@ -23,6 +23,10 @@ Required Properties:
   - reg: From mmc bindings: Register location and length.
   - clocks: From clock bindings: Handles to clock inputs.
   - clock-names: From clock bindings: Tuple including "clk_xin" and "clk_ahb"
+		 Apart from these two there is one more optional clock which
+		 is "clk_sdcard". This clock represents output clock from
+		 controller and card. This must be specified when #clock-cells
+		 is specified.
   - interrupts: Interrupt specifier
 
 Required Properties for "arasan,sdhci-5.1":
@@ -36,9 +40,10 @@ Optional Properties:
   - clock-output-names: If specified, this will be the name of the card clock
     which will be exposed by this device.  Required if #clock-cells is
     specified.
-  - #clock-cells: If specified this should be the value <0>.  With this property
-    in place we will export a clock representing the Card Clock.  This clock
-    is expected to be consumed by our PHY.  You must also specify
+  - #clock-cells: If specified this should be the value <0>. With this
+    property in place we will export one clock representing the Card
+    Clock. This clock is expected to be consumed by our PHY. You must also
+    specify
   - xlnx,fails-without-test-cd: when present, the controller doesn't work when
     the CD line is not connected properly, and the line is not connected
     properly. Test mode can be used to force the controller to function.
@@ -70,8 +75,8 @@ Example:
 		compatible = "rockchip,rk3399-sdhci-5.1", "arasan,sdhci-5.1";
 		reg = <0x0 0xfe330000 0x0 0x10000>;
 		interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&cru SCLK_EMMC>, <&cru ACLK_EMMC>;
-		clock-names = "clk_xin", "clk_ahb";
+		clocks = <&cru SCLK_EMMC>, <&cru ACLK_EMMC>, <&sdhci 0>;
+		clock-names = "clk_xin", "clk_ahb", "clk_sdcard";
 		arasan,soc-ctl-syscon = <&grf>;
 		assigned-clocks = <&cru SCLK_EMMC>;
 		assigned-clock-rates = <200000000>;
-- 
2.1.1
