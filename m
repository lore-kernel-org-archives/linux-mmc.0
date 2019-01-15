From: Sowjanya Komatineni <skomatineni@nvidia.com>
Subject: [PATCH V9 2/3] arm64: dts: tegra: Add CQE Support for SDMMC4
Date: Tue, 15 Jan 2019 11:03:51 -0800
Message-ID: <1547579032-18314-2-git-send-email-skomatineni@nvidia.com>
References: <1547579032-18314-1-git-send-email-skomatineni@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1547579032-18314-1-git-send-email-skomatineni@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: robh+dt@kernel.org, mark.rutland@arm.com, mperttunen@nvidia.com, chunyan.zhang@unisoc.com, thierry.reding@gmail.com, jonathanh@nvidia.com, adrian.hunter@intel.com, ulf.hansson@linaro.org
Cc: anrao@nvidia.com, devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, Sowjanya Komatineni <skomatineni@nvidia.com>
List-Id: linux-mmc@vger.kernel.org

Add CQE Support for Tegra186 and Tegra194 SDMMC4 controller

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra186.dtsi | 1 +
 arch/arm64/boot/dts/nvidia/tegra194.dtsi | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra186.dtsi b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
index 22815db4a3ed..3dfdc4701934 100644
--- a/arch/arm64/boot/dts/nvidia/tegra186.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
@@ -319,6 +319,7 @@
 		nvidia,default-trim = <0x9>;
 		nvidia,dqs-trim = <63>;
 		mmc-hs400-1_8v;
+		supports-cqe;
 		status = "disabled";
 	};
 
diff --git a/arch/arm64/boot/dts/nvidia/tegra194.dtsi b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
index 6dfa1ca0b851..9ce1c91d4596 100644
--- a/arch/arm64/boot/dts/nvidia/tegra194.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
@@ -325,6 +325,7 @@
 			clock-names = "sdhci";
 			resets = <&bpmp TEGRA194_RESET_SDMMC4>;
 			reset-names = "sdhci";
+			supports-cqe;
 			status = "disabled";
 		};
 
-- 
2.7.4
