From: Suman Tripathi <stripathi-qTEPVZfXA3Y@public.gmane.org>
Subject: [PATCH v6 1/2] arm64: dts: Add the arasan sdhci nodes in apm-storm.dtsi.
Date: Wed,  6 May 2015 19:12:10 +0530
Message-ID: <1430919731-9016-2-git-send-email-stripathi@apm.com>
References: <1430919731-9016-1-git-send-email-stripathi@apm.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1430919731-9016-1-git-send-email-stripathi-qTEPVZfXA3Y@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: chris-OsFVWbfNK3isTnJN9+BGXg@public.gmane.org, anton-9xeibp6oKSgdnm+yROfE0A@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org
Cc: linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, ddutile-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, jcm-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, mlangsdo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, patches-qTEPVZfXA3Y@public.gmane.org, Suman Tripathi <stripathi-qTEPVZfXA3Y@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

This patch adds the arasan sdhci nodes to reuse the of-arasan
driver for APM X-Gene SoC.

Signed-off-by: Suman Tripathi <stripathi-qTEPVZfXA3Y@public.gmane.org>
---
 arch/arm64/boot/dts/apm/apm-mustang.dts |  4 +++
 arch/arm64/boot/dts/apm/apm-storm.dtsi  | 43 +++++++++++++++++++++++++++++++++
 2 files changed, 47 insertions(+)

diff --git a/arch/arm64/boot/dts/apm/apm-mustang.dts b/arch/arm64/boot/dts/apm/apm-mustang.dts
index 83578e7..7ccd517 100644
--- a/arch/arm64/boot/dts/apm/apm-mustang.dts
+++ b/arch/arm64/boot/dts/apm/apm-mustang.dts
@@ -52,3 +52,7 @@
 &xgenet {
 	status = "ok";
 };
+
+&sdhci0 {
+	status = "ok";
+};
diff --git a/arch/arm64/boot/dts/apm/apm-storm.dtsi b/arch/arm64/boot/dts/apm/apm-storm.dtsi
index c8d3e0e..b5d2698 100644
--- a/arch/arm64/boot/dts/apm/apm-storm.dtsi
+++ b/arch/arm64/boot/dts/apm/apm-storm.dtsi
@@ -145,6 +145,40 @@
 				clock-output-names = "socplldiv2";
 			};

+			ahbclk: ahbclk@1f2ac000 {
+				compatible = "apm,xgene-device-clock";
+				#clock-cells = <1>;
+				clocks = <&socplldiv2 0>;
+				reg = <0x0 0x1f2ac000 0x0 0x1000
+					0x0 0x17000000 0x0 0x2000>;
+				reg-names = "csr-reg", "div-reg";
+				csr-offset = <0x0>;
+				csr-mask = <0x1>;
+				enable-offset = <0x8>;
+				enable-mask = <0x1>;
+				divider-offset = <0x164>;
+				divider-width = <0x5>;
+				divider-shift = <0x0>;
+				clock-output-names = "ahbclk";
+			};
+
+			sdioclk: sdioclk@1f2ac000 {
+				compatible = "apm,xgene-device-clock";
+				#clock-cells = <1>;
+				clocks = <&socplldiv2 0>;
+				reg = <0x0 0x1f2ac000 0x0 0x1000
+					0x0 0x17000000 0x0 0x2000>;
+				reg-names = "csr-reg", "div-reg";
+				csr-offset = <0x0>;
+				csr-mask = <0x2>;
+				enable-offset = <0x8>;
+				enable-mask = <0x2>;
+				divider-offset = <0x178>;
+				divider-width = <0x8>;
+				divider-shift = <0x0>;
+				clock-output-names = "sdioclk";
+			};
+
 			qmlclk: qmlclk {
 				compatible = "apm,xgene-device-clock";
 				#clock-cells = <1>;
@@ -533,6 +567,15 @@
 			interrupts = <0x0 0x4f 0x4>;
 		};

+		sdhci0: sdhci@1c000000 {
+			compatible = "arasan,sdhci-4.9a";
+			reg = <0x0 0x1c000000 0x0 0x100>;
+			interrupts = <0x0 0x49 0x4>;
+			dma-coherent;
+			clock-names = "clk_xin", "clk_ahb";
+			clocks = <&sdioclk 0>, <&ahbclk 0>;
+		};
+
 		phy1: phy@1f21a000 {
 			compatible = "apm,xgene-phy";
 			reg = <0x0 0x1f21a000 0x0 0x100>;
--
1.8.2.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
