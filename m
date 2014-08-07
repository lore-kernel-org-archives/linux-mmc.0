From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCHv10 5/5] ARM: dts: rockchip: unuse the slot-node and deprecate
 the supports-highspeed for dw-mmc
Date: Thu, 07 Aug 2014 16:38:02 +0900
Message-ID: <1407397082-32495-6-git-send-email-jh80.chung@samsung.com>
References: <1407397082-32495-1-git-send-email-jh80.chung@samsung.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:47715 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754273AbaHGHiM (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 7 Aug 2014 03:38:12 -0400
In-reply-to: <1407397082-32495-1-git-send-email-jh80.chung@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc <linux-mmc@vger.kernel.org>
Cc: Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, tgih.jun@samsung.com, devicetree@vger.kernel.org, heiko@sntech.de, dinguyen@altera.com, Mark Rutland <mark.rutland@arm.com>, kgene.kim@samsung.com, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Jaehoon Chung <jh80.chung@samsung.com>

dw-mmc controller can support multiple slots.
But, there are no use-cases anywhere. So we don't need to support the
slot-node for dw-mmc controller.
And "supports-highspeed" property in dw-mmc is deprecated.
"supports-highspeed" property can be replaced with "cap-sd/mmc-highspeed".

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
Reviewed-by: Tushar Behera <trblinux@gmail.com>
Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
Reviewed-by: Heiko Stuebner <heiko@sntech.de>
Acked-by: Seungwon Jeon <tgih.jun@samsung.com>
---
 arch/arm/boot/dts/rk3066a-bqcurie2.dts |   15 ++++-----------
 arch/arm/boot/dts/rk3188-radxarock.dts |    7 ++-----
 2 files changed, 6 insertions(+), 16 deletions(-)

diff --git a/arch/arm/boot/dts/rk3066a-bqcurie2.dts b/arch/arm/boot/dts/rk3066a-bqcurie2.dts
index 042f821d..665dd56 100644
--- a/arch/arm/boot/dts/rk3066a-bqcurie2.dts
+++ b/arch/arm/boot/dts/rk3066a-bqcurie2.dts
@@ -150,12 +150,8 @@
 	num-slots = <1>;
 	status = "okay";
 	vmmc-supply = <&vcc_sd0>;
-
-	slot@0 {
-		reg = <0>;
-		bus-width = <4>;
-		disable-wp;
-	};
+	bus-width = <4>;
+	disable-wp;
 };
 
 &mmc1 { /* wifi */
@@ -166,11 +162,8 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&sd1_clk &sd1_cmd &sd1_bus4>;
 
-	slot@0 {
-		reg = <0>;
-		bus-width = <4>;
-		disable-wp;
-	};
+	bus-width = <4>;
+	disable-wp;
 };
 
 &uart0 {
diff --git a/arch/arm/boot/dts/rk3188-radxarock.dts b/arch/arm/boot/dts/rk3188-radxarock.dts
index 171b610..ef72faf 100644
--- a/arch/arm/boot/dts/rk3188-radxarock.dts
+++ b/arch/arm/boot/dts/rk3188-radxarock.dts
@@ -181,11 +181,8 @@
 	status = "okay";
 	vmmc-supply = <&vcc_sd0>;
 
-	slot@0 {
-		reg = <0>;
-		bus-width = <4>;
-		disable-wp;
-	};
+	bus-width = <4>;
+	disable-wp;
 };
 
 &pinctrl {
-- 
1.7.9.5

