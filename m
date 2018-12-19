From: Sowjanya Komatineni <skomatineni@nvidia.com>
Subject: [PATCH V4 3/4] arm64: dtsi: Fix SDMMC address range
Date: Wed, 19 Dec 2018 15:42:17 -0800
Message-ID: <1545262938-20636-4-git-send-email-skomatineni@nvidia.com>
References: <1545262938-20636-1-git-send-email-skomatineni@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1545262938-20636-1-git-send-email-skomatineni@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: robh+dt@kernel.org, mark.rutland@arm.com, mperttunen@nvidia.com, thierry.reding@gmail.com, jonathanh@nvidia.com, adrian.hunter@intel.com, ulf.hansson@linaro.org
Cc: devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, Sowjanya Komatineni <skomatineni@nvidia.com>
List-Id: linux-mmc@vger.kernel.org

This patch fixes the SDMMC Controllers address space to be exact
defined register address range as per the design.

SDMMC Controller supporting Command Queue has CQHCI registers at
offset 0xF000.

This fix helps to identify the Tegra SDMMC Controllers supporting
Command Queue based on the size of address space.

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra186.dtsi | 6 +++---
 arch/arm64/boot/dts/nvidia/tegra194.dtsi | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/boot/dts/nvidia/tegra186.dtsi b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
index 2f3c8e29520d..6fda3d6a7f3d 100644
--- a/arch/arm64/boot/dts/nvidia/tegra186.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
@@ -231,7 +231,7 @@
 
 	sdmmc1: sdhci@3400000 {
 		compatible = "nvidia,tegra186-sdhci";
-		reg = <0x0 0x03400000 0x0 0x10000>;
+		reg = <0x0 0x03400000 0x0 0x220>;
 		interrupts = <GIC_SPI 62 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&bpmp TEGRA186_CLK_SDMMC1>;
 		clock-names = "sdhci";
@@ -256,7 +256,7 @@
 
 	sdmmc2: sdhci@3420000 {
 		compatible = "nvidia,tegra186-sdhci";
-		reg = <0x0 0x03420000 0x0 0x10000>;
+		reg = <0x0 0x03420000 0x0 0x220>;
 		interrupts = <GIC_SPI 63 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&bpmp TEGRA186_CLK_SDMMC2>;
 		clock-names = "sdhci";
@@ -276,7 +276,7 @@
 
 	sdmmc3: sdhci@3440000 {
 		compatible = "nvidia,tegra186-sdhci";
-		reg = <0x0 0x03440000 0x0 0x10000>;
+		reg = <0x0 0x03440000 0x0 0x220>;
 		interrupts = <GIC_SPI 64 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&bpmp TEGRA186_CLK_SDMMC3>;
 		clock-names = "sdhci";
diff --git a/arch/arm64/boot/dts/nvidia/tegra194.dtsi b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
index c2091bb16546..6510ef6492b1 100644
--- a/arch/arm64/boot/dts/nvidia/tegra194.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
@@ -295,7 +295,7 @@
 
 		sdmmc1: sdhci@3400000 {
 			compatible = "nvidia,tegra194-sdhci", "nvidia,tegra186-sdhci";
-			reg = <0x03400000 0x10000>;
+			reg = <0x03400000 0x220>;
 			interrupts = <GIC_SPI 62 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&bpmp TEGRA194_CLK_SDMMC1>;
 			clock-names = "sdhci";
@@ -306,7 +306,7 @@
 
 		sdmmc3: sdhci@3440000 {
 			compatible = "nvidia,tegra194-sdhci", "nvidia,tegra186-sdhci";
-			reg = <0x03440000 0x10000>;
+			reg = <0x03440000 0x220>;
 			interrupts = <GIC_SPI 64 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&bpmp TEGRA194_CLK_SDMMC3>;
 			clock-names = "sdhci";
-- 
2.7.4
