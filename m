From: Takao Orito <orito.takao@socionext.com>
Subject: [PATCH v1 1/2] dt-bindings: mmc: sdhci-fujitsu.txt: add miilbeaut driver
Date: Tue, 26 Mar 2019 14:53:37 +0900
Message-ID: <1553579617-6139-1-git-send-email-orito.takao@socionext.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: ulf.hansson@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, masami.hiramatsu@linaro.org, jaswinder.singh@linaro.org, sugaya.taichi@socionext.com, kasai.kazuhiro@socionext.com, kanematsu.shinji@socionext.com, orito.takao@socionext.com
List-Id: linux-mmc@vger.kernel.org

Add new compatible description for Milbeaut SoC. Socionext
inherits F_SDH30 IP from Fujitsu. Then new Soc series "Milbeaut"
has F_SDH30 controller specified by "socionext,milbeaut-m10v-sdhci-3.0".

Signed-off-by: Takao Orito <orito.takao@socionext.com>
---
 .../devicetree/bindings/mmc/sdhci-fujitsu.txt      | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/sdhci-fujitsu.txt b/Documentation/devicetree/bindings/mmc/sdhci-fujitsu.txt
index 3ee9263..405811f 100644
--- a/Documentation/devicetree/bindings/mmc/sdhci-fujitsu.txt
+++ b/Documentation/devicetree/bindings/mmc/sdhci-fujitsu.txt
@@ -1,10 +1,10 @@
-* Fujitsu SDHCI controller
+* Fujitsu/Socionext SDHCI controller
 
 This file documents differences between the core properties in mmc.txt
-and the properties used by the sdhci_f_sdh30 driver.
+and the properties used by the sdhci_f_sdh30.
 
 Required properties:
-- compatible: "fujitsu,mb86s70-sdhci-3.0"
+- compatible: "fujitsu,mb86s70-sdhci-3.0", "socionext,milbeaut-m10v-sdhci-3.0"
 - clocks: Must contain an entry for each entry in clock-names. It is a
   list of phandles and clock-specifier pairs.
   See ../clocks/clock-bindings.txt for details.
@@ -17,6 +17,8 @@ Optional properties:
   as the VCCQ/VDD_IO supply in the eMMC/SD specs.
 - fujitsu,cmd-dat-delay-select: boolean property indicating that this host
   requires the CMD_DAT_DELAY control to be enabled.
+- sni,mmc-power-gpio: set property indicating that power on or off needs
+  control of gpio. This is for only "socionext,milbeaut-m10v-sdhci-3.0".
 
 Example:
 
@@ -30,3 +32,17 @@ Example:
 		clocks = <&clock 2 2 0>, <&clock 2 3 0>;
 		clock-names = "iface", "core";
 	};
+
+Exsample2:
+	sdhci3: mmc@1b010000 {
+		compatible = "socionext,milbeaut-m10v-sdhci-3.0";
+		reg = <0x1b010000 0x10000>;
+		interrupts = <0 265 0x4>;
+		voltage-ranges = <3300 3300>;
+		bus-width = <4>;
+		clocks = <&uhs1clk2>, <&ahb_clk>;
+		clock-names = "core", "iface";
+		cap-sdio-irq;
+		sni,mmc-power-gpio = <&pinctrl 53 GPIO_ACTIVE_HIGH>;
+			   fujitsu,cmd-dat-delay-select;
+	};
-- 
1.9.1
