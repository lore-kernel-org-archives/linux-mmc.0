From: Aapo Vienamo <avienamo@nvidia.com>
Subject: [PATCH v2 36/40] arm64: dts: tegra210: Add sdmmc pad auto calibration offsets
Date: Fri, 10 Aug 2018 21:08:38 +0300
Message-ID: <1533924522-1037-37-git-send-email-avienamo@nvidia.com>
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
 arch/arm64/boot/dts/nvidia/tegra210.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra210.dtsi b/arch/arm64/boot/dts/nvidia/tegra210.dtsi
index bc1918e..2a80f2b 100644
--- a/arch/arm64/boot/dts/nvidia/tegra210.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra210.dtsi
@@ -1051,6 +1051,10 @@
 		pinctrl-names = "sdmmc-3v3", "sdmmc-1v8";
 		pinctrl-0 = <&sdmmc1_3v3>;
 		pinctrl-1 = <&sdmmc1_1v8>;
+		nvidia,pad-autocal-pull-up-offset-3v3 = <0x00>;
+		nvidia,pad-autocal-pull-down-offset-3v3 = <0x7d>;
+		nvidia,pad-autocal-pull-up-offset-1v8 = <0x7b>;
+		nvidia,pad-autocal-pull-down-offset-1v8 = <0x7b>;
 		status = "disabled";
 	};
 
@@ -1062,6 +1066,8 @@
 		clock-names = "sdhci";
 		resets = <&tegra_car 9>;
 		reset-names = "sdhci";
+		nvidia,pad-autocal-pull-up-offset-1v8 = <0x05>;
+		nvidia,pad-autocal-pull-down-offset-1v8 = <0x05>;
 		status = "disabled";
 	};
 
@@ -1076,6 +1082,10 @@
 		pinctrl-names = "sdmmc-3v3", "sdmmc-1v8";
 		pinctrl-0 = <&sdmmc3_3v3>;
 		pinctrl-1 = <&sdmmc3_1v8>;
+		nvidia,pad-autocal-pull-up-offset-3v3 = <0x00>;
+		nvidia,pad-autocal-pull-down-offset-3v3 = <0x7d>;
+		nvidia,pad-autocal-pull-up-offset-1v8 = <0x7b>;
+		nvidia,pad-autocal-pull-down-offset-1v8 = <0x7b>;
 		status = "disabled";
 	};
 
@@ -1087,6 +1097,8 @@
 		clock-names = "sdhci";
 		resets = <&tegra_car 15>;
 		reset-names = "sdhci";
+		nvidia,pad-autocal-pull-up-offset-1v8 = <0x05>;
+		nvidia,pad-autocal-pull-down-offset-1v8 = <0x05>;
 		status = "disabled";
 	};
 
-- 
2.7.4
