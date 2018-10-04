From: Faiz Abbas <faiz_abbas@ti.com>
Subject: [PATCH 1/6] dt-bindings: phy: am654-mmc-phy: Document new phy bindings
Date: Thu, 4 Oct 2018 16:44:46 +0530
Message-ID: <20181004111451.9539-2-faiz_abbas@ti.com>
References: <20181004111451.9539-1-faiz_abbas@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181004111451.9539-1-faiz_abbas@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org
Cc: kishon@ti.com, faiz_abbas@ti.com, ulf.hansson@linaro.org, robh+dt@kernel.org, catalin.marinas@arm.com, adrian.hunter@intel.com
List-Id: linux-mmc@vger.kernel.org

Add information to document bindings for the MMC PHY
on TI's AM654 devices.

Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
Signed-off-by: Sekhar Nori <nsekhar@ti.com>
---
 .../devicetree/bindings/phy/am654-mmc-phy.txt | 42 +++++++++++++++++++
 1 file changed, 42 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/am654-mmc-phy.txt

diff --git a/Documentation/devicetree/bindings/phy/am654-mmc-phy.txt b/Documentation/devicetree/bindings/phy/am654-mmc-phy.txt
new file mode 100644
index 000000000000..766921612758
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/am654-mmc-phy.txt
@@ -0,0 +1,42 @@
+TI AM654 MMC PHY
+-------------------
+
+Required properties:
+ - compatible: ti,am654-emmc-phy
+ - #phy-cells: must be 0
+ - reg: PHY registers address offset and size
+ - clocks: must be phandle of the clock provider which is the host
+	   controller
+ - clock-names: must be "mmcclk"
+ - ti,otap-del-sel: Output Tap Delay select.
+ - ti,trm-icp: DLL trim select.
+ - ti,driver-strength-ohm: driver strength in ohms.
+			   Valid values are 33, 40, 50, 66, and 100 ohms.
+
+Example:
+			mmc_phy1: mmc_phy@10100 {
+				compatible = "ti,am654-mmc-phy";
+				reg = <0x10100 0x34>;
+				clocks = <&sdhci1>;
+				clock-names = "mmcclk";
+				#phy-cells = <0>;
+				ti,otap-del-sel = <0x2>;
+				ti,trm-icp = <0x8>;
+				status = "disabled";
+			};
+
+Host controller node:
+
+			sdhci1: sdhci@0 {
+				compatible = "ti,am654-sdhci-5.1";
+				reg = <0x0 0x1000>;
+				power-domains = <&k3_pds 48>;
+				clocks = <&k3_clks 48 0>, <&k3_clks 48 1>;
+				clock-names = "clk_ahb", "clk_xin";
+				interrupts = <GIC_SPI 137 IRQ_TYPE_LEVEL_HIGH>;
+				clock-output-names = "mmc_cardclck";
+				#clock-cells = <0>;
+				phys=<&mmc_phy1>;
+				phy-names = "phy_arasan";
+				status = "disabled";
+			};
-- 
2.18.0
