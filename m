From: Suman Tripathi <stripathi@apm.com>
Subject: [PATCH v3 1/3] arm64: dts: Add the arasan sdhc nodes in apm-storm.dtsi.
Date: Fri,  1 May 2015 10:24:10 +0530
Message-ID: <1430456052-8888-2-git-send-email-stripathi@apm.com>
References: <1430456052-8888-1-git-send-email-stripathi@apm.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from denmail01-v4020.amcc.com ([192.195.68.30]:42702 "EHLO
	denmail01.amcc.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750838AbbEAEzk (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 1 May 2015 00:55:40 -0400
In-Reply-To: <1430456052-8888-1-git-send-email-stripathi@apm.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: chris@printf.net, anton@enomsg.org, arnd@arndb.de, michal.simek@xilinx.com
Cc: linux-mmc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, ddutile@redhat.com, jcm@redhat.com, mlangsdo@redhat.com, patches@apm.com, Suman Tripathi <stripathi@apm.com>

This patch adds the arasan sdhc nodes to reuse the of-arasan
driver for APM X-Gene SoC.

Signed-off-by: Suman Tripathi <stripathi@apm.com>
---
 arch/arm64/boot/dts/apm-mustang.dts |  4 ++++
 arch/arm64/boot/dts/apm-storm.dtsi  | 44 +++++++++++++++++++++++++++++++++++++
 2 files changed, 48 insertions(+)

diff --git a/arch/arm64/boot/dts/apm-mustang.dts b/arch/arm64/boot/dts/apm-mustang.dts
index 8eb6d94..d0e52a9 100644
--- a/arch/arm64/boot/dts/apm-mustang.dts
+++ b/arch/arm64/boot/dts/apm-mustang.dts
@@ -44,3 +44,7 @@
 &xgenet {
 	status = "ok";
 };
+
+&sdhc0 {
+	status = "ok";
+};
diff --git a/arch/arm64/boot/dts/apm-storm.dtsi b/arch/arm64/boot/dts/apm-storm.dtsi
index 87d3205..d6c2216 100644
--- a/arch/arm64/boot/dts/apm-storm.dtsi
+++ b/arch/arm64/boot/dts/apm-storm.dtsi
@@ -144,6 +144,40 @@
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
@@ -503,6 +537,16 @@
 			interrupts = <0x0 0x4f 0x4>;
 		};

+		sdhc0: sdhc@1c000000 {
+			device_type = "sdhc";
+			compatible = "arasan,sdhci-8.9a", "arasan,sdhci-4.9a";
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

