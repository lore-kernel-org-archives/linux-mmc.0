From: "Ramuthevar,Vadivel MuruganX"
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Subject: [PATCH v2 1/2] dt-bindings: mmc: sdhci-of-arasan: Add new compatible for Intel LGM SDXC
Date: Wed,  9 Oct 2019 09:28:17 +0800
Message-ID: <20191009012818.32763-2-vadivel.muruganx.ramuthevar@linux.intel.com>
References: <20191009012818.32763-1-vadivel.muruganx.ramuthevar@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191009012818.32763-1-vadivel.muruganx.ramuthevar@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, adrian.hunter@intel.com, ulf.hansson@linaro.org, michal.simek@xilinx.com, robh+dt@kernel.org, cheol.yong.kim@intel.com, qi-ming.wu@intel.com, Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
List-Id: linux-mmc@vger.kernel.org

From: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>

Add a new compatible to use the sdhc-arasan host controller driver
with the SDXC PHY to support on Intel's Lightning Mountain(LGM) SoC.

Signed-off-by: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
---
 Documentation/devicetree/bindings/mmc/arasan,sdhci.txt | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
index 7ca0aa7ccc0b..eb78d9a28c8b 100644
--- a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
+++ b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
@@ -19,6 +19,8 @@ Required Properties:
 	Note: This binding has been deprecated and moved to [5].
     - "intel,lgm-sdhci-5.1-emmc", "arasan,sdhci-5.1": Intel LGM eMMC PHY
       For this device it is strongly suggested to include arasan,soc-ctl-syscon.
+    - "intel,lgm-sdhci-5.1-sdxc", "arasan,sdhci-5.1": Intel LGM SDXC PHY
+      For this device it is strongly suggested to include arasan,soc-ctl-syscon.
 
   [5] Documentation/devicetree/bindings/mmc/sdhci-am654.txt
 
@@ -97,3 +99,18 @@ Example:
 		phy-names = "phy_arasan";
 		arasan,soc-ctl-syscon = <&sysconf>;
 	};
+
+	sdxc: sdhci@ec600000 {
+		compatible = "arasan,sdhci-5.1", "intel,lgm-sdhci-5.1-sdxc";
+		reg = <0xec600000 0x300>;
+		interrupt-parent = <&ioapic1>;
+		interrupts = <43 1>;
+		clocks = <&cgu0 LGM_CLK_SDIO>, <&cgu0 LGM_CLK_NGI>,
+			 <&cgu0 LGM_GCLK_SDXC>;
+		clock-names = "clk_xin", "clk_ahb", "gate";
+		clock-output-names = "sdxc_cardclock";
+		#clock-cells = <0>;
+		phys = <&sdxc_phy>;
+		phy-names = "phy_arasan";
+		arasan,soc-ctl-syscon = <&sysconf>;
+	};
-- 
2.11.0
