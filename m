From: Aapo Vienamo <avienamo@nvidia.com>
Subject: [PATCH v2 35/40] arm64: dts: tegra186: Add sdmmc pad auto calibration offsets
Date: Fri, 10 Aug 2018 21:08:37 +0300
Message-ID: <1533924522-1037-36-git-send-email-avienamo@nvidia.com>
References: <1533924522-1037-1-git-send-email-avienamo@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1533924522-1037-1-git-send-email-avienamo@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Mikko Perttunen <mperttunen@nvidia.com>, Stefan Agner <stefan@agner.ch>
Cc: devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, Aapo Vienamo <avienamo@nvidia.com>
List-Id: linux-mmc@vger.kernel.org

Add the calibration offset properties used for automatic pad drive
strength calibration.

Signed-off-by: Aapo Vienamo <avienamo@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra186.dtsi | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra186.dtsi b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
index 7669756..b7020dd 100644
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
2.7.4
