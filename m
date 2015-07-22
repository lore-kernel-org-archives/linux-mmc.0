From: Dong Aisheng <aisheng.dong@freescale.com>
Subject: [PATCH V2 01/11] dts: imx51: fix sd card gpio polarity specified in device tree
Date: Wed, 22 Jul 2015 20:53:00 +0800
Message-ID: <1437569590-5228-2-git-send-email-aisheng.dong@freescale.com>
References: <1437569590-5228-1-git-send-email-aisheng.dong@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bn1bon0115.outbound.protection.outlook.com ([157.56.111.115]:61856
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751589AbbGVODG (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 22 Jul 2015 10:03:06 -0400
In-Reply-To: <1437569590-5228-1-git-send-email-aisheng.dong@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: fabio.estevam@freescale.com, marex@denx.de, ulf.hansson@linaro.org, s.trumtrar@pengutronix.de, smoch@web.de, linux-arm-kernel@lists.infradead.org, robertcnelson@gmail.com, s.hauer@pengutronix.de, chris@printf.net, rabeeh@solid-run.com, troy.kisky@boundarydevices.com, lisovy@gmail.com, hs@denx.de, gwenhael.goavec-merou@armadeus.com, p.zabel@pengutronix.de, rmk+kernel@arm.linux.org.uk, shawn.guo@linaro.org, b29396@freescale.com, tharvey@gateworks.com, LW@KARO-electronics.de, ipaton0@gmail.com

cd-gpios polarity should be changed to GPIO_ACTIVE_LOW and wp-gpios
should be changed to GPIO_ACTIVE_HIGH.
Otherwise, the SD may not work properly due to wrong polarity inversion
specified in DT after switch to common parsing function mmc_of_parse().

Signed-off-by: Dong Aisheng <aisheng.dong@freescale.com>
---
 arch/arm/boot/dts/imx51-apf51dev.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx51-apf51dev.dts b/arch/arm/boot/dts/imx51-apf51dev.dts
index 93d3ea1..0f3fe29 100644
--- a/arch/arm/boot/dts/imx51-apf51dev.dts
+++ b/arch/arm/boot/dts/imx51-apf51dev.dts
@@ -98,7 +98,7 @@
 &esdhc1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_esdhc1>;
-	cd-gpios = <&gpio2 29 GPIO_ACTIVE_HIGH>;
+	cd-gpios = <&gpio2 29 GPIO_ACTIVE_LOW>;
 	bus-width = <4>;
 	status = "okay";
 };
-- 
1.9.1

