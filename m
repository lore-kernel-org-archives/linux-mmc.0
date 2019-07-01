From: Manish Narani <manish.narani@xilinx.com>
Subject: [PATCH v2 10/11] dt-bindings: mmc: arasan: Document 'xlnx,zynqmp-8.9a' controller
Date: Mon,  1 Jul 2019 10:59:50 +0530
Message-ID: <1561958991-21935-11-git-send-email-manish.narani@xilinx.com>
References: <1561958991-21935-1-git-send-email-manish.narani@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1561958991-21935-1-git-send-email-manish.narani@xilinx.com>
Sender: linux-kernel-owner@vger.kernel.org
To: ulf.hansson@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, heiko@sntech.de, michal.simek@xilinx.com, adrian.hunter@intel.com, christoph.muellner@theobroma-systems.com, philipp.tomsich@theobroma-systems.com, viresh.kumar@linaro.org, scott.branden@broadcom.com, ayaka@soulik.info, kernel@esmil.dk, tony.xie@rock-chips.com, rajan.vaja@xilinx.com, jolly.shah@xilinx.com, nava.manne@xilinx.com, mdf@kernel.org, manish.narani@xilinx.com, olof@lixom.net
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

Add documentation for 'xlnx,zynqmp-8.9a' SDHCI controller and optional
properties followed by example.

Signed-off-by: Manish Narani <manish.narani@xilinx.com>
---
 .../devicetree/bindings/mmc/arasan,sdhci.txt          | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
index 7425d52..d2058ee 100644
--- a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
+++ b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
@@ -15,6 +15,9 @@ Required Properties:
     - "arasan,sdhci-5.1": generic Arasan SDHCI 5.1 PHY
     - "rockchip,rk3399-sdhci-5.1", "arasan,sdhci-5.1": rk3399 eMMC PHY
       For this device it is strongly suggested to include arasan,soc-ctl-syscon.
+    - "xlnx,zynqmp-8.9a": ZynqMP SDHCI 8.9a PHY
+      For this device it is strongly suggested to include clock-output-names and
+      #clock-cells.
     - "ti,am654-sdhci-5.1", "arasan,sdhci-5.1": TI AM654 MMC PHY
 	Note: This binding has been deprecated and moved to [5].
 
@@ -65,6 +68,10 @@ Optional Properties:
   controller while switching to particular speed mode. If not specified, driver
   will configure the default value defined for particular mode in it.
 
+  - xlnx,mio-bank: When specified, this will indicate the MIO bank number in
+    which the command and data lines are configured. If not specified, driver
+    will assume this as 0.
+
 Example:
 	sdhci@e0100000 {
 		compatible = "arasan,sdhci-8.9a";
@@ -100,3 +107,15 @@ Example:
 		phy-names = "phy_arasan";
 		#clock-cells = <0>;
 	};
+
+	sdhci: mmc@ff160000 {
+		compatible = "xlnx,zynqmp-8.9a", "arasan,sdhci-8.9a";
+		interrupt-parent = <&gic>;
+		interrupts = <0 48 4>;
+		reg = <0x0 0xff160000 0x0 0x1000>;
+		clocks = <&clk200>, <&clk200>, <&sdhci 0>, <&sdhci 1>;
+		clock-names = "clk_xin", "clk_ahb", "clk_sdcard", "clk_sample";
+		clock-output-names = "clk_out_sd0", "clk_in_sd0";
+		#clock-cells = <1>;
+		clk-phase-sd-hs = <63>, <72>;
+	};
-- 
2.1.1
