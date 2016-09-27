From: Ziyuan Xu <xzy.xu-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: [PATCH v4 2/2] arm64: dts: rockchip: add eMMC's power domain support for rk3399
Date: Tue, 27 Sep 2016 14:15:58 +0800
Message-ID: <20160927061558.2110-3-xzy.xu@rock-chips.com>
References: <20160927061558.2110-1-xzy.xu@rock-chips.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160927061558.2110-1-xzy.xu-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org, ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org, dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, zhangqing-TNX95d0MmH7DzftRWevZcw@public.gmane.org, Ziyuan Xu <xzy.xu-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

Control power domain for eMMC via genpd to reduce power consumption.

Signed-off-by: Elaine Zhang <zhangqing-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Signed-off-by: Ziyuan Xu <xzy.xu-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Reviewed-by: Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Reviewed-by: Douglas Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>

---

Changes in v4: None
Changes in v3: None
Changes in v2:
- add Shawn's review-tag and Doug's review-tag

 arch/arm64/boot/dts/rockchip/rk3399.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
index 76b2864..13905ce 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
@@ -269,6 +269,7 @@
 		#clock-cells = <0>;
 		phys = <&emmc_phy>;
 		phy-names = "phy_arasan";
+		power-domains = <&power RK3399_PD_EMMC>;
 		status = "disabled";
 	};
 
@@ -690,6 +691,11 @@
 		status = "disabled";
 	};
 
+	qos_emmc: qos@ffa58000 {
+		compatible = "syscon";
+		reg = <0x0 0xffa58000 0x0 0x20>;
+	};
+
 	qos_gmac: qos@ffa5c000 {
 		compatible = "syscon";
 		reg = <0x0 0xffa5c000 0x0 0x20>;
@@ -823,6 +829,11 @@
 			};
 
 			/* These power domains are grouped by VD_LOGIC */
+			pd_emmc@RK3399_PD_EMMC {
+				reg = <RK3399_PD_EMMC>;
+				clocks = <&cru ACLK_EMMC>;
+				pm_qos = <&qos_emmc>;
+			};
 			pd_gmac@RK3399_PD_GMAC {
 				reg = <RK3399_PD_GMAC>;
 				clocks = <&cru ACLK_GMAC>;
-- 
2.9.3


--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
