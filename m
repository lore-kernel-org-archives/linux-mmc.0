From: Takao Orito <orito.takao@socionext.com>
Subject: [PATCH v2 1/2] dt-bindings: mmc: add DT bindings for Milbeaut SD controller
Date: Thu, 30 May 2019 18:22:11 +0900
Message-ID: <1559208131-426-1-git-send-email-orito.takao@socionext.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: ulf.hansson@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, masami.hiramatsu@linaro.org, jaswinder.singh@linaro.org, sugaya.taichi@socionext.com, kasai.kazuhiro@socionext.com, kanematsu.shinji@socionext.com, orito.takao@socionext.com
List-Id: linux-mmc@vger.kernel.org

Add the device-tree binding documentation for Milbeaut SDHCI driver.

Signed-off-by: Takao Orito <orito.takao@socionext.com>
---
 .../devicetree/bindings/mmc/sdhci-milbeaut.txt     | 32 ++++++++++++++++++++++
 1 file changed, 32 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mmc/sdhci-milbeaut.txt

diff --git a/Documentation/devicetree/bindings/mmc/sdhci-milbeaut.txt b/Documentation/devicetree/bindings/mmc/sdhci-milbeaut.txt
new file mode 100644
index 0000000..6063116
--- /dev/null
+++ b/Documentation/devicetree/bindings/mmc/sdhci-milbeaut.txt
@@ -0,0 +1,32 @@
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
+- vmmc-supply: a phandle of a fixed GPIO regulator
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
+		vmmc-supply = <&vcc_sdhci3>;
+		fujitsu,cmd-dat-delay-select;
+	};
-- 
1.9.1
