From: Aapo Vienamo <avienamo@nvidia.com>
Subject: [PATCH v2 32/40] arm64: dts: tegra210-p2180: Allow ldo2 to go down to 1.8 V
Date: Fri, 10 Aug 2018 21:08:34 +0300
Message-ID: <1533924522-1037-33-git-send-email-avienamo@nvidia.com>
References: <1533924522-1037-1-git-send-email-avienamo@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1533924522-1037-1-git-send-email-avienamo@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Mikko Perttunen <mperttunen@nvidia.com>, Stefan Agner <stefan@agner.ch>
Cc: devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, Aapo Vienamo <avienamo@nvidia.com>
List-Id: linux-mmc@vger.kernel.org

Set regulator-min-microvolt property of ldo2 to 1.8 V in
tegra210-p2180.dtsi. ldo2 is used by the sdmmc1 SDHCI controller and its
voltage needs to be adjusted down to 1.8 V to support faster signaling
modes. It appears that the comment about the SDHCI driver requesting
invalid voltages no longer applies.

Signed-off-by: Aapo Vienamo <avienamo@nvidia.com>
Reviewed-by: Mikko Perttunen <mperttunen@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra210-p2180.dtsi | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/arch/arm64/boot/dts/nvidia/tegra210-p2180.dtsi b/arch/arm64/boot/dts/nvidia/tegra210-p2180.dtsi
index 212e663..8496101 100644
--- a/arch/arm64/boot/dts/nvidia/tegra210-p2180.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra210-p2180.dtsi
@@ -178,16 +178,7 @@
 
 				vddio_sdmmc: ldo2 {
 					regulator-name = "VDDIO_SDMMC";
-					/*
-					 * Technically this supply should have
-					 * a supported range from 1.8 - 3.3 V.
-					 * However, that would cause the SDHCI
-					 * driver to request 2.7 V upon access
-					 * and that in turn will cause traffic
-					 * to be broken. Leave it at 3.3 V for
-					 * now.
-					 */
-					regulator-min-microvolt = <3300000>;
+					regulator-min-microvolt = <1800000>;
 					regulator-max-microvolt = <3300000>;
 					regulator-always-on;
 					regulator-boot-on;
-- 
2.7.4
