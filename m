From: Aapo Vienamo <avienamo@nvidia.com>
Subject: [PATCH v2 07/10] arm64: dts: tegra186: Add sdmmc pad auto calibration offsets
Date: Thu, 26 Jul 2018 15:26:53 +0300
Message-ID: <1532608016-14319-8-git-send-email-avienamo@nvidia.com>
References: <1532608016-14319-1-git-send-email-avienamo@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1532608016-14319-1-git-send-email-avienamo@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, Adrian Hunter <adrian.hunter@intel.com>, Mikko Perttunen <mperttunen@nvidia.com>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, Aapo Vienamo <avienamo@nvidia.com>
List-Id: linux-mmc@vger.kernel.org

Add the calibration offset properties used for automatic pad drive
strength calibration.

Signed-off-by: Aapo Vienamo <avienamo@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra186.dtsi | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra186.dtsi b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
index fc14dd3..1c5535b 100644
--- a/arch/arm64/boot/dts/nvidia/tegra186.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
@@ -240,6 +240,12 @@
 		pinctrl-names = "sdmmc-3v3", "sdmmc-1v8";
 		pinctrl-0 = <&sdmmc1_3v3>;
 		pinctrl-1 = <&sdmmc1_1v8>;
+		pad-autocal-pull-up-offset-3v3-timeout = <0x07>;
+		pad-autocal-pull-down-offset-3v3-timeout = <0x06>;
+		pad-autocal-pull-up-offset-1v8-timeout = <0x07>;
+		pad-autocal-pull-down-offset-1v8-timeout = <0x07>;
+		pad-autocal-pull-up-offset-sdr104 = <0x03>;
+		pad-autocal-pull-down-offset-sdr104 = <0x05>;
 		status = "disabled";
 	};
 
@@ -254,6 +260,10 @@
 		pinctrl-names = "sdmmc-3v3", "sdmmc-1v8";
 		pinctrl-0 = <&sdmmc2_3v3>;
 		pinctrl-1 = <&sdmmc2_1v8>;
+		pad-autocal-pull-up-offset-3v3-timeout = <0x07>;
+		pad-autocal-pull-down-offset-3v3-timeout = <0x06>;
+		pad-autocal-pull-up-offset-1v8-timeout = <0x07>;
+		pad-autocal-pull-down-offset-1v8-timeout = <0x07>;
 		status = "disabled";
 	};
 
@@ -268,6 +278,12 @@
 		pinctrl-names = "sdmmc-3v3", "sdmmc-1v8";
 		pinctrl-0 = <&sdmmc3_3v3>;
 		pinctrl-1 = <&sdmmc3_1v8>;
+		pad-autocal-pull-up-offset-1v8 = <0x00>;
+		pad-autocal-pull-down-offset-1v8 = <0x7a>;
+		pad-autocal-pull-up-offset-3v3-timeout = <0x07>;
+		pad-autocal-pull-down-offset-3v3-timeout = <0x06>;
+		pad-autocal-pull-up-offset-1v8-timeout = <0x07>;
+		pad-autocal-pull-down-offset-1v8-timeout = <0x07>;
 		status = "disabled";
 	};
 
@@ -280,6 +296,10 @@
 		resets = <&bpmp TEGRA186_RESET_SDMMC4>;
 		reset-names = "sdhci";
 		nvidia,only-1-8-v;
+		pad-autocal-pull-up-offset-hs400 = <0x05>;
+		pad-autocal-pull-down-offset-hs400 = <0x05>;
+		pad-autocal-pull-up-offset-1v8-timeout = <0x0a>;
+		pad-autocal-pull-down-offset-1v8-timeout = <0x0a>;
 		status = "disabled";
 	};
 
-- 
2.7.4
