From: Aapo Vienamo <avienamo@nvidia.com>
Subject: [PATCH 39/40] arm64: dts: tegra186: Assign clocks for sdmmc1 and sdmmc4
Date: Wed, 1 Aug 2018 19:32:29 +0300
Message-ID: <1533141150-10511-40-git-send-email-avienamo@nvidia.com>
References: <1533141150-10511-1-git-send-email-avienamo@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1533141150-10511-1-git-send-email-avienamo@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Mikko Perttunen <mperttunen@nvidia.com>, Stefan Agner <stefan@agner.ch>
Cc: devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, Aapo Vienamo <avienamo@nvidia.com>
List-Id: linux-mmc@vger.kernel.org

Configure sdmmc4 parent clock to pllc4 and sdmmc1 to pllp_out0 by
setting the assigned-clocks device tree properties. pllc4 offer
better jitter performance and should be used with higher speed
modes like HS200 and HS400.

Signed-off-by: Aapo Vienamo <avienamo@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra186.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra186.dtsi b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
index 3b2fe0d..6e9ef26 100644
--- a/arch/arm64/boot/dts/nvidia/tegra186.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
@@ -248,6 +248,9 @@
 		nvidia,pad-autocal-pull-down-offset-sdr104 = <0x05>;
 		nvidia,default-tap = <0x5>;
 		nvidia,default-trim = <0xb>;
+		assigned-clocks = <&bpmp TEGRA186_CLK_SDMMC1>,
+				  <&bpmp TEGRA186_CLK_PLLP_OUT0>;
+		assigned-clock-parents = <&bpmp TEGRA186_CLK_PLLP_OUT0>;
 		status = "disabled";
 	};
 
@@ -299,6 +302,9 @@
 		interrupts = <GIC_SPI 65 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&bpmp TEGRA186_CLK_SDMMC4>;
 		clock-names = "sdhci";
+		assigned-clocks = <&bpmp TEGRA186_CLK_SDMMC4>,
+				  <&bpmp TEGRA186_CLK_PLLC4_VCO>;
+		assigned-clock-parents = <&bpmp TEGRA186_CLK_PLLC4_VCO>;
 		resets = <&bpmp TEGRA186_RESET_SDMMC4>;
 		reset-names = "sdhci";
 		nvidia,pad-autocal-pull-up-offset-hs400 = <0x05>;
-- 
2.7.4
