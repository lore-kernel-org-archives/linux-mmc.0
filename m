From: Baolin Wang <baolin.wang@linaro.org>
Subject: [PATCH 2/3] dt-bindings: mmc: sprd: Add pinctrl support
Date: Fri, 21 Jun 2019 14:12:32 +0800
Message-ID: <73f6c1291e4c15da6be53a6dd4602622e142fefb.1561094029.git.baolin.wang@linaro.org>
References: <cover.1561094029.git.baolin.wang@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1561094029.git.baolin.wang@linaro.org>
In-Reply-To: <cover.1561094029.git.baolin.wang@linaro.org>
References: <cover.1561094029.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: adrian.hunter@intel.com, ulf.hansson@linaro.org, zhang.lyra@gmail.com, orsonzhai@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com
Cc: baolin.wang@linaro.org, vincent.guittot@linaro.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

When changing SD card voltage signal for Spreadtrum SD host controller,
it also need to switch related pin's state. Thus add pinctrl properties'
description in documentation.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 .../devicetree/bindings/mmc/sdhci-sprd.txt         |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/sdhci-sprd.txt b/Documentation/devicetree/bindings/mmc/sdhci-sprd.txt
index e675397..eb7eb1b 100644
--- a/Documentation/devicetree/bindings/mmc/sdhci-sprd.txt
+++ b/Documentation/devicetree/bindings/mmc/sdhci-sprd.txt
@@ -19,6 +19,9 @@ Required properties:
 Optional properties:
 - assigned-clocks: the same with "sdio" clock
 - assigned-clock-parents: the default parent of "sdio" clock
+- pinctrl-names: should be "default", "state_uhs"
+- pinctrl-0: should contain default/high speed pin control
+- pinctrl-1: should contain uhs mode pin control
 
 PHY DLL delays are used to delay the data valid window, and align the window
 to sampling clock. PHY DLL delays can be configured by following properties,
@@ -50,6 +53,10 @@ sdio0: sdio@20600000 {
 	assigned-clocks = <&ap_clk CLK_EMMC_2X>;
 	assigned-clock-parents = <&rpll CLK_RPLL_390M>;
 
+	pinctrl-names = "default", "state_uhs";
+	pinctrl-0 = <&sd0_pins_default>;
+	pinctrl-1 = <&sd0_pins_uhs>;
+
 	sprd,phy-delay-sd-uhs-sdr104 = <0x3f 0x7f 0x2e 0x2e>;
 	bus-width = <8>;
 	non-removable;
-- 
1.7.9.5
