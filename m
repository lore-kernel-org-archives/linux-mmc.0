From: Sowjanya Komatineni <skomatineni@nvidia.com>
Subject: [PATCH V1 1/2] arm64: tegra: fix default tap and trim values
Date: Thu, 11 Apr 2019 12:37:53 -0700
Message-ID: <1555011474-20107-1-git-send-email-skomatineni@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: adrian.hunter@intel.com, ulf.hansson@linaro.org, catalin.marinas@arm.com, will.deacon@arm.com, robh+dt@kernel.org, mark.rutland@arm.com, riteshh@codeaurora.org
Cc: skomatineni@nvidia.com, thierry.reding@gmail.com, jonathanh@nvidia.com, anrao@nvidia.com, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

Default tap and trim values are incorrect for Tegra186 SDMMC4.
This patch fixes it.

Tested-by: Jon Hunter <jonathanh@nvidia.com>
Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra186.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/nvidia/tegra186.dtsi b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
index 97aeb946ed5e..472f55fe9488 100644
--- a/arch/arm64/boot/dts/nvidia/tegra186.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
@@ -317,8 +317,8 @@
 		nvidia,pad-autocal-pull-down-offset-1v8-timeout = <0x0a>;
 		nvidia,pad-autocal-pull-up-offset-3v3-timeout = <0x0a>;
 		nvidia,pad-autocal-pull-down-offset-3v3-timeout = <0x0a>;
-		nvidia,default-tap = <0x5>;
-		nvidia,default-trim = <0x9>;
+		nvidia,default-tap = <0x9>;
+		nvidia,default-trim = <0x5>;
 		nvidia,dqs-trim = <63>;
 		mmc-hs400-1_8v;
 		status = "disabled";
-- 
2.7.4
