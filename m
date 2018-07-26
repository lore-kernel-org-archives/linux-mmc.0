From: Aapo Vienamo <avienamo@nvidia.com>
Subject: [PATCH v2 10/10] arm64: dts: tegra186: Add nvidia,only-1-8-v to sdmmc4
Date: Thu, 26 Jul 2018 15:19:20 +0300
Message-ID: <1532607560-11253-11-git-send-email-avienamo@nvidia.com>
References: <1532607560-11253-1-git-send-email-avienamo@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1532607560-11253-1-git-send-email-avienamo@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, Adrian Hunter <adrian.hunter@intel.com>, Mikko Perttunen <mperttunen@nvidia.com>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, Aapo Vienamo <avienamo@nvidia.com>
List-Id: linux-mmc@vger.kernel.org

Mark sdmmc4 as 1.8 V only.

Signed-off-by: Aapo Vienamo <avienamo@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra186.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra186.dtsi b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
index 7669756..fc14dd3 100644
--- a/arch/arm64/boot/dts/nvidia/tegra186.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
@@ -279,6 +279,7 @@
 		clock-names = "sdhci";
 		resets = <&bpmp TEGRA186_RESET_SDMMC4>;
 		reset-names = "sdhci";
+		nvidia,only-1-8-v;
 		status = "disabled";
 	};
 
-- 
2.7.4
