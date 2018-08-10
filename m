From: Aapo Vienamo <avienamo@nvidia.com>
Subject: [PATCH v2 37/40] arm64: dts: tegra210: Add SDHCI tap and trim values
Date: Fri, 10 Aug 2018 21:08:39 +0300
Message-ID: <1533924522-1037-38-git-send-email-avienamo@nvidia.com>
References: <1533924522-1037-1-git-send-email-avienamo@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1533924522-1037-1-git-send-email-avienamo@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Mikko Perttunen <mperttunen@nvidia.com>, Stefan Agner <stefan@agner.ch>
Cc: devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, Aapo Vienamo <avienamo@nvidia.com>
List-Id: linux-mmc@vger.kernel.org

Add SDHCI inbound and outbound SDHCI sampling trimmer values for
Tegra210.

Signed-off-by: Aapo Vienamo <avienamo@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra210.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra210.dtsi b/arch/arm64/boot/dts/nvidia/tegra210.dtsi
index 2a80f2b..0951acc 100644
--- a/arch/arm64/boot/dts/nvidia/tegra210.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra210.dtsi
@@ -1055,6 +1055,8 @@
 		nvidia,pad-autocal-pull-down-offset-3v3 = <0x7d>;
 		nvidia,pad-autocal-pull-up-offset-1v8 = <0x7b>;
 		nvidia,pad-autocal-pull-down-offset-1v8 = <0x7b>;
+		nvidia,default-tap = <0x2>;
+		nvidia,default-trim = <0x4>;
 		status = "disabled";
 	};
 
@@ -1068,6 +1070,8 @@
 		reset-names = "sdhci";
 		nvidia,pad-autocal-pull-up-offset-1v8 = <0x05>;
 		nvidia,pad-autocal-pull-down-offset-1v8 = <0x05>;
+		nvidia,default-tap = <0x8>;
+		nvidia,default-trim = <0x0>;
 		status = "disabled";
 	};
 
@@ -1086,6 +1090,8 @@
 		nvidia,pad-autocal-pull-down-offset-3v3 = <0x7d>;
 		nvidia,pad-autocal-pull-up-offset-1v8 = <0x7b>;
 		nvidia,pad-autocal-pull-down-offset-1v8 = <0x7b>;
+		nvidia,default-tap = <0x3>;
+		nvidia,default-trim = <0x3>;
 		status = "disabled";
 	};
 
@@ -1099,6 +1105,8 @@
 		reset-names = "sdhci";
 		nvidia,pad-autocal-pull-up-offset-1v8 = <0x05>;
 		nvidia,pad-autocal-pull-down-offset-1v8 = <0x05>;
+		nvidia,default-tap = <0x8>;
+		nvidia,default-trim = <0x0>;
 		status = "disabled";
 	};
 
-- 
2.7.4
