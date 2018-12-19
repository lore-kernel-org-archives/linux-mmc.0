From: Sowjanya Komatineni <skomatineni@nvidia.com>
Subject: [PATCH V2 2/3] arm64: dts: tegra210: Add SDMMC Auto-cal settings
Date: Wed, 19 Dec 2018 14:55:52 -0800
Message-ID: <1545260153-11338-2-git-send-email-skomatineni@nvidia.com>
References: <1545260153-11338-1-git-send-email-skomatineni@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1545260153-11338-1-git-send-email-skomatineni@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: robh+dt@kernel.org, mark.rutland@arm.com, mperttunen@nvidia.com, thierry.reding@gmail.com, jonathanh@nvidia.com, adrian.hunter@intel.com, ulf.hansson@linaro.org, pchandru@nvidia.com
Cc: devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, Sowjanya Komatineni <skomatineni@nvidia.com>
List-Id: linux-mmc@vger.kernel.org

Add SDMMC initial pad offsets used by auto calibration process.

Add SDMMC fixed drive strengths used when calibration timeouts.
Fixed drive strengths are based on Pre SI Analysis of the pads.

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra186.dtsi |  2 ++
 arch/arm64/boot/dts/nvidia/tegra194.dtsi | 34 +++++++++++++++++++
 arch/arm64/boot/dts/nvidia/tegra210.dtsi | 57 ++++++++++++++++++++++++++++++--
 3 files changed, 91 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/nvidia/tegra186.dtsi b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
index 2f3c8e29520d..0631bb9bfcc3 100644
--- a/arch/arm64/boot/dts/nvidia/tegra186.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
@@ -311,6 +311,8 @@
 		nvidia,pad-autocal-pull-down-offset-hs400 = <0x05>;
 		nvidia,pad-autocal-pull-up-offset-1v8-timeout = <0x0a>;
 		nvidia,pad-autocal-pull-down-offset-1v8-timeout = <0x0a>;
+		nvidia,pad-autocal-pull-up-offset-3v3-timeout = <0x0a>;
+		nvidia,pad-autocal-pull-down-offset-3v3-timeout = <0x0a>;
 		nvidia,default-tap = <0x5>;
 		nvidia,default-trim = <0x9>;
 		nvidia,dqs-trim = <63>;
diff --git a/arch/arm64/boot/dts/nvidia/tegra194.dtsi b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
index c2091bb16546..3fab6802c335 100644
--- a/arch/arm64/boot/dts/nvidia/tegra194.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
@@ -301,6 +301,17 @@
 			clock-names = "sdhci";
 			resets = <&bpmp TEGRA194_RESET_SDMMC1>;
 			reset-names = "sdhci";
+			nvidia,pad-autocal-pull-up-offset-3v3-timeout =
+									<0x07>;
+			nvidia,pad-autocal-pull-down-offset-3v3-timeout =
+									<0x07>;
+			nvidia,pad-autocal-pull-up-offset-1v8-timeout = <0x06>;
+			nvidia,pad-autocal-pull-down-offset-1v8-timeout =
+									<0x07>;
+			nvidia,pad-autocal-pull-up-offset-sdr104 = <0x00>;
+			nvidia,pad-autocal-pull-down-offset-sdr104 = <0x00>;
+			nvidia,default-tap = <0x9>;
+			nvidia,default-trim = <0x5>;
 			status = "disabled";
 		};
 
@@ -312,6 +323,18 @@
 			clock-names = "sdhci";
 			resets = <&bpmp TEGRA194_RESET_SDMMC3>;
 			reset-names = "sdhci";
+			nvidia,pad-autocal-pull-up-offset-1v8 = <0x00>;
+			nvidia,pad-autocal-pull-down-offset-1v8 = <0x7a>;
+			nvidia,pad-autocal-pull-up-offset-3v3-timeout = <0x07>;
+			nvidia,pad-autocal-pull-down-offset-3v3-timeout =
+									<0x07>;
+			nvidia,pad-autocal-pull-up-offset-1v8-timeout = <0x06>;
+			nvidia,pad-autocal-pull-down-offset-1v8-timeout =
+									<0x07>;
+			nvidia,pad-autocal-pull-up-offset-sdr104 = <0x00>;
+			nvidia,pad-autocal-pull-down-offset-sdr104 = <0x00>;
+			nvidia,default-tap = <0x9>;
+			nvidia,default-trim = <0x5>;
 			status = "disabled";
 		};
 
@@ -323,6 +346,17 @@
 			clock-names = "sdhci";
 			resets = <&bpmp TEGRA194_RESET_SDMMC4>;
 			reset-names = "sdhci";
+			nvidia,pad-autocal-pull-up-offset-hs400 = <0x00>;
+			nvidia,pad-autocal-pull-down-offset-hs400 = <0x00>;
+			nvidia,pad-autocal-pull-up-offset-1v8-timeout = <0x0a>;
+			nvidia,pad-autocal-pull-down-offset-1v8-timeout =
+									<0x0a>;
+			nvidia,pad-autocal-pull-up-offset-3v3-timeout = <0x0a>;
+			nvidia,pad-autocal-pull-down-offset-3v3-timeout =
+									<0x0a>;
+			nvidia,default-tap = <0x8>;
+			nvidia,default-trim = <0x14>;
+			nvidia,dqs-trim = <40>;
 			status = "disabled";
 		};
 
diff --git a/arch/arm64/boot/dts/nvidia/tegra210.dtsi b/arch/arm64/boot/dts/nvidia/tegra210.dtsi
index 2205d66b0443..41408df9d4e9 100644
--- a/arch/arm64/boot/dts/nvidia/tegra210.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra210.dtsi
@@ -476,6 +476,48 @@
 		compatible = "nvidia,tegra210-pinmux";
 		reg = <0x0 0x700008d4 0x0 0x29c>, /* Pad control registers */
 		      <0x0 0x70003000 0x0 0x294>; /* Mux registers */
+		sdmmc1_3v3_drv: sdmmc1-3v3-drv {
+			sdmmc1 {
+				nvidia,pins = "drive_sdmmc1";
+				nvidia,pull-down-strength = <0x8>;
+				nvidia,pull-up-strength = <0x8>;
+			};
+		};
+		sdmmc1_1v8_drv: sdmmc1-1v8-drv {
+			sdmmc1 {
+				nvidia,pins = "drive_sdmmc1";
+				nvidia,pull-down-strength = <0x4>;
+				nvidia,pull-up-strength = <0x3>;
+			};
+		};
+		sdmmc2_1v8_drv: sdmmc2-1v8-drv {
+			sdmmc2 {
+				nvidia,pins = "drive_sdmmc2";
+				nvidia,pull-down-strength = <0x10>;
+				nvidia,pull-up-strength = <0x10>;
+			};
+		};
+		sdmmc3_3v3_drv: sdmmc3-3v3-drv {
+			sdmmc3 {
+				nvidia,pins = "drive_sdmmc3";
+				nvidia,pull-down-strength = <0x8>;
+				nvidia,pull-up-strength = <0x8>;
+			};
+		};
+		sdmmc3_1v8_drv: sdmmc3-1v8-drv {
+			sdmmc3 {
+				nvidia,pins = "drive_sdmmc3";
+				nvidia,pull-down-strength = <0x4>;
+				nvidia,pull-up-strength = <0x3>;
+			};
+		};
+		sdmmc4_1v8_drv: sdmmc4-1v8-drv {
+			sdmmc4 {
+				nvidia,pins = "drive_sdmmc4";
+				nvidia,pull-down-strength = <0x10>;
+				nvidia,pull-up-strength = <0x10>;
+			};
+		};
 	};
 
 	/*
@@ -1050,9 +1092,12 @@
 		clock-names = "sdhci";
 		resets = <&tegra_car 14>;
 		reset-names = "sdhci";
-		pinctrl-names = "sdmmc-3v3", "sdmmc-1v8";
+		pinctrl-names = "sdmmc-3v3", "sdmmc-1v8",
+				"sdmmc-3v3-drv", "sdmmc-1v8-drv";
 		pinctrl-0 = <&sdmmc1_3v3>;
 		pinctrl-1 = <&sdmmc1_1v8>;
+		pinctrl-2 = <&sdmmc1_3v3_drv>;
+		pinctrl-3 = <&sdmmc1_1v8_drv>;
 		nvidia,pad-autocal-pull-up-offset-3v3 = <0x00>;
 		nvidia,pad-autocal-pull-down-offset-3v3 = <0x7d>;
 		nvidia,pad-autocal-pull-up-offset-1v8 = <0x7b>;
@@ -1075,6 +1120,8 @@
 		clock-names = "sdhci";
 		resets = <&tegra_car 9>;
 		reset-names = "sdhci";
+		pinctrl-names = "sdmmc-1v8-drv";
+		pinctrl-0 = <&sdmmc2_1v8_drv>;
 		nvidia,pad-autocal-pull-up-offset-1v8 = <0x05>;
 		nvidia,pad-autocal-pull-down-offset-1v8 = <0x05>;
 		nvidia,default-tap = <0x8>;
@@ -1090,9 +1137,12 @@
 		clock-names = "sdhci";
 		resets = <&tegra_car 69>;
 		reset-names = "sdhci";
-		pinctrl-names = "sdmmc-3v3", "sdmmc-1v8";
+		pinctrl-names = "sdmmc-3v3", "sdmmc-1v8",
+				"sdmmc-3v3-drv", "sdmmc-1v8-drv";
 		pinctrl-0 = <&sdmmc3_3v3>;
 		pinctrl-1 = <&sdmmc3_1v8>;
+		pinctrl-2 = <&sdmmc3_3v3_drv>;
+		pinctrl-3 = <&sdmmc3_1v8_drv>;
 		nvidia,pad-autocal-pull-up-offset-3v3 = <0x00>;
 		nvidia,pad-autocal-pull-down-offset-3v3 = <0x7d>;
 		nvidia,pad-autocal-pull-up-offset-1v8 = <0x7b>;
@@ -1110,6 +1160,9 @@
 		clock-names = "sdhci";
 		resets = <&tegra_car 15>;
 		reset-names = "sdhci";
+		pinctrl-names = "sdmmc-3v3-drv", "sdmmc-1v8-drv";
+		pinctrl-0 = <&sdmmc4_1v8_drv>;
+		pinctrl-1 = <&sdmmc4_1v8_drv>;
 		nvidia,pad-autocal-pull-up-offset-1v8 = <0x05>;
 		nvidia,pad-autocal-pull-down-offset-1v8 = <0x05>;
 		nvidia,default-tap = <0x8>;
-- 
2.7.4
