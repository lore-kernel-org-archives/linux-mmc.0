From: Frank Wang <frank.wang-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: [PATCH v2 1/7] ARM: dts: rockchip: add cpu enable method for rk3228 SoC
Date: Thu, 22 Jun 2017 15:20:49 +0800
Message-ID: <1498116055-20977-2-git-send-email-frank.wang@rock-chips.com>
References: <1498116055-20977-1-git-send-email-frank.wang@rock-chips.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1498116055-20977-1-git-send-email-frank.wang-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, charles.chen-TNX95d0MmH7DzftRWevZcw@public.gmane.org, kevan.lan-TNX95d0MmH7DzftRWevZcw@public.gmane.org, huangtao-TNX95d0MmH7DzftRWevZcw@public.gmane.org, finley.xiao-TNX95d0MmH7DzftRWevZcw@public.gmane.org, david.wu-TNX95d0MmH7DzftRWevZcw@public.gmane.org, shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org, chenjh-TNX95d0MmH7DzftRWevZcw@public.gmane.org, wmc-TNX95d0MmH7DzftRWevZcw@public.gmane.org, Frank Wang <frank.wang-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

This patch sets PSCI as the default cpu enable-method for RK3228 SoC.

Signed-off-by: Frank Wang <frank.wang-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
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


--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
