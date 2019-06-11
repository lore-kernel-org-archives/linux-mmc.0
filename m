From: Manish Narani <manish.narani@xilinx.com>
Subject: [PATCH 2/3] dt-bindings: mmc: arasan: Document 'xlnx,zynqmp-8.9a' controller
Date: Tue, 11 Jun 2019 15:26:50 +0530
Message-ID: <1560247011-26369-3-git-send-email-manish.narani@xilinx.com>
References: <1560247011-26369-1-git-send-email-manish.narani@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1560247011-26369-1-git-send-email-manish.narani@xilinx.com>
Sender: linux-kernel-owner@vger.kernel.org
To: ulf.hansson@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, michal.simek@xilinx.com, adrian.hunter@intel.com, rajan.vaja@xilinx.com, jolly.shah@xilinx.com, nava.manne@xilinx.com, manish.narani@xilinx.com, olof@lixom.net
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

Add documentation for 'xlnx,zynqmp-8.9a' SDHCI controller and optional
properties followed by example.

Signed-off-by: Manish Narani <manish.narani@xilinx.com>
---
 .../devicetree/bindings/mmc/arasan,sdhci.txt       | 32 ++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
index 1edbb04..6945b3b 100644
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
 
@@ -45,6 +48,24 @@ Optional Properties:
   - xlnx,int-clock-stable-broken: when present, the controller always reports
     that the internal clock is stable even when it is not.
 
+Optional Properties for "xlnx,zynqmp-8.9a":
+  - xlnx,tap-delay-mmc-hsd: Input/Output Tap Delays in degrees for MMC HS.
+  - xlnx,tap-delay-sd-hsd: Input/Output Tap Delays in degrees for SD HS.
+  - xlnx,tap-delay-sdr25: Input/Output Tap Delays in degrees for SDR25.
+  - xlnx,tap-delay-sdr50: Input/Output Tap Delays in degrees for SDR50.
+  - xlnx,tap-delay-sdr104: Input/Output Tap Delays in degrees for SDR104.
+  - xlnx,tap-delay-sd-ddr50: Input/Output Tap Delays in degrees for SD DDR50.
+  - xlnx,tap-delay-mmc-ddr52: Input/Output Tap Delays in degrees for MMC DDR52.
+  - xlnx,tap-delay-mmc-hs200: Input/Output Tap Delays in degrees for MMC HS200.
+
+  Above mentioned are the clock (phase) delays which are to be configured in the
+  controller while switching to particular speed mode. If not specified, driver
+  will configure the default value defined for particular mode in it.
+
+  - xlnx,mio-bank: When specified, this will indicate the MIO bank number in
+    which the command and data lines are configured. If not specified, driver
+    will assume this as 0.
+
 Example:
 	sdhci@e0100000 {
 		compatible = "arasan,sdhci-8.9a";
@@ -80,3 +101,14 @@ Example:
 		phy-names = "phy_arasan";
 		#clock-cells = <0>;
 	};
+
+	sdhci: mmc@ff160000 {
+		compatible = "xlnx,zynqmp-8.9a", "arasan,sdhci-8.9a";
+		interrupt-parent = <&gic>;
+		interrupts = <0 48 4>;
+		reg = <0x0 0xff160000 0x0 0x1000>;
+		clock-names = "clk_xin", "clk_ahb";
+		clock-output-names = "clk_sd0";
+		#clock-cells = <0>;
+		xlnx,tap-delay-sd-hsd = <21>, <6>;
+	};
-- 
2.1.1
