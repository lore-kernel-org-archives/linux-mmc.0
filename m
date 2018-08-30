From: Aapo Vienamo <avienamo@nvidia.com>
Subject: [PATCH v3 38/38] arm64: dts: tegra210: Assign clocks for sdmmc1 and sdmmc4
Date: Thu, 30 Aug 2018 18:06:39 +0300
Message-ID: <20180830150639.21048-39-avienamo@nvidia.com>
References: <20180830150639.21048-1-avienamo@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180830150639.21048-1-avienamo@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Mikko Perttunen <mperttunen@nvidia.com>, Stefan Agner <stefan@agner.ch>
Cc: devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, Aapo Vienamo <avienamo@nvidia.com>
List-Id: linux-mmc@vger.kernel.org

Use assigned-clock properties to configure pllc4 as the parent clock
for sdmmc4 on Tegra210. pllc4 offers better jitter perfomance than
the default pllp and is required by HS200 and HS400 modes.

Signed-off-by: Aapo Vienamo <avienamo@nvidia.com>
Acked-by: Thierry Reding <treding@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra210.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra210.dtsi b/arch/arm64/boot/dts/nvidia/tegra210.dtsi
index 0951acc69cc8..14da98ac65e8 100644
--- a/arch/arm64/boot/dts/nvidia/tegra210.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra210.dtsi
@@ -1057,6 +1057,11 @@
 		nvidia,pad-autocal-pull-down-offset-1v8 = <0x7b>;
 		nvidia,default-tap = <0x2>;
 		nvidia,default-trim = <0x4>;
+		assigned-clocks = <&tegra_car TEGRA210_CLK_SDMMC4>,
+				  <&tegra_car TEGRA210_CLK_PLL_C4_OUT0>,
+				  <&tegra_car TEGRA210_CLK_PLL_C4>;
+		assigned-clock-parents = <&tegra_car TEGRA210_CLK_PLL_C4_OUT0>;
+		assigned-clock-rates = <200000000>, <1000000000>, <1000000000>;
 		status = "disabled";
 	};
 
@@ -1107,6 +1112,9 @@
 		nvidia,pad-autocal-pull-down-offset-1v8 = <0x05>;
 		nvidia,default-tap = <0x8>;
 		nvidia,default-trim = <0x0>;
+		assigned-clocks = <&tegra_car TEGRA210_CLK_SDMMC4>,
+				  <&tegra_car TEGRA210_CLK_PLL_C4_OUT0>;
+		assigned-clock-parents = <&tegra_car TEGRA210_CLK_PLL_C4_OUT0>;
 		status = "disabled";
 	};
 
-- 
2.18.0
