From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: [PATCH 08/14] ARM: sunxi: dt: Switch to the new mbus compatible
Date: Thu, 17 Jul 2014 11:08:48 +0200
Message-ID: <1405588134-2396-9-git-send-email-maxime.ripard@free-electrons.com>
References: <1405588134-2396-1-git-send-email-maxime.ripard@free-electrons.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:41352 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755554AbaGQJKM (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 17 Jul 2014 05:10:12 -0400
In-Reply-To: <1405588134-2396-1-git-send-email-maxime.ripard@free-electrons.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Mike Turquette <mturquette@linaro.org>, Hans de Goede <hdegoede@redhat.com>, Emilio Lopez <emilio@elopez.com.ar>, chris@printf.net, david.lanzendoerfer@o2s.ch, ulf.hansson@linaro.org
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, Maxime Ripard <maxime.ripard@free-electrons.com>

Now that we have a compatible of its own for the mbus clock, switch to it.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/sun5i-a10s.dtsi | 2 +-
 arch/arm/boot/dts/sun5i-a13.dtsi  | 2 +-
 arch/arm/boot/dts/sun7i-a20.dtsi  | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/sun5i-a10s.dtsi b/arch/arm/boot/dts/sun5i-a10s.dtsi
index 24b0ad3a7c07..d6446b71a333 100644
--- a/arch/arm/boot/dts/sun5i-a10s.dtsi
+++ b/arch/arm/boot/dts/sun5i-a10s.dtsi
@@ -287,7 +287,7 @@
 
 		mbus_clk: clk@01c2015c {
 			#clock-cells = <0>;
-			compatible = "allwinner,sun4i-a10-mod0-clk";
+			compatible = "allwinner,sun4i-a10-mbus-clk";
 			reg = <0x01c2015c 0x4>;
 			clocks = <&osc24M>, <&pll6 1>, <&pll5 1>;
 			clock-output-names = "mbus";
diff --git a/arch/arm/boot/dts/sun5i-a13.dtsi b/arch/arm/boot/dts/sun5i-a13.dtsi
index de89edc5e5b3..684576cb0f37 100644
--- a/arch/arm/boot/dts/sun5i-a13.dtsi
+++ b/arch/arm/boot/dts/sun5i-a13.dtsi
@@ -286,7 +286,7 @@
 
 		mbus_clk: clk@01c2015c {
 			#clock-cells = <0>;
-			compatible = "allwinner,sun4i-a10-mod0-clk";
+			compatible = "allwinner,sun4i-a10-mbus-clk";
 			reg = <0x01c2015c 0x4>;
 			clocks = <&osc24M>, <&pll6 1>, <&pll5 1>;
 			clock-output-names = "mbus";
diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
index 4011628c7381..e87d29e52b66 100644
--- a/arch/arm/boot/dts/sun7i-a20.dtsi
+++ b/arch/arm/boot/dts/sun7i-a20.dtsi
@@ -346,7 +346,7 @@
 
 		mbus_clk: clk@01c2015c {
 			#clock-cells = <0>;
-			compatible = "allwinner,sun4i-a10-mod0-clk";
+			compatible = "allwinner,sun4i-a10-mbus-clk";
 			reg = <0x01c2015c 0x4>;
 			clocks = <&osc24M>, <&pll6 2>, <&pll5 1>;
 			clock-output-names = "mbus";
-- 
2.0.1

