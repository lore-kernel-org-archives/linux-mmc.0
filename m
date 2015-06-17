From: Dong Aisheng <aisheng.dong@freescale.com>
Subject: [PATCH 5/5] dts: imx7: fix sd card gpio polarity specified in device tree
Date: Thu, 18 Jun 2015 01:33:38 +0800
Message-ID: <1434562418-24090-6-git-send-email-aisheng.dong@freescale.com>
References: <1434562418-24090-1-git-send-email-aisheng.dong@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bn1bn0103.outbound.protection.outlook.com ([157.56.110.103]:55456
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756534AbbFQRgd (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 17 Jun 2015 13:36:33 -0400
In-Reply-To: <1434562418-24090-1-git-send-email-aisheng.dong@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org, chris@printf.net, shawn.guo@linaro.org, b29396@freescale.com, fabio.estevam@freescale.com, gwenhael.goavec-merou@armadeus.com, marex@denx.de, s.trumtrar@pengutronix.de, s.hauer@pengutronix.de, lisovy@gmail.com, ipaton0@gmail.com, smoch@web.de, hs@denx.de, rmk+kernel@arm.linux.org.uk, tharvey@gateworks.com, rabeeh@solid-run.com, troy.kisky@boundarydevices.com, p.zabel@pengutronix.de, robertcnelson@gmail.com, LW@KARO-electronics.de, linux-arm-kernel@lists.infradead.org

cd-gpios polarity should be changed to GPIO_ACTIVE_LOW and wp-gpios
should be changed to GPIO_ACTIVE_HIGH.
Otherwise, the SD may not work properly due to wrong polarity inversion
specified in DT after switch to common parsing function mmc_of_parse().

Signed-off-by: Dong Aisheng <aisheng.dong@freescale.com>
---
 arch/arm/boot/dts/imx7d-sdb.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx7d-sdb.dts b/arch/arm/boot/dts/imx7d-sdb.dts
index 4d1a4b9..fdd1d7c 100644
--- a/arch/arm/boot/dts/imx7d-sdb.dts
+++ b/arch/arm/boot/dts/imx7d-sdb.dts
@@ -234,8 +234,8 @@
 &usdhc1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_usdhc1>;
-	cd-gpios = <&gpio5 0 0>;
-	wp-gpios = <&gpio5 1 0>;
+	cd-gpios = <&gpio5 0 GPIO_ACTIVE_LOW>;
+	wp-gpios = <&gpio5 1 GPIO_ACTIVE_HIGH>;
 	enable-sdio-wakeup;
 	keep-power-in-suspend;
 	status = "okay";
-- 
1.9.1

