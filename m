From: Faiz Abbas <faiz_abbas@ti.com>
Subject: [PATCH v2 1/3] dt-bindings: mmc: sdhci-am654: Document bindings for the host controllers on TI's AM654 SOCs
Date: Fri, 7 Dec 2018 13:41:17 +0530
Message-ID: <20181207081119.29162-2-faiz_abbas@ti.com>
References: <20181207081119.29162-1-faiz_abbas@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181207081119.29162-1-faiz_abbas@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, adrian.hunter@intel.com, michal.simek@xilinx.com, kishon@ti.com, faiz_abbas@ti.com
List-Id: linux-mmc@vger.kernel.org

Add binding documentation for mmc host controllers present on TI's AM654
SOCs.

Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
---
 .../devicetree/bindings/mmc/sdhci-am654.txt   | 37 +++++++++++++++++++
 1 file changed, 37 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mmc/sdhci-am654.txt

diff --git a/Documentation/devicetree/bindings/mmc/sdhci-am654.txt b/Documentation/devicetree/bindings/mmc/sdhci-am654.txt
new file mode 100644
index 000000000000..862b93051bfe
--- /dev/null
+++ b/Documentation/devicetree/bindings/mmc/sdhci-am654.txt
@@ -0,0 +1,37 @@
+Device Tree Bindings for the SDHCI Controllers present on TI's AM654 SOCs
+
+The bindings follow the mmc[1], clock[2] and interrupt[3] bindings.
+Only deviations are documented here.
+
+  [1] Documentation/devicetree/bindings/mmc/mmc.txt
+  [2] Documentation/devicetree/bindings/clock/clock-bindings.txt
+  [3] Documentation/devicetree/bindings/interrupt-controller/interrupts.txt
+
+Required Properties:
+	- compatible: should be "ti,am654-sdhci-5.1"
+	- reg: Must be two entries.
+		- The first should be the sdhci register space
+		- The second should the subsystem/phy register space
+	- clocks: Handles to the clock inputs.
+	- clock-names: Tuple including "clk_xin" and "clk_ahb"
+	- interrupts: Interrupt specifiers
+	- ti,otap-del-sel: Output Tap Delay select
+	- ti,trm-icp: DLL trim select
+	- ti,driver-strength-ohm: driver strength in ohms.
+				  Valid values are 33, 40, 50, 66 and 100 ohms.
+
+Example:
+
+	sdhci0: sdhci@4f80000 {
+		compatible = "ti,am654-sdhci-5.1";
+		reg = <0x0 0x4f80000 0x0 0x260>, <0x0 0x4f90000 0x0 0x134>;
+		power-domains = <&k3_pds 47>;
+		clocks = <&k3_clks 47 0>, <&k3_clks 47 1>;
+		clock-names = "clk_ahb", "clk_xin";
+		interrupts = <GIC_SPI 136 IRQ_TYPE_LEVEL_HIGH>;
+		sdhci-caps-mask = <0x80000007 0x0>;
+		mmc-ddr-1_8v;
+		ti,otap-del-sel = <0x2>;
+		ti,trm-icp = <0x8>;
+		status = "disabled";
+	};
-- 
2.19.2
