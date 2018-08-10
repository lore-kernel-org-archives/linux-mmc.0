From: Aapo Vienamo <avienamo@nvidia.com>
Subject: [PATCH v2 31/40] arm64: dts: Add Tegra186 sdmmc pinctrl voltage states
Date: Fri, 10 Aug 2018 21:08:33 +0300
Message-ID: <1533924522-1037-32-git-send-email-avienamo@nvidia.com>
References: <1533924522-1037-1-git-send-email-avienamo@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1533924522-1037-1-git-send-email-avienamo@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Mikko Perttunen <mperttunen@nvidia.com>, Stefan Agner <stefan@agner.ch>
Cc: devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, Aapo Vienamo <avienamo@nvidia.com>
List-Id: linux-mmc@vger.kernel.org

Add pad voltage configuration nodes for sdmmc pads with configurable
voltages on Tegra186.

Signed-off-by: Aapo Vienamo <avienamo@nvidia.com>
Reviewed-by: Mikko Perttunen <mperttunen@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra186.dtsi | 40 ++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra186.dtsi b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
index b762227..7669756 100644
--- a/arch/arm64/boot/dts/nvidia/tegra186.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
@@ -4,6 +4,7 @@
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/mailbox/tegra186-hsp.h>
 #include <dt-bindings/memory/tegra186-mc.h>
+#include <dt-bindings/pinctrl/pinctrl-tegra-io-pad.h>
 #include <dt-bindings/power/tegra186-powergate.h>
 #include <dt-bindings/reset/tegra186-reset.h>
 #include <dt-bindings/thermal/tegra186-bpmp-thermal.h>
@@ -236,6 +237,9 @@
 		clock-names = "sdhci";
 		resets = <&bpmp TEGRA186_RESET_SDMMC1>;
 		reset-names = "sdhci";
+		pinctrl-names = "sdmmc-3v3", "sdmmc-1v8";
+		pinctrl-0 = <&sdmmc1_3v3>;
+		pinctrl-1 = <&sdmmc1_1v8>;
 		status = "disabled";
 	};
 
@@ -247,6 +251,9 @@
 		clock-names = "sdhci";
 		resets = <&bpmp TEGRA186_RESET_SDMMC2>;
 		reset-names = "sdhci";
+		pinctrl-names = "sdmmc-3v3", "sdmmc-1v8";
+		pinctrl-0 = <&sdmmc2_3v3>;
+		pinctrl-1 = <&sdmmc2_1v8>;
 		status = "disabled";
 	};
 
@@ -258,6 +265,9 @@
 		clock-names = "sdhci";
 		resets = <&bpmp TEGRA186_RESET_SDMMC3>;
 		reset-names = "sdhci";
+		pinctrl-names = "sdmmc-3v3", "sdmmc-1v8";
+		pinctrl-0 = <&sdmmc3_3v3>;
+		pinctrl-1 = <&sdmmc3_1v8>;
 		status = "disabled";
 	};
 
@@ -368,6 +378,36 @@
 		      <0 0x0c380000 0 0x10000>,
 		      <0 0x0c390000 0 0x10000>;
 		reg-names = "pmc", "wake", "aotag", "scratch";
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
+		sdmmc2_3v3: sdmmc2-3v3 {
+			pins = "sdmmc2-hv";
+			power-source = <TEGRA_IO_PAD_VOLTAGE_3V3>;
+		};
+
+		sdmmc2_1v8: sdmmc2-1v8 {
+			pins = "sdmmc2-hv";
+			power-source = <TEGRA_IO_PAD_VOLTAGE_1V8>;
+		};
+
+		sdmmc3_3v3: sdmmc3-3v3 {
+			pins = "sdmmc3-hv";
+			power-source = <TEGRA_IO_PAD_VOLTAGE_3V3>;
+		};
+
+		sdmmc3_1v8: sdmmc3-1v8 {
+			pins = "sdmmc3-hv";
+			power-source = <TEGRA_IO_PAD_VOLTAGE_1V8>;
+		};
 	};
 
 	ccplex@e000000 {
-- 
2.7.4
