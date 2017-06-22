From: Frank Wang <frank.wang@rock-chips.com>
Subject: [RESEND PATCH v2 1/7] ARM: dts: rockchip: add cpu enable method for rk3228 SoC
Date: Thu, 22 Jun 2017 18:29:56 +0800
Message-ID: <1498127402-6705-2-git-send-email-frank.wang@rock-chips.com>
References: <1498127402-6705-1-git-send-email-frank.wang@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1498127402-6705-1-git-send-email-frank.wang@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: heiko@sntech.de, robh+dt@kernel.org, ulf.hansson@linaro.org, mark.rutland@arm.com
Cc: linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, charles.chen@rock-chips.com, kevan.lan@rock-chips.com, huangtao@rock-chips.com, finley.xiao@rock-chips.com, david.wu@rock-chips.com, shawn.lin@rock-chips.com, wmc@rock-chips.com, Frank Wang <frank.wang@rock-chips.com>
List-Id: linux-mmc@vger.kernel.org

This patch sets PSCI as the default cpu enable-method for RK3228 SoC.

Signed-off-by: Frank Wang <frank.wang@rock-chips.com>
---
 arch/arm/boot/dts/rk322x.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/rk322x.dtsi b/arch/arm/boot/dts/rk322x.dtsi
index 31e04e9..34d175e 100644
--- a/arch/arm/boot/dts/rk322x.dtsi
+++ b/arch/arm/boot/dts/rk322x.dtsi
@@ -70,6 +70,7 @@
 			#cooling-cells = <2>; /* min followed by max */
 			clock-latency = <40000>;
 			clocks = <&cru ARMCLK>;
+			enable-method = "psci";
 		};
 
 		cpu1: cpu@f01 {
@@ -78,6 +79,7 @@
 			reg = <0xf01>;
 			resets = <&cru SRST_CORE1>;
 			operating-points-v2 = <&cpu0_opp_table>;
+			enable-method = "psci";
 		};
 
 		cpu2: cpu@f02 {
@@ -86,6 +88,7 @@
 			reg = <0xf02>;
 			resets = <&cru SRST_CORE2>;
 			operating-points-v2 = <&cpu0_opp_table>;
+			enable-method = "psci";
 		};
 
 		cpu3: cpu@f03 {
@@ -94,6 +97,7 @@
 			reg = <0xf03>;
 			resets = <&cru SRST_CORE3>;
 			operating-points-v2 = <&cpu0_opp_table>;
+			enable-method = "psci";
 		};
 	};
 
@@ -151,6 +155,11 @@
 		interrupt-affinity = <&cpu0>, <&cpu1>, <&cpu2>, <&cpu3>;
 	};
 
+	psci {
+		compatible = "arm,psci-1.0", "arm,psci-0.2";
+		method = "smc";
+	};
+
 	timer {
 		compatible = "arm,armv7-timer";
 		arm,cpu-registers-not-fw-configured;
-- 
2.0.0
