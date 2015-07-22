From: Dong Aisheng <aisheng.dong@freescale.com>
Subject: [PATCH V2 04/11] dts: imx25: fix sd card gpio polarity specified in device tree
Date: Wed, 22 Jul 2015 20:53:03 +0800
Message-ID: <1437569590-5228-5-git-send-email-aisheng.dong@freescale.com>
References: <1437569590-5228-1-git-send-email-aisheng.dong@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bn1bn0103.outbound.protection.outlook.com ([157.56.110.103]:43330
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756699AbbGVODY (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 22 Jul 2015 10:03:24 -0400
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
 arch/arm/boot/dts/imx25-pdk.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx25-pdk.dts b/arch/arm/boot/dts/imx25-pdk.dts
index dd45e69..faf252f 100644
--- a/arch/arm/boot/dts/imx25-pdk.dts
+++ b/arch/arm/boot/dts/imx25-pdk.dts
@@ -114,8 +114,8 @@
 &esdhc1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_esdhc1>;
-	cd-gpios = <&gpio2 1 0>;
-	wp-gpios = <&gpio2 0 0>;
+	cd-gpios = <&gpio2 1 GPIO_ACTIVE_LOW>;
+	wp-gpios = <&gpio2 0 GPIO_ACTIVE_HIGH>;
 	status = "okay";
 };
 
-- 
1.9.1

