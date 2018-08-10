From: Aapo Vienamo <avienamo@nvidia.com>
Subject: [PATCH v2 7/8] arm64: dts: tegra186: Enable HS400
Date: Fri, 10 Aug 2018 21:14:04 +0300
Message-ID: <1533924845-1466-8-git-send-email-avienamo@nvidia.com>
References: <1533924845-1466-1-git-send-email-avienamo@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1533924845-1466-1-git-send-email-avienamo@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, Adrian Hunter <adrian.hunter@intel.com>, Mikko Perttunen <mperttunen@nvidia.com>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, Aapo Vienamo <avienamo@nvidia.com>
List-Id: linux-mmc@vger.kernel.org

Enable HS400 signaling on Tegra186 SDMMC4 controller.

Signed-off-by: Aapo Vienamo <avienamo@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra186.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra186.dtsi b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
index 9e07bc6..2f3c8e2 100644
--- a/arch/arm64/boot/dts/nvidia/tegra186.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
@@ -314,6 +314,7 @@
 		nvidia,default-tap = <0x5>;
 		nvidia,default-trim = <0x9>;
 		nvidia,dqs-trim = <63>;
+		mmc-hs400-1_8v;
 		status = "disabled";
 	};
 
-- 
2.7.4
