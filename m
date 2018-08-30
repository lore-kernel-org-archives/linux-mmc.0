From: Aapo Vienamo <avienamo@nvidia.com>
Subject: [PATCH v3 33/38] arm64: dts: tegra186: Add sdmmc pad auto calibration offsets
Date: Thu, 30 Aug 2018 18:06:34 +0300
Message-ID: <20180830150639.21048-34-avienamo@nvidia.com>
References: <20180830150639.21048-1-avienamo@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180830150639.21048-1-avienamo@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Mikko Perttunen <mperttunen@nvidia.com>, Stefan Agner <stefan@agner.ch>
Cc: devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, Aapo Vienamo <avienamo@nvidia.com>
List-Id: linux-mmc@vger.kernel.org

Add the calibration offset properties used for automatic pad drive
strength calibration.

Signed-off-by: Aapo Vienamo <avienamo@nvidia.com>
Acked-by: Thierry Reding <treding@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra186.dtsi | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra186.dtsi b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
index 7669756c060f..b7020dd2be44 100644
--- a/arch/arm64/boot/dts/nvidia/tegra186.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
@@ -240,6 +240,12 @@
 		pinctrl-names = "sdmmc-3v3", "sdmmc-1v8";
 		pinctrl-0 = <&sdmmc1_3v3>;
 		pinctrl-1 = <&sdmmc1_1v8>;
+		nvidia,pad-autocal-pull-up-offset-3v3-timeout = <0x07>;
+		nvidia,pad-autocal-pull-down-offset-3v3-timeout = <0x06>;
+		nvidia,pad-autocal-pull-up-offset-1v8-timeout = <0x07>;
+		nvidia,pad-autocal-pull-down-offset-1v8-timeout = <0x07>;
+		nvidia,pad-autocal-pull-up-offset-sdr104 = <0x03>;
+		nvidia,pad-autocal-pull-down-offset-sdr104 = <0x05>;
 		status = "disabled";
 	};
 
@@ -254,6 +260,10 @@
 		pinctrl-names = "sdmmc-3v3", "sdmmc-1v8";
 		pinctrl-0 = <&sdmmc2_3v3>;
 		pinctrl-1 = <&sdmmc2_1v8>;
+		nvidia,pad-autocal-pull-up-offset-3v3-timeout = <0x07>;
+		nvidia,pad-autocal-pull-down-offset-3v3-timeout = <0x06>;
+		nvidia,pad-autocal-pull-up-offset-1v8-timeout = <0x07>;
+		nvidia,pad-autocal-pull-down-offset-1v8-timeout = <0x07>;
 		status = "disabled";
 	};
 
@@ -268,6 +278,12 @@
 		pinctrl-names = "sdmmc-3v3", "sdmmc-1v8";
 		pinctrl-0 = <&sdmmc3_3v3>;
 		pinctrl-1 = <&sdmmc3_1v8>;
+		nvidia,pad-autocal-pull-up-offset-1v8 = <0x00>;
+		nvidia,pad-autocal-pull-down-offset-1v8 = <0x7a>;
+		nvidia,pad-autocal-pull-up-offset-3v3-timeout = <0x07>;
+		nvidia,pad-autocal-pull-down-offset-3v3-timeout = <0x06>;
+		nvidia,pad-autocal-pull-up-offset-1v8-timeout = <0x07>;
+		nvidia,pad-autocal-pull-down-offset-1v8-timeout = <0x07>;
 		status = "disabled";
 	};
 
@@ -279,6 +295,10 @@
 		clock-names = "sdhci";
 		resets = <&bpmp TEGRA186_RESET_SDMMC4>;
 		reset-names = "sdhci";
+		nvidia,pad-autocal-pull-up-offset-hs400 = <0x05>;
+		nvidia,pad-autocal-pull-down-offset-hs400 = <0x05>;
+		nvidia,pad-autocal-pull-up-offset-1v8-timeout = <0x0a>;
+		nvidia,pad-autocal-pull-down-offset-1v8-timeout = <0x0a>;
 		status = "disabled";
 	};
 
-- 
2.18.0
