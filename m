From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH 1/2] ARM: dts: am571x-idk: Fix GPIO polarity for MMC1 card detect
Date: Tue, 8 Aug 2017 10:50:56 +0530
Message-ID: <20170808052057.24433-1-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from fllnx209.ext.ti.com ([198.47.19.16]:60874 "EHLO
        fllnx209.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750849AbdHHFVz (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 8 Aug 2017 01:21:55 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Russell King <linux@armlinux.org.uk>, Ulf Hansson <ulf.hansson@linaro.org>, kishon@ti.com, nsekhar@ti.com, linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org

The GPIO polarity for MMC1 card detect is set to '0' which means
active-high. However the polarity should be active-low. Fix it
here.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 arch/arm/boot/dts/am571x-idk.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/am571x-idk.dts b/arch/arm/boot/dts/am571x-idk.dts
index 7b207835b2d1..adc70fb091a2 100644
--- a/arch/arm/boot/dts/am571x-idk.dts
+++ b/arch/arm/boot/dts/am571x-idk.dts
@@ -68,7 +68,7 @@
 	status = "okay";
 	vmmc-supply = <&ldo1_reg>;
 	bus-width = <4>;
-	cd-gpios = <&gpio6 27 0>; /* gpio 219 */
+	cd-gpios = <&gpio6 27 GPIO_ACTIVE_LOW>; /* gpio 219 */
 };
 
 &omap_dwc3_2 {
-- 
2.11.0

