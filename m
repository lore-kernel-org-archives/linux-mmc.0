From: Aapo Vienamo <avienamo@nvidia.com>
Subject: [PATCH v3 01/38] dt-bindings: Add Tegra PMC pad configuration bindings
Date: Thu, 30 Aug 2018 18:06:02 +0300
Message-ID: <20180830150639.21048-2-avienamo@nvidia.com>
References: <20180830150639.21048-1-avienamo@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180830150639.21048-1-avienamo@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Mikko Perttunen <mperttunen@nvidia.com>, Stefan Agner <stefan@agner.ch>
Cc: devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, Aapo Vienamo <avienamo@nvidia.com>
List-Id: linux-mmc@vger.kernel.org

Document the PMC pinctrl bindings for pad power state and signaling
voltage configuration. Both nvidia,tegra186-pmc.txt and
nvidia,tegra20-pmc.txt are modified as they both cover SoC generations
for which these bindings apply.

Add a header defining Tegra PMC pad voltage configurations.

Signed-off-by: Aapo Vienamo <avienamo@nvidia.com>
Acked-by: Jon Hunter <jonathanh@nvidia.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Acked-by: Thierry Reding <treding@nvidia.com>
---
 .../arm/tegra/nvidia,tegra186-pmc.txt         |  93 ++++++++++++++++
 .../bindings/arm/tegra/nvidia,tegra20-pmc.txt | 103 ++++++++++++++++++
 .../pinctrl/pinctrl-tegra-io-pad.h            |  18 +++
 3 files changed, 214 insertions(+)
 create mode 100644 include/dt-bindings/pinctrl/pinctrl-tegra-io-pad.h

diff --git a/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra186-pmc.txt b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra186-pmc.txt
index 5a3bf7c5a7a0..c9fd6d1de57e 100644
--- a/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra186-pmc.txt
+++ b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra186-pmc.txt
@@ -34,3 +34,96 @@ Board DTS:
 	pmc@c360000 {
 		nvidia,invert-interrupt;
 	};
+
+== Pad Control ==
+
+On Tegra SoCs a pad is a set of pins which are configured as a group.
+The pin grouping is a fixed attribute of the hardware. The PMC can be
+used to set pad power state and signaling voltage. A pad can be either
+in active or power down mode. The support for power state and signaling
+voltage configuration varies depending on the pad in question. 3.3 V and
+1.8 V signaling voltages are supported on pins where software
+controllable signaling voltage switching is available.
+
+Pad configurations are described with pin configuration nodes which
+are placed under the pmc node and they are referred to by the pinctrl
+client properties. For more information see
+Documentation/devicetree/bindings/pinctrl/pinctrl-bindings.txt.
+
+The following pads are present on Tegra186:
+csia		csib		dsi		mipi-bias
+pex-clk-bias	pex-clk3	pex-clk2	pex-clk1
+usb0		usb1		usb2		usb-bias
+uart		audio		hsic		dbg
+hdmi-dp0	hdmi-dp1	pex-cntrl	sdmmc2-hv
+sdmmc4		cam		dsib		dsic
+dsid		csic		csid		csie
+dsif		spi		ufs		dmic-hv
+edp		sdmmc1-hv	sdmmc3-hv	conn
+audio-hv	ao-hv
+
+Required pin configuration properties:
+  - pins: A list of strings, each of which contains the name of a pad
+	  to be configured.
+
+Optional pin configuration properties:
+  - low-power-enable: Configure the pad into power down mode
+  - low-power-disable: Configure the pad into active mode
+  - power-source: Must contain either TEGRA_IO_PAD_VOLTAGE_1V8 or
+    TEGRA_IO_PAD_VOLTAGE_3V3 to select between signaling voltages.
+    The values are defined in
+    include/dt-bindings/pinctrl/pinctrl-tegra-io-pad.h.
+
+Note: The power state can be configured on all of the above pads except
+      for ao-hv. Following pads have software configurable signaling
+      voltages: sdmmc2-hv, dmic-hv, sdmmc1-hv, sdmmc3-hv, audio-hv,
+      ao-hv.
+
+Pad configuration state example:
+	pmc: pmc@7000e400 {
+		compatible = "nvidia,tegra186-pmc";
+		reg = <0 0x0c360000 0 0x10000>,
+		      <0 0x0c370000 0 0x10000>,
+		      <0 0x0c380000 0 0x10000>,
+		      <0 0x0c390000 0 0x10000>;
+		reg-names = "pmc", "wake", "aotag", "scratch";
+
+		...
+
+		sdmmc1_3v3: sdmmc1-3v3 {
+			pins = "sdmmc1-hv";
+			power-source = <TEGRA_IO_PAD_VOLTAGE_3V3>;
+		};
+
+		sdmmc1_1v8: sdmmc1-1v8 {
+			pins = "sdmmc1-hv";
+			power-source = <TEGRA_IO_PAD_VOLTAGE_1V8>;
+		};
+
+		hdmi_off: hdmi-off {
+			pins = "hdmi";
+			low-power-enable;
+		}
+
+		hdmi_on: hdmi-on {
+			pins = "hdmi";
+			low-power-disable;
+		}
+	};
+
+Pinctrl client example:
+	sdmmc1: sdhci@3400000 {
+		...
+		pinctrl-names = "sdmmc-3v3", "sdmmc-1v8";
+		pinctrl-0 = <&sdmmc1_3v3>;
+		pinctrl-1 = <&sdmmc1_1v8>;
+	};
+
+	...
+
+	sor0: sor@15540000 {
+		...
+		pinctrl-0 = <&hdmi_off>;
+		pinctrl-1 = <&hdmi_on>;
+		pinctrl-names = "hdmi-on", "hdmi-off";
+	};
diff --git a/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-pmc.txt b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-pmc.txt
index a74b37b07e5c..cb12f33a247f 100644
--- a/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-pmc.txt
+++ b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-pmc.txt
@@ -195,3 +195,106 @@ Example:
 		power-domains = <&pd_audio>;
 		...
 	};
+
+== Pad Control ==
+
+On Tegra SoCs a pad is a set of pins which are configured as a group.
+The pin grouping is a fixed attribute of the hardware. The PMC can be
+used to set pad power state and signaling voltage. A pad can be either
+in active or power down mode. The support for power state and signaling
+voltage configuration varies depending on the pad in question. 3.3 V and
+1.8 V signaling voltages are supported on pins where software
+controllable signaling voltage switching is available.
+
+The pad configuration state nodes are placed under the pmc node and they
+are referred to by the pinctrl client properties. For more information
+see Documentation/devicetree/bindings/pinctrl/pinctrl-bindings.txt.
+The pad name should be used as the value of the pins property in pin
+configuration nodes.
+
+The following pads are present on Tegra124 and Tegra132:
+audio		bb		cam		comp
+csia		csb		cse		dsi
+dsib		dsic		dsid		hdmi
+hsic		hv		lvds		mipi-bias
+nand		pex-bias	pex-clk1	pex-clk2
+pex-cntrl	sdmmc1		sdmmc3		sdmmc4
+sys_ddc		uart		usb0		usb1
+usb2		usb_bias
+
+The following pads are present on Tegra210:
+audio		audio-hv	cam		csia
+csib		csic		csid		csie
+csif		dbg		debug-nonao	dmic
+dp		dsi		dsib		dsic
+dsid		emmc		emmc2		gpio
+hdmi		hsic		lvds		mipi-bias
+pex-bias	pex-clk1	pex-clk2	pex-cntrl
+sdmmc1		sdmmc3		spi		spi-hv
+uart		usb0		usb1		usb2
+usb3		usb-bias
+
+Required pin configuration properties:
+  - pins: Must contain name of the pad(s) to be configured.
+
+Optional pin configuration properties:
+  - low-power-enable: Configure the pad into power down mode
+  - low-power-disable: Configure the pad into active mode
+  - power-source: Must contain either TEGRA_IO_PAD_VOLTAGE_1V8
+    or TEGRA_IO_PAD_VOLTAGE_3V3 to select between signaling voltages.
+    The values are defined in
+    include/dt-bindings/pinctrl/pinctrl-tegra-io-pad.h.
+
+Note: The power state can be configured on all of the Tegra124 and
+      Tegra132 pads. None of the Tegra124 or Tegra132 pads support
+      signaling voltage switching.
+
+Note: All of the listed Tegra210 pads except pex-cntrl support power
+      state configuration. Signaling voltage switching is supported on
+      following Tegra210 pads: audio, audio-hv, cam, dbg, dmic, gpio,
+      pex-cntrl, sdmmc1, sdmmc3, spi, spi-hv, and uart.
+
+Pad configuration state example:
+	pmc: pmc@7000e400 {
+		compatible = "nvidia,tegra210-pmc";
+		reg = <0x0 0x7000e400 0x0 0x400>;
+		clocks = <&tegra_car TEGRA210_CLK_PCLK>, <&clk32k_in>;
+		clock-names = "pclk", "clk32k_in";
+
+		...
+
+		sdmmc1_3v3: sdmmc1-3v3 {
+			pins = "sdmmc1";
+			power-source = <TEGRA_IO_PAD_VOLTAGE_3V3>;
+		};
+
+		sdmmc1_1v8: sdmmc1-1v8 {
+			pins = "sdmmc1";
+			power-source = <TEGRA_IO_PAD_VOLTAGE_1V8>;
+		};
+
+		hdmi_off: hdmi-off {
+			pins = "hdmi";
+			low-power-enable;
+		}
+
+		hdmi_on: hdmi-on {
+			pins = "hdmi";
+			low-power-disable;
+		}
+	};
+
+Pinctrl client example:
+	sdmmc1: sdhci@700b0000 {
+		...
+		pinctrl-names = "sdmmc-3v3", "sdmmc-1v8";
+		pinctrl-0 = <&sdmmc1_3v3>;
+		pinctrl-1 = <&sdmmc1_1v8>;
+	};
+	...
+	sor@54540000 {
+		...
+		pinctrl-0 = <&hdmi_off>;
+		pinctrl-1 = <&hdmi_on>;
+		pinctrl-names = "hdmi-on", "hdmi-off";
+	};
diff --git a/include/dt-bindings/pinctrl/pinctrl-tegra-io-pad.h b/include/dt-bindings/pinctrl/pinctrl-tegra-io-pad.h
new file mode 100644
index 000000000000..20f43404cac0
--- /dev/null
+++ b/include/dt-bindings/pinctrl/pinctrl-tegra-io-pad.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * pinctrl-tegra-io-pad.h: Tegra I/O pad source voltage configuration constants
+ * pinctrl bindings.
+ *
+ * Copyright (c) 2018, NVIDIA CORPORATION.  All rights reserved.
+ *
+ * Author: Aapo Vienamo <avienamo@nvidia.com>
+ */
+
+#ifndef _DT_BINDINGS_PINCTRL_TEGRA_IO_PAD_H
+#define _DT_BINDINGS_PINCTRL_TEGRA_IO_PAD_H
+
+/* Voltage levels of the I/O pad's source rail */
+#define TEGRA_IO_PAD_VOLTAGE_1V8	0
+#define TEGRA_IO_PAD_VOLTAGE_3V3	1
+
+#endif
-- 
2.18.0
