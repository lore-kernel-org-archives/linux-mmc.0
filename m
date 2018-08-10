From: Aapo Vienamo <avienamo@nvidia.com>
Subject: [PATCH v2 38/40] arm64: dts: tegra186: Add SDHCI tap and trim values
Date: Fri, 10 Aug 2018 21:08:40 +0300
Message-ID: <1533924522-1037-39-git-send-email-avienamo@nvidia.com>
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
Tegra186.

Signed-off-by: Aapo Vienamo <avienamo@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra186.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra186.dtsi b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
index b7020dd..3b2fe0d 100644
--- a/arch/arm64/boot/dts/nvidia/tegra186.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
@@ -246,6 +246,8 @@
 		nvidia,pad-autocal-pull-down-offset-1v8-timeout = <0x07>;
 		nvidia,pad-autocal-pull-up-offset-sdr104 = <0x03>;
 		nvidia,pad-autocal-pull-down-offset-sdr104 = <0x05>;
+		nvidia,default-tap = <0x5>;
+		nvidia,default-trim = <0xb>;
 		status = "disabled";
 	};
 
@@ -264,6 +266,8 @@
 		nvidia,pad-autocal-pull-down-offset-3v3-timeout = <0x06>;
 		nvidia,pad-autocal-pull-up-offset-1v8-timeout = <0x07>;
 		nvidia,pad-autocal-pull-down-offset-1v8-timeout = <0x07>;
+		nvidia,default-tap = <0x5>;
+		nvidia,default-trim = <0xb>;
 		status = "disabled";
 	};
 
@@ -284,6 +288,8 @@
 		nvidia,pad-autocal-pull-down-offset-3v3-timeout = <0x06>;
 		nvidia,pad-autocal-pull-up-offset-1v8-timeout = <0x07>;
 		nvidia,pad-autocal-pull-down-offset-1v8-timeout = <0x07>;
+		nvidia,default-tap = <0x5>;
+		nvidia,default-trim = <0xb>;
 		status = "disabled";
 	};
 
@@ -299,6 +305,8 @@
 		nvidia,pad-autocal-pull-down-offset-hs400 = <0x05>;
 		nvidia,pad-autocal-pull-up-offset-1v8-timeout = <0x0a>;
 		nvidia,pad-autocal-pull-down-offset-1v8-timeout = <0x0a>;
+		nvidia,default-tap = <0x5>;
+		nvidia,default-trim = <0x9>;
 		status = "disabled";
 	};
 
-- 
2.7.4
