From: Takao Orito <orito.takao@socionext.com>
Subject: [PATCH v3 1/2] dt-bindings: mmc: add DT bindings for Milbeaut SD controller
Date: Tue, 10 Sep 2019 10:40:52 +0900
Message-ID: <1568079652-28849-1-git-send-email-orito.takao@socionext.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: ulf.hansson@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, adrian.hunter@intel.com
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, masami.hiramatsu@linaro.org, jaswinder.singh@linaro.org, sugaya.taichi@socionext.com, kasai.kazuhiro@socionext.com, kanematsu.shinji@socionext.com, orito.takao@socionext.com
List-Id: linux-mmc@vger.kernel.org

Add the device-tree binding documentation for Milbeaut SDHCI driver.

Signed-off-by: Takao Orito <orito.takao@socionext.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/mmc/sdhci-milbeaut.txt     | 30 ++++++++++++++++++++++
 1 file changed, 30 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mmc/sdhci-milbeaut.txt

diff --git a/Documentation/devicetree/bindings/mmc/sdhci-milbeaut.txt b/Documentation/devicetree/bindings/mmc/sdhci-milbeaut.txt
new file mode 100644
index 0000000..627ee89
--- /dev/null
+++ b/Documentation/devicetree/bindings/mmc/sdhci-milbeaut.txt
@@ -0,0 +1,30 @@
+* SOCIONEXT Milbeaut SDHCI controller
+
+This file documents differences between the core properties in mmc.txt
+and the properties used by the sdhci_milbeaut driver.
+
+Required properties:
+- compatible: "socionext,milbeaut-m10v-sdhci-3.0"
+- clocks: Must contain an entry for each entry in clock-names. It is a
+  list of phandles and clock-specifier pairs.
+  See ../clocks/clock-bindings.txt for details.
+- clock-names: Should contain the following two entries:
+	"iface" - clock used for sdhci interface
+	"core"  - core clock for sdhci controller
+
+Optional properties:
+- fujitsu,cmd-dat-delay-select: boolean property indicating that this host
+  requires the CMD_DAT_DELAY control to be enabled.
+
+Example:
+	sdhci3: mmc@1b010000 {
+		compatible = "socionext,milbeaut-m10v-sdhci-3.0";
+		reg = <0x1b010000 0x10000>;
+		interrupts = <0 265 0x4>;
+		voltage-ranges = <3300 3300>;
+		bus-width = <4>;
+		clocks = <&clk 7>, <&ahb_clk>;
+		clock-names = "core", "iface";
+		cap-sdio-irq;
+		fujitsu,cmd-dat-delay-select;
+	};
-- 
1.9.1
